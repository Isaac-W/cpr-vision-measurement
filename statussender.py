import socket
import struct


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
        if status is None:
            return

        # Encode in string
        data = struct.pack('!i', status)
        self.sock.sendto(data, (self.addr, self.port))
