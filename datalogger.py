from datetime import datetime

import cv2


class DataLogger(object):
    def __init__(self, fps=30, width=1920, height=1080):
        self.fps = fps
        self.width = width
        self.height = height

        self.running = False
        self.index = 0

        self.filename = ''
        self.datafile = None
        self.raw_vid = None
        self.out_vid = None

    def is_running(self):
        return self.running

    def get_index(self):
        return self.index

    def get_filename(self):
        return self.filename

    def start(self, filename):
        if self.running:
            return

        try:
            # Create new data and video files
            self.filename = filename
            self.datafile = open(filename + '.tsv', 'w')
            self.datafile.write('Index\tTime\tPosition\tRate\tDepth\tRecoil\tStatus\n')

            fourcc = cv2.VideoWriter_fourcc('X', 'V', 'I', 'D')
            self.raw_vid = cv2.VideoWriter(filename + '_raw.mp4', fourcc, self.fps, (self.width, self.height))
            self.out_vid = cv2.VideoWriter(filename + '.mp4', fourcc, self.fps, (self.width, self.height))

            if self.raw_vid.isOpened() and self.out_vid.isOpened():
                self.index = 0
                self.running = True
        except:
            self.running = False

    def stop(self):
        if not self.running:
            return

        self.datafile.close()
        self.raw_vid.release()
        self.out_vid.release()

        self.running = False

    def log(self, raw, img, position, rate, depth, recoil, status):
        if not self.running:
            return

        # Get timestamp
        cur_time = datetime.now()
        timestamp = cur_time.strftime('%m-%d-%y_%H:%M:%S')

        # Write status
        vals = [self.index, timestamp, position,
                rate if rate else '',
                depth if depth else '',
                recoil if recoil else '',
                status if status else '']
        out_string = '\t'.join(map(str, vals))
        self.datafile.write(out_string + '\n')

        # Write videos
        self.raw_vid.write(raw)
        self.out_vid.write(img)

        self.index += 1
