import socket
import select


class StatusSender(object):
    def __init__(self):
        self.serversocket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.serversocket.bind(('localhost', 5123))
        self.serversocket.listen(8)
        self.client_sock = []
        self.client_addr = []

    def release(self):
        # Close sockets
        for s in self.client_sock:
            s.close()
        self.client_sock = []
        self.client_addr = []

        self.serversocket.close()
        self.serversocket = None

    def send_status(self, status):
        if not status:
            return

        # Check if there is an incoming connection
        r, _, _ = select.select([self.serversocket], [], [])
        for s in r:
            if s is self.serversocket:
                # Accept the connection
                sock, addr = self.serversocket.accept()
                self.client_sock.append(sock)
                self.client_addr.append(addr)

        # Send status to all clients
        for s in self.client_sock:
            s.sendall(status)
