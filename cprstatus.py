import numpy as np
import matplotlib.pyplot as plt
import peakutils
from markerutils import *
import time

# Status flags
STATUS_GOOD = 0
STATUS_FAST = 2
STATUS_SLOW = 1
STATUS_DEEP = 5
STATUS_SHALLOW = 4
STATUS_RECOIL = 3


class CPRStatus(object):
    def __init__(self, buffer_size=150):
        self.BUFFER_SIZE = buffer_size
        self.data = []
        self.start_time = time.clock()

    def reset(self):
        self.data = []
        self.start_time = time.clock()

    def update(self, marker):
        if not marker:
            return None

        # Push position to buffer
        self.data.append(marker.position)

        # Get time
        cur_time = time.clock()

        if cur_time - self.start_time > SAMPLE_TIME:
            '''
            Compute status:
            Track continuous signal of marker position in a window of BUFFER_SIZE

            Notify if:
                - Rate is incorrect (slow/fast); measure the average time between "down" peaks (up peaks don't matter)
                - Depth is incorrect (shallow/deep); measure the amplitude of "down" peaks
                - Allowing for full chest recoil; measure the amplitude of "up" peaks calibrated against neutral
            '''

            # Smooth the data
            window_size = 3
            smooth_filter = np.array([1 / float(window_size) for x in range(window_size)])
            data = np.convolve(np.array(self.data), smooth_filter, mode='valid')

            x_vals = [x for x in range(0, len(data))]

            # Get peaks (for recoil)
            peaks = peakutils.indexes(np.array(data), 0.3, 8)
            peaks = peaks.astype(int).tolist()

            # Get troughs (depth peaks)
            neg_data = [-x for x in data]
            troughs = peakutils.indexes(np.array(neg_data), 0.3, 8)
            troughs = troughs.astype(int).tolist()

            # Analyze rate (use higher resolution trough points) -- NO! This may result it NEGATIVE indices
            '''
            try:
                rate_points = peakutils.interpolate(x_vals, neg_data, troughs)
            except:
                rate_points = troughs
            '''

            rate_points = troughs

            avg_rate = 0
            for i in range(1, len(rate_points)):
                # Get time between peaks and convert to rate
                avg_rate += ((len(data) / (cur_time - self.start_time)) * SEC_PER_MIN) / float(rate_points[i] - rate_points[i - 1])
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
                avg_recoil += neg_data[x]
            if peaks:
                avg_recoil /= len(peaks)

            # Determine status code to send
            code = STATUS_GOOD

            if avg_depth > DEPTH_RANGE[1]:
                code = STATUS_DEEP
            elif avg_depth < DEPTH_RANGE[0]:
                code = STATUS_SHALLOW
            elif avg_rate > RATE_RANGE[1]:
                code = STATUS_FAST
            elif avg_rate < RATE_RANGE[0]:
                code = STATUS_SLOW
            elif avg_recoil > RECOIL_THRESH:
                code = STATUS_RECOIL

            ''' Show plot
            plt.plot(x_vals, data)
            plt.plot(peaks, [data[x] for x in peaks], 'rx')
            plt.plot(troughs, [data[x] for x in troughs], 'bx')
            plt.show()
            #'''

            # Clear buffer
            self.data = []
            self.start_time = time.clock()

            # Return status tuple
            return avg_rate, avg_depth, avg_recoil, code

        return None, None, None, None
