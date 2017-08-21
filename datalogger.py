from datetime import datetime
import cv2
from os import path


TIME_FORMAT = '%m-%d-%y_%H:%M:%S.%f'


class DataLogger(object):
    def __init__(self, fps=30, width=1920, height=1080, save_location='.', rec_face=False):
        self.fps = fps
        self.width = int(width)
        self.height = int(height)

        self.save_location = save_location

        self.running = False
        self.index = 0

        self.filename = ''
        self.datafile = None
        self.raw_vid = None
        self.out_vid = None

        self.rec_face = rec_face
        self.face_vid = None

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
            self.datafile = open(path.join(self.save_location, filename + '.tsv'), 'w')
            self.datafile.write('Index\tTime\tOrigin\tPosition\tRate\tDepth\tRecoil\tStatus\n')

            fourcc = cv2.VideoWriter_fourcc('X', 'V', 'I', 'D')
            self.raw_vid = cv2.VideoWriter(path.join(self.save_location, filename + '_raw.mp4'), fourcc, self.fps, (self.width, self.height))
            self.out_vid = cv2.VideoWriter(path.join(self.save_location, filename + '.mp4'), fourcc, self.fps, (self.width, self.height))

            if self.rec_face:
                self.face_vid = cv2.VideoWriter(path.join(self.save_location, filename + '_face.mp4'), fourcc, self.fps, (self.width, self.height))

            if self.raw_vid.isOpened() and self.out_vid.isOpened():
                self.index = 0
                self.running = True
        except Exception as e:
            print e.message
            self.running = False

    def stop(self):
        if not self.running:
            return

        self.datafile.close()
        self.raw_vid.release()
        self.out_vid.release()

        if self.rec_face:
            self.face_vid.release()

        self.running = False

    def log(self, raw, img, origin, position, rate, depth, recoil, status, face=None):
        if not self.running:
            return

        # Get timestamp
        cur_time = datetime.now()
        timestamp = cur_time.strftime(TIME_FORMAT)

        # Write status
        vals = [self.index, timestamp, origin, position,
                rate if rate else '',
                depth if depth else '',
                recoil if recoil else '',
                status if status else '']
        out_string = '\t'.join(map(str, vals))
        self.datafile.write(out_string + '\n')

        # Output video
        raw = cv2.resize(raw, (self.width, self.height))
        self.raw_vid.write(raw)

        img = cv2.resize(img, (self.width, self.height))
        self.out_vid.write(img)

        if face is not None:
            face = cv2.resize(face, (self.width, self.height))
            self.face_vid.write(face)

        self.index += 1
