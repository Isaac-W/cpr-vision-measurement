import numpy as np
import matplotlib.pyplot as plt
import peakutils
from markerutils import *

# Status flags
STATUS_GOOD = 0
STATUS_FAST = 1
STATUS_SLOW = 2
STATUS_DEEP = 3
STATUS_SHALLOW = 4
STATUS_RECOIL = 5


class CPRStatus(object):
    def __init__(self, buffer_size=150):
        self.BUFFER_SIZE = buffer_size
        self.data = []

    def update(self, marker):
        if not marker:
            return None

        # Push position to buffer
        self.data.append(marker.position)

        if len(self.data) >= self.BUFFER_SIZE:
            '''
            Compute status:
            Track continuous signal of marker position in a window of BUFFER_SIZE

            Notify if:
                - Rate is incorrect (slow/fast); measure the average time between "down" peaks (up peaks don't matter)
                - Depth is incorrect (shallow/deep); measure the amplitude of "down" peaks
                - Allowing for full chest recoil; measure the amplitude of "up" peaks calibrated against neutral
            '''

            x_vals = [x for x in range(0, len(self.data))]

            # Get peaks (for recoil)
            peaks = peakutils.indexes(np.array(self.data), 0.5, 10)
            peaks = peaks.astype(int).tolist()

            # Get troughs (depth peaks)
            neg_data = [-x for x in self.data]
            troughs = peakutils.indexes(np.array(neg_data), 0.5, 10)
            troughs = troughs.astype(int).tolist()

            # TODO Show plot
            plt.plot(x_vals, self.data)
            plt.plot(peaks, [self.data[x] for x in peaks], 'rx')
            plt.plot(troughs, [self.data[x] for x in troughs], 'bx')
            plt.show()

            # Analyze rate (use higher resolution trough points)
            try:
                rate_points = peakutils.interpolate(x_vals, neg_data, troughs)
            except:
                rate_points = troughs

            avg_rate = 0
            for i in range(1, len(rate_points)):
                # Get time between peaks and convert to rate
                avg_rate += FRAMERATE / float(rate_points[i] - rate_points[i - 1])
            if len(rate_points) > 1:
                avg_rate /= (len(rate_points) - 1)

            # Analyze depth (use magnitude of trough peaks)
            avg_depth = 0
            for x in troughs:
                avg_depth += neg_data[x]
            if troughs:
                avg_depth /= len(troughs)

            # Analyze recoil (use magnitude of peaks)
            avg_recoil = 0
            for x in peaks:
                avg_recoil += self.data[x]
            if peaks:
                avg_recoil /= len(peaks)

            # Determine status code to send
            code = STATUS_GOOD

            if avg_rate > RATE_RANGE[1]:
                code = STATUS_FAST
            elif avg_rate < RATE_RANGE[0]:
                code = STATUS_SLOW
            elif avg_depth > DEPTH_RANGE[1]:
                code = STATUS_DEEP
            elif avg_depth < DEPTH_RANGE[0]:
                code = STATUS_SHALLOW
            elif avg_recoil > RECOIL_THRESH:
                code = STATUS_RECOIL

            # Clear buffer
            self.data = []

            # Return status tuple
            return avg_rate, avg_depth, avg_recoil, code

        return None, None, None, None
