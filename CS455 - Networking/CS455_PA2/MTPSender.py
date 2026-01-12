# TODO: Finish Documentation
# TODO: Add command line arguments for input file, server IP, port, log file
# TODO: Handle edge cases and errors more gracefully
    # Connection ACK Lost
    # Termination ACK Lost
# TODO: Reformat Log Messages for consistency

import socket
import queue
import threading
import struct
import zlib
import unreliable_channel
import sys

# Global variables
next_seq = 0


packet_dict = dict()                    # Saves Packets for retransmission
packet_queue = queue.PriorityQueue()    # Packet Queue for sending
packet_lock = threading.Lock()          # Mutex for packet queue
packet_cond = threading.Condition(packet_lock)
num_packets = 0                         # Total number of packets to send
max_seq = 0                             # Max sequence number
last_acked_seq = -1                     # Last acknowledged sequence number



# Sliding window controls
window_base = 0                   # lowest unacknowledged seq
window_size = 0                   # set in main()
window_map = {}                   # seq → {"sent": bool, "acked": bool}
window_lock = threading.Lock()          # Mutex for window
window_cond = threading.Condition(window_lock)


SEG_SIZE = 1024                         # Size of each data segment
TIMEOUT = 0.5                           # Timeout duration in seconds


log_f = None                           # Log file handle
log_lock = threading.Lock()            # Mutex for logging


# Register Packet for sending
def register_next_packet(packet):
    global packet_queue     # get packet queue
    seqNum = struct.unpack('>II', packet[:8])[1]    # extract seq number for priority
    if (seqNum, packet) in packet_queue.queue:
        return
    with packet_cond:
        packet_queue.put( (seqNum, packet) )        # add packet to priority queue
        packet_cond.notify()                        # notify sender thread

# Get next packet to send
def get_next_packet():                              
    global packet_queue             # get packet queue
    with packet_cond:
        while packet_queue.empty(): # wait for packet
            packet_cond.wait()
        packet = packet_queue.get() # get packet from queue
        return packet               # return packet


# Register Packet for retransmission
def retransmit_packet(seq, sock, addr):
    global packet_dict
    if seq not in packet_dict:
        log_message(f"Cannot retransmit Packet: Seq={seq} not found")
        return
    if seq < last_acked_seq:
        log_message(f"Cannot retransmit Packet: Seq={seq} already acknowledged")
        return
    packet = packet_dict[seq]           # get packet from dict
    info = extract_packet_info(packet)  # extract info for log
    if packet:
        unreliable_channel.send_packet(sock, packet, addr)
        log_message(f"Retransmitted Packet: Type={info[0]}, Seq={info[1]}, Checksum={info[2]}")

# get next sequence number
def next_seq_num():
    global next_seq     # use global next_seq
    seq = next_seq      # get next sequence number  
    next_seq += 1       # increment for next call
    return seq          # return sequence number


#inialize sliding window
def initalize_window(size):
    global window_base, window_size, window_map
    window_size = size
    window_base = 0
    window_map = {}

def space_in_window(seq):
    global window_base, window_size
    return seq < window_base + window_size


#log current window state
def print_window():
    global window_base, window_map, window_size

    with window_lock:
        msg = f"WINDOW base={window_base}, size={window_size} | "
        for seq in range(window_base, window_base + window_size):
            if seq in window_map:
                status = "A" if window_map[seq]["acked"] else "S"
                msg += f"[{seq}:{status}] "
            else:
                msg += f"[{seq}: ] "
        log_message(msg)


# allocate window slot for seq
def allocate_window_slot(seq):
    global window_map, window_base, last_acked_seq
    if seq in window_map and window_map[seq]["sent"]:
        return
    if last_acked_seq > window_base:
        window_base = last_acked_seq + 1
    with window_lock:
        while not space_in_window(seq):
            window_cond.wait()
        window_map[seq] = {"sent": True, "acked": False}



