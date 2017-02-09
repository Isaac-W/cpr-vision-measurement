import matplotlib
import peakutils

# Status flags
STATUS_GOOD         = 0x0000
STATUS_FLAG_FAST    = 0x0001
STATUS_FLAG_SLOW    = 0x0010
STATUS_FLAG_SHALLOW = 0x0100
STATUS_FLAG_RELEASE = 0x1000


class CPRStatus(object):
    def __init__(self, buffer_size=150):
        self.BUFFER_SIZE = buffer_size
        self.buffer = []

    def update(self, marker):
        if not marker:
            return None

        # Push position to buffer
        self.buffer.append(marker.position)

        if len(buffer) >= self.BUFFER_SIZE:
            # Compute status

            # TODO Show plot


            # Clear buffer
            self.buffer = []

            # Return status code
            return None  # TODO

        return None
