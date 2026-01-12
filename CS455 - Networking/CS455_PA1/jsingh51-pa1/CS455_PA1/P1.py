import random
import socket
import struct

MAX_ATTEMPTS = 3


def get_query(hostname):
    print("Preparing DNS query")
    ID = random.randint(0, 65536)   # random 16-bit number
    QR = 0                                # DNS type: Query
    OPCODE = 0                            # std opcode
    AA = 0                                # Query Does not need
    TC = 0                                # Domain Names will be short
    RD = 1                                # Project Settings
    RA = 1                                # Use Recursion
    Z = 0                                 # MUST be 0 by DNS protocol
    RCODE = 0                             # N/A
    QDCOUNT = 1                           # Only 1 Query at a time
    query_name = format_name(hostname)    # format hostname
    query_type = 1                        # project specifications
    query_class = 1                       # set class to 1
    flags = (                             # Format Flags
        (QR<<15) |
        (OPCODE<11) |
        (AA<<10)|
        (TC<<9)|
        (RD<<8)|
        (RA<<7)|
        (Z<<4)|
        RCODE
    )

    question = query_name + struct.pack('!2H', query_type, query_class) # Assemble Question Partition
    header = struct.pack('!6H', ID, flags, QDCOUNT, 0, 0, 0)            # Assemble Header
    return header + question                                                   # Return & append Question to Header
def format_name(hostname):
    parts = hostname.split('.')         # split hostname by "."
    rv = bytearray()                    # init return value
    for part in parts:
        rv.append(len(part))            # Add length entry
        rv.extend(part.encode('ascii')) # Convert name to ASCII & add all bytes to rv
    rv.append(0)                        # add terminator
    return rv
def send_query(query):
    for i in range(MAX_ATTEMPTS):
        print("Contacting DNS server")
        try:
            sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM) # setup UDP Socket
            socket.setdefaulttimeout(10)                            # set timeout to 10
            print("Sending DNS query")
            sock.sendto(query, ('8.8.8.8', 53))                     # Send to Google DNS & Port 53(DNS)
            rv, _ = sock.recvfrom(512)                              # get response (512 bytes = max udp) & ignore address
            print("DNS Response Received: (Attempt "+str(i)+" of "+str(MAX_ATTEMPTS)+")")
            sock.close()                                            # close socket
            return rv                                               # return response
        except socket.timeout:
            print("Attempt "+str(i)+" Timeout")                     # send timeout msg
        except socket.error as error:
            print("Attempt "+str(i)+" Failed with error: "+error)   # send error msg
    return None
def read_name(response, offset):
    names = []                      # init return value
    while True:
        length = response[offset]   # get Q_name length
        if length == 0:             # case no name
            offset += 1
            break
        if (length & 0xC0) == 0xC0: # case name
            pointer = ((length & 0x3f) << 8) | response[offset + 1] # construct ref to name value
            name, _ = read_name(response, pointer)                  # use recursion to get the name
            names.append(name)                                      # add name to return value
            offset += 2                                             # increment offset for next operation
            break
        else:                       # recursive end case
            offset += 1
            names.append(response[offset:offset+length].decode("ascii"))   # convert to ascii
            offset += length
    return  ".".join(names), offset                                 # assemble inputted domain name
def print_response(response: bytes):
    print("Processing DNS response\n---------------------------------------------------")

    # DNS Header: 12 bytes
    header = struct.unpack('!6H', response[:12])
    id = header[0]
    print("header.id = "+str(id))
    flags = header[1]
    qr = flags & 0x8000
    print("header.QR = " + str(qr))
    Opcode = flags & 0x7800
    print("header.Opcode = " + str(Opcode))
    aa = flags & 0x400
    print("header.authoritative_answer = " + str(aa))
    tc = flags & 0x200
    print("header.truncated = " + str(tc))
    rd = flags & 0x100
    print("header.RD = " + str(rd))

    qdcount = header[2]  # Number of questions
    ancount = header[3]  # Number of answers

    offset = 12

    # Print Question Section
    for _ in range(qdcount):
        q_name, offset = read_name(response, offset)
        q_type, q_class = struct.unpack("!2H", response[offset:offset+4])
        print("question.QNAME = "+ q_name)
        print("question.QTYPE = "+str(q_type))
        print("question.QCLASS = "+str(q_class))
        offset += 4

    # Parse answer section
    for _ in range(ancount):
        a_name, offset = read_name(response, offset)    # get name
        print("answer.NAME = "+a_name)
        t, c, _, rdlength = struct.unpack('!HHIH', response[offset:offset+10]) # get class, type and rdata len - ignore time to live
        print("answer.TYPE = "+str(t))
        print("answer.CLASS = "+str(c))
        offset += 10        # increment offset

        if t == 1 and rdlength == 4:  # case has IP
            ip_bytes = response[offset:offset+4]    # move to rdata section
            ip_addr = socket.inet_ntoa(ip_bytes)    # convert bytes to ip addr
            print("answer.RDATA = "+str(ip_addr))

        offset += rdlength
def main():

    for _ in range(3):
        q = get_query(input("$> my-dns-client "))   # get hostname from user & format into query
        r = send_query(q)
        print_response(r)

main()