def free_window_slot(ack_seq):
    global window_base, window_map

    with window_lock:
        if ack_seq in window_map:
            window_map[ack_seq]["acked"] = True

        # Slide the window forward while the base is acknowledged
        while window_base in window_map and window_map[window_base]["acked"]:
            del window_map[window_base]
            window_base += 1

        window_cond.notify_all()

        
                

# segment data into chonks of SEG_SIZE
def segment_data(data):
    global SEG_SIZE
    global num_packets
    global max_seq
    num_packets = 0
    segments = []
    for i in range(0, len(data), SEG_SIZE):
        num_packets += 1
        segments.append(data[i:i + SEG_SIZE])
    max_seq = num_packets + 1  # including termination packet
    return segments


# log message to log file
def log_message(message):
    global log_f    # use global log file 
    with log_lock:  # lock for logging
        log_f.write(message + "\n")
        log_f.flush()   # flush log file



# create packet with header, checksum, and segment
def create_packet(type, segment):
    seq = next_seq_num()                    # get next sequence number
    header = struct.pack(">II", type, seq)  # create header
    isData = (type == 1)
    if type != 1:  # ACK, Connect or Termination Packet
        seg = b''  # no segment for non-data packets
    elif type == 1:
        seg = segment

    # compute checksum
    checksum = zlib.crc32(header + seg) if isData else zlib.crc32(header)
    # construct packet
    packet = header + struct.pack(">I", checksum) + seg
    packet_dict.update({seq: packet})   # save packet for retransmission
    return packet


# extract packet info: type, seq, checksum, segment
def extract_packet_info(packet):
    header = packet[:8]                                # first 8 bytes: type, seq
    packet_type, seq = struct.unpack(">II", header)   # unpack type and seq number
    checksum = struct.unpack(">I", packet[8:12])[0]   # next 4 bytes: checksum
    
    segment = packet[12:] if packet_type == 1 else b''  # Extract segment (rest of the packet)
    computed_checksum = zlib.crc32(header + segment) if packet_type == 1 else zlib.crc32(header)
    valid = checksum == computed_checksum               # Verify Checksum
    return [packet_type, seq, checksum, segment] if valid else None


# receiver thread to handle ACKs & retransmissions reqeuests
def receiver_thread(ACK_channel, addr):
    log_message("MTP_Sender_Log: Receiver thread started")
    global num_packets                      # use global num_packets
    global last_acked_seq                   # use global last_acked_seq
    last_acked_seq = 0                      # last acknowledged sequence number
    dup_acked_count = 0                     # duplicate ACK counter
    while True:
        ACK_channel.settimeout(TIMEOUT)     # set timeout for ACK reception
        try:

            # receive ACK packet & extract info
            packet, _ = unreliable_channel.recv_packet(ACK_channel)
            packet_info = extract_packet_info(packet)

            # Ingnore corrupted ACKS
            if packet_info is None:
                log_message("MTP_Sender_Log: Received corrupted ACK packet")
                continue    

            pkt_type, seq, _, _ = packet_info
            # ACK packet
            if pkt_type == 0:  # ACK Packet
                log_message(f"MTP_Sender_Log: Received ACK: Seq={seq}")
                # is Last ACKed seq
                if seq-1 == last_acked_seq:
                    dup_acked_count += 1    # increment dup ACKed counter
                    if dup_acked_count > 3: # if dup ACKed counter > 3
                        retransmit_packet(seq, ACK_channel, addr)   # retransmit packet seq
                # new ACK
                elif seq >= last_acked_seq+1:
                    free_window_slot(seq - 1)   # Free window slot ACK seq-1
                    last_acked_seq = seq - 1    # Set Last ACKed seq
                    dup_acked_count = 0         # set dup ACKed counter to 0
                    num_packets -= 1            # mark total packet as acknowledged

                    if num_packets == 0:    # all packets ACKed
                        term_packet = create_packet(2, b'')# Create Termination Packet
                        register_next_packet(term_packet)  # Register Termination Packet for sending
            # Termination ACK
            elif pkt_type == 2:
                log_message("MTP_Sender_Log: Received Termination ACK: Closing Connection")
                return
        except TimeoutError:
            # Timeout occurred, retransmit last sent packet
            log_message("MTP_Sender_Log: ACK Timeout occurred, retransmitting last sent packet")
            retransmit_packet(last_acked_seq + 1, ACK_channel, addr)  # Retransmit next expected packet



