# TODO: Finish Documentation
# TODO: Add command line arguments for input file, server IP, port, log file
# TODO: Handle edge cases and errors more gracefully
    # Connection ACK Lost
    # Termination ACK Lost
# TODO: Reformat Log Messages for consistency



# Imports
import socket
import struct
import sys
import time
import zlib
import threading
import queue
import unreliable_channel

# Global Variables
log_f = None                        # log file handle
log_lock = threading.Lock()         # lock for logging
data_queue = queue.PriorityQueue()  # priority queue for data packets
buffered_packets = set()            # set to track buffered packet sequence numbers

NUM_TERM_ACKS = 5                   # Number of termination ACKs to send
TIMEOUT = 0.5                       # Timeout duration in seconds

# Function to create ACK packet
def create_ACK(seq):
    header = struct.pack(">II", 0, seq)                 # create header
    checkSum = zlib.crc32(header)                       # compute checksum
    packet = header + struct.pack(">I", checkSum) + b"" # assemble packet
    return packet

# Function to extract packet information
def extract_packet_info(packet):
    header = packet[:8]                             # first 8 bytes: type and seq number
    type, seq = struct.unpack(">II", header)        # unpack type and seq number
    checkSum = struct.unpack(">I", packet[8:12])[0] # next 4 bytes: checksum
    segment = packet[12:] if type == 1 else b""     # Extract segment (rest of the packet)
    computed_checksum = zlib.crc32(header + segment) if type == 1 else zlib.crc32(header)
    valid = checkSum == computed_checksum           # Verify Checksum
    return [type, seq, checkSum, segment] if valid else None

# Function to log messages
def log_message(message):
    global log_f
    with log_lock:
        log_f.write("MTP_Receiver_Log: " + message + "\n")
        log_f.flush()


# Function to write data in order to output file
def write_in_order_data(outFilename):
    global data_queue           # priority queue for data packets
    with open(outFilename, "wb") as output_file:
        for _ in range(len(data_queue.queue)):
            _, segment = data_queue.get()   # get the next segment in order
            output_file.write(segment)      # write segment to file
            output_file.flush()             # flush to ensure data is written
    log_message(f"Wrote buffered data to {outFilename}")

# Function to handle client connection
def handle_client(receiver_socket, sender_address, out_filename):
    global buffered_packets # set to track buffered packet sequence numbers
    global data_queue       # priority queue for data packets
    expected_seq = 1        # expected sequence number
    receiver_socket.settimeout(TIMEOUT)  # set socket timeout

    while True:
        # receive packet
        try:
            packet, _ = unreliable_channel.recv_packet(receiver_socket)
            packet_info = extract_packet_info(packet)
                

            
            if packet_info is None: # Corrupted packets
                log_message(f"Received corrupted packet from {sender_address}")
                continue            # Ignore
            pkt_type, seq, checksum, segment = packet_info

            if pkt_type == 1:  # Data Packet
                    
                
                if seq not in buffered_packets:         # if not already buffered
                    buffered_packets.add(seq)               # add to buffered set
                    data_queue.put( (seq, segment) )        # add to priority queue
                
                if seq == expected_seq:                 # If packet is in order
                    expected_seq += 1                       # increment expected sequence number
                    ack_packet = create_ACK(expected_seq)   # create ACK for next expected seq
                    unreliable_channel.send_packet(receiver_socket, ack_packet, sender_address)
                    log_message(f"Received expected Data Packet Seq: {seq} from {sender_address}")
                    log_message(f"Sent ACK for Seq: {expected_seq} to {sender_address}")
                    continue
                        
                else:                                   # If packet is out of order     
                    ack_packet = create_ACK(expected_seq)   # send ACK for expected seq
                    unreliable_channel.send_packet(receiver_socket, ack_packet, sender_address)
                    log_message(f"Sent ACK for Seq: {expected_seq} to {sender_address}")
                    log_message(f"Received out-of-order Data Packet Seq: {seq} from {sender_address}")
                    continue
            elif pkt_type == 2:                         # Termination Packet
                ack_packet = struct.pack(">II", 2, seq-1) + struct.pack(">I", zlib.crc32(struct.pack(">II", 2, seq-1)))
                for _ in range(NUM_TERM_ACKS):          # send multiple termination ACKs
                    unreliable_channel.send_packet(receiver_socket, ack_packet, sender_address)
                    time.sleep(0.1)                     # slight delay between ACKs
                log_message(f"Received Termination Packet from {sender_address}")
                log_message(f"Sent Termination ACK to {sender_address}")
                break
            if pkt_type == 3:                   # If connection Request Packet (unexpected)
                ack_packet = create_ACK(0)             # create ACK for connection request
                unreliable_channel.send_packet(receiver_socket, ack_packet, sender_address)
                log_message(f"Received connection request from {sender_address}")
                log_message(f"Re-sent connection ACK to {sender_address}")
                continue
        except socket.timeout:
            ack_packet = create_ACK(expected_seq)   # resend ACK for expected seq
            unreliable_channel.send_packet(receiver_socket, ack_packet, sender_address)
            log_message(f"Timeout waiting for packets from {sender_address}. Resent ACK for Seq: {expected_seq}")
            continue    # continue waiting for packets
        
    log_message(f"Connection closed with {sender_address}")
    write_in_order_data(out_filename)           # write buffered data to output file


def establish_connection(receiver_socket):
    while True:
        packet, sender_address = unreliable_channel.recv_packet(receiver_socket)
        packet_info = extract_packet_info(packet)

        if packet_info is None:
            log_message(f"Received corrupted connection request from {sender_address}")
            continue
        pkt_type, seq, checksum, _ = packet_info

        if pkt_type == 3:  # Connection Request Packet
            log_message(f"Received connection request from {sender_address}")
            ack_packet = create_ACK(0)
            unreliable_channel.send_packet(receiver_socket, ack_packet, sender_address)
            log_message(f"Sent connection ACK to {sender_address}")
            return sender_address
        

def main():
    global log_f
    if len(sys.argv) != 5:
        print("Usage: python MTPReceiver.py [server_ip] [server_port] [output_file] [log_file]")
        sys.exit(1)
    
    server_ip = sys.argv[1] 
    server_port = int(sys.argv[2])
    server_addr = (server_ip, server_port)
    output = sys.argv[3] 
    log = sys.argv[4]
    while True:
        
        log_f = open(log, "w")  # open log file
        log_message("Receiver started")

        # create UDP socket
        receiver_socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        receiver_socket.bind(server_addr)
        log_message(f"Listening on {server_ip}:{server_port}")

        sender_address = establish_connection(receiver_socket)
        handle_client(receiver_socket, sender_address, output)
        break
        
        

main()


