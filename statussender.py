import socket
import struct
from datetime import datetime


class StatusSender(object):
    def __init__(self, address='localhost', port=5123):
        self.addr = address
        self.port = port
        self.sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        self.sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        self.sock.setsockopt(socket.SOL_SOCKET, socket.SO_BROADCAST, 1)

    def release(self):
        self.sock.close()
        self.sock = None

    def send_status(self, status):
        if not status:
            return

        # Encode in string
        data = struct.pack('!i', status)

        cur_time = datetime.now()
        timestamp = cur_time.strftime('%m-%d-%y_%H:%M:%S')

        self.sock.sendto(data + timestamp, (self.addr, self.port))