# sender thread to send packets
def sender_thread(socket, server_addr):
    log_message("MTP_Sender_Log: Sender thread started\n")
    while True:

        _, packet = get_next_packet()           # get next packet to send
        info = extract_packet_info(packet)      # extract packet info

        if info[0] == 2:                        # Termination Packet
            log_message("MTP_Sender_Log: Sent Termination Packet")
            unreliable_channel.send_packet(socket, packet, server_addr)
            return

        if info[0] == 1:                        # Data Packet
            allocate_window_slot(info[1])           # allocate window slot
        
        
        log_message(f"MTP_Sender_Log: Sent Packet: Seq={struct.unpack('>II', packet[:8])[1]}")
        print_window()
        unreliable_channel.send_packet(socket, packet, server_addr)

                
        


        
        
        

# establish connection with receiver
def connect_to_receiver(socket, server_addr):
    conn_request_packet = create_packet(3, b'')                 # Connection Request Packet
    while True:
        unreliable_channel.send_packet(socket, conn_request_packet, server_addr)
        log_message("MTP_Sender_Log: Sent connection request to receiver") 
        try:
            socket.settimeout(TIMEOUT)                          # Set socket timeout
            packet, _ = unreliable_channel.recv_packet(socket)  # Recive connection ACK packet
            packet_info = extract_packet_info(packet)           # Extract packet info
            if packet_info is None:                             # Corrupted packet
                log_message("MTP_Sender_Log: Received corrupted connection ACK")
                continue
            pkt_type, _, _, _ = packet_info            # Unpack packet info
            if pkt_type == 0:                                   # Connection ACK Packet
                log_message("MTP_Sender_Log: Received connection ACK from receiver")
                return
        except TimeoutError:
            log_message("MTP_Sender_Log: Connection Timeout error: Timeout occurred while waiting for connection ACK")
            continue
        


def main():
    global log_f
    global window
    

    if len(sys.argv) != 6:
        print("Usage: python MTPSender.py [server_ip] [server_port] [window_size] [input_file] [log_file]")
        sys.exit(1)

    server_ip = sys.argv[1] 
    server_port = int(sys.argv[2]) 
    server_addr = (server_ip, server_port)
    window_size = int(sys.argv[3]) 
    initalize_window(window_size)

    input_file = sys.argv[4] 
    log_file = sys.argv[5] 

    with open(input_file, "rb") as f:   # read input file in binary mode
        data = f.read()                 # read entire file
    segments = segment_data(data)       # segment data into chonks

    log_f = open(log_file, "w")         # open log file
    log_message("MTP_Sender_Log: START\n") # write log header
    
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM) # create UDP socket
    sock.bind(("", 0))                  # bind to any available port

    # establish connection with receiver
    connect_to_receiver(sock, server_addr)
    log_message(f"MTP_Sender_Log: Connection established {server_addr}\n")


    # start receive thread
    ACK_thread = threading.Thread(target=receiver_thread, args=(sock, server_addr))
    ACK_thread.start()
    # start send Thread
    send_thread = threading.Thread(target=sender_thread, args=(sock, server_addr))
    send_thread.start()
    

    log_message("MTP_Sender_Log: Registering data packets")
    for segment in segments:                    # for each data segment
        packet = create_packet(1, segment)      # create data packet
        register_next_packet(packet)            # register packet for sending
        

    log_message("All data packets registered for sending.")


    send_thread.join()
    log_message("MTP Sender finished sending all packets")
    ACK_thread.join()
    log_message("MTP Sender connection closed.")
    log_f.close()
   


main()