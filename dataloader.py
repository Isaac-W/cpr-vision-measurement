import csv
import numpy as np
import matplotlib.pyplot as plt
import peakutils
from datetime import datetime
from datalogger import TIME_FORMAT
from markerutils import *


SMOOTH_WINDOW_SIZE = 3


def average(values):
    return sum(values) / float(len(values))


def time_parse(value):
    try:
        return datetime.strptime(value, TIME_FORMAT)
    except:
        pass

    return datetime.strptime(value, '%m-%d-%y_%H:%M:%S')


def int_parse(value):
    return int(value) if value else None


def float_parse(value):
    return float(value) if value else None


def negate_data(data):
    return [-x for x in data]


def get_peaks(data):
    peaks = peakutils.indexes(np.array(data), 0.3, 8)
    return peaks.astype(int).tolist()


def plot_data(data, peaks, troughs):
    x = [x for x in range(0, len(data))]
    y = data

    #plt.plot(x, y)

    if peaks is not None:
        plt.plot(peaks, [data[x] for x in peaks], 'rx')

    if troughs is not None:
        plt.plot(troughs, [data[x] for x in troughs], 'bx')

    #plt.show()


typemap = {
    'Index': int_parse,
    'Time': time_parse,
    'Origin': float_parse,
    'Position': float_parse,
    'Rate': float_parse,
    'Depth': float_parse,
    'Recoil': float_parse,
    'Status': int_parse
}


class Compression(object):
    def __init__(self, time, depth, recoil, rate):
        self.time = time
        self.depth = depth
        self.recoil = recoil
        self.rate = rate

    def is_depth_correct(self):
        return DEPTH_RANGE[0] <= self.depth <= DEPTH_RANGE[1]

    def is_recoil_correct(self):
        return self.recoil <= RECOIL_THRESH

    def is_rate_correct(self):
        return RATE_RANGE[0] <= self.rate <= RATE_RANGE[1]

    def is_correct(self):
        return self.is_depth_correct() and self.is_recoil_correct() and self.is_rate_correct()

    def is_depth_recoil_correct(self):
        return self.is_depth_correct() and self.is_recoil_correct()

    def is_depth_rate_correct(self):
        return self.is_depth_correct() and self.is_rate_correct()

    def is_recoil_rate_correct(self):
        return self.is_recoil_correct() and self.is_rate_correct()


class DataLoader(object):
    def __init__(self, filename, start=None, end=None):
        self.data = []

        with open(filename) as csvfile:
            reader = csv.DictReader(csvfile, delimiter='\t')
            for row in reader:
                datarow = {}
                for key, value in row.iteritems():
                    datarow[key] = typemap[key](value)
                self.data.append(datarow)

        # Slice data
        self.data = self.data[start:end]

    def get_duration(self):
        return (abs(self.data[-1]['Time'] - self.data[0]['Time'])).total_seconds()

    def get_values(self, key):
        return [self.data[x][key] for x in range(len(self.data))]

    def get_values_at(self, points, key):
        return [self.data[int(x)][key] for x in points]

    def get_raw_data(self):
        return self.get_values('Position')

    def get_smoothed_data(self):
        data = self.get_raw_data()

        # Smooth the data
        smooth_filter = np.array([1 / float(SMOOTH_WINDOW_SIZE) for x in range(SMOOTH_WINDOW_SIZE)])
        smoothed = np.convolve(np.array(data), smooth_filter, mode='valid')
        smoothed = np.concatenate((np.zeros(int(SMOOTH_WINDOW_SIZE / 2)), smoothed))  # Add offset caused by convolution

        return smoothed

    def get_raw_data_at(self, points):
        data = self.get_raw_data()
        return [data[x] for x in points]

    def get_data_at(self, points):
        data = self.get_smoothed_data()
        return [data[x] for x in points]

    def get_raw_peaks(self):
        return get_peaks(self.get_raw_data())

    def get_peaks(self):
        return get_peaks(self.get_smoothed_data())

    def get_raw_troughs(self):
        return get_peaks(negate_data(self.get_raw_data()))

    def get_troughs(self):
        data = self.get_smoothed_data()
        out_peaks = []
        peaks = get_peaks(negate_data(data))
        for peak in peaks:
            if data[peak] <= -0.45:
                out_peaks.append(peak)
        return out_peaks

    def get_periods(self, points):
        periods = []
        for i in range(1, len(points)):
            period = (abs(self.data[points[i]]['Time'] - self.data[points[i - 1]]['Time'])).total_seconds()
            if period == 0:
                continue
            periods.append(period)
        return periods

    def get_rates(self):
        periods = self.get_periods(self.get_troughs())
        rates = [SEC_PER_MIN / x for x in periods]
        return rates

    def get_average_rate(self):
        return average(self.get_rates())

    def get_depths(self):
        troughs = self.get_troughs()
        depths = self.get_data_at(troughs)
        return depths

    def get_average_depth(self):
        return average(self.get_depths())

    def get_recoils(self):
        peaks = self.get_peaks()
        recoils = self.get_data_at(peaks)
        return recoils

    def get_average_recoil(self):
        return average(self.get_recoils())

    def get_compressions(self):
        # Get the compressions (using depth)
        data = self.get_smoothed_data()
        troughs = self.get_troughs()

        compressions = []

        for i in range(0, len(troughs) - 1):
            trough = troughs[i]
            next_trough = troughs[i + 1]

            # Get depth
            depth = -data[trough]

            # Get recoil (between compressions)
            subset = data[trough:next_trough]
            recoil = -max(subset)

            # Get rate
            time = (abs(self.data[trough]['Time'] - self.data[next_trough]['Time'])).total_seconds()
            if time == 0:
                continue
            rate = SEC_PER_MIN / time

            compressions.append(Compression(self.data[trough]['Time'], depth, recoil, rate))

        return compressions

    def plot_raw(self, show_peaks=True, show_troughs=True):
        data = self.get_raw_data()

        peaks = self.get_raw_peaks() if show_peaks else None
        troughs = self.get_raw_troughs() if show_troughs else None

        plot_data(data, peaks, troughs)

    def plot(self, show_peaks=True, show_troughs=True):
        data = self.get_smoothed_data()

        peaks = self.get_peaks() if show_peaks else None
        troughs = self.get_troughs() if show_troughs else None

        plot_data(data, peaks, troughs)
