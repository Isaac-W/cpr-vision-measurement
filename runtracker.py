import sys
from datetime import datetime
import markerfinder as mk
import cv2
import numpy as np
from cprstatus import CPRStatus
from datalogger import DataLogger
from markerutils import *
from statussender import StatusSender
from wristtracker import WristTracker

TRACKER_CAM =0
FACE_CAM = 1

SOCK_ADDR = 'localhost'
SOCK_PORT = 5123
CPR_BUFFER_SIZE = 150  # 5 seconds (@ 30 fps)

OUT_WIDTH = 960
OUT_HEIGHT = 540


def draw_marker(img, marker, size=None, distance=None, position=None):
    c = marker[0]
    e = marker[1]
    p = ftoi_point(e[0])

    cv2.ellipse(img, e, (0, 255, 0), 1)
    cv2.circle(img, p, 2, (255, 0, 0), 2)
    # cv2.putText(output, 'C: ' + str(cv2.contourArea(c)) + ' | E: ' + str(mk.ellipse_area(e)), (int(e[0][0]), int(e[0][1])), cv2.FONT_HERSHEY_PLAIN, 1, (255, 0, 0), 2)
    cv2.putText(img, str(p), (p[0] + 5, p[1]), cv2.FONT_HERSHEY_PLAIN, 1, (255, 0, 0), 2)

    # Print extra
    if size:
        cv2.putText(img, 'Size: ' + str(round(size, 2)), (p[0] + 5, p[1] + 20), cv2.FONT_HERSHEY_PLAIN, 1, (255, 0, 0), 2)

    if distance:
        cv2.putText(img, 'Dist: ' + str(round(distance, 2)), (p[0] + 5, p[1] + 40), cv2.FONT_HERSHEY_PLAIN, 1, (255, 0, 0), 2)

    if position:
        cv2.putText(img, 'Pos: ' + str(round(position, 2)), (p[0] + 5, p[1] + 60), cv2.FONT_HERSHEY_PLAIN, 1, (255, 0, 0), 2)


def main():
    if len(sys.argv) < 2:
        print 'USAGE: runtracker.py participant_id [save_location]'
        return

    S = MARKER_SIZE
    F = 1

    participant_id = sys.argv[1]

    save_location = DATA_DIR
    if len(sys.argv) >= 3:
        save_location = sys.argv[2]

    # Mouse callback for setting origin point
    def mouse_callback(event, x, y, flags, param):
        if datalog.is_running():
            return

        if event == cv2.EVENT_LBUTTONDOWN:
            # Set new origin_y
            tracker.set_origin(y)

    # Open webcam
    cap = cv2.VideoCapture(TRACKER_CAM)
    if not cap.isOpened():
        print 'Error opening tracker camera!'
        return

    # Open facecam (for separate recording)
    facecap = None
    if FACE_CAM is not None:
        facecap = cv2.VideoCapture(FACE_CAM)
        if not facecap.isOpened():
            print 'Error opening face camera!'
            facecap = None

    # Get video parameters (try to retain same attributes for output video)
    width = float(cap.get(cv2.CAP_PROP_FRAME_WIDTH))
    height = float(cap.get(cv2.CAP_PROP_FRAME_HEIGHT))
    fps = float(cap.get(cv2.CAP_PROP_FPS))

    # Create instances
    track_finder = mk.MarkerFinder(GREEN_COLOR_MIN, GREEN_COLOR_MAX)
    tracker = WristTracker(track_finder, S, F)
    tracker.set_origin(int(height / 2))

    cprstatus = CPRStatus(CPR_BUFFER_SIZE)
    statussender = StatusSender(SOCK_ADDR, SOCK_PORT)
    datalog = DataLogger(fps if (0 < fps <= 60) else 30, width, height, save_location, facecap is not None)

    trainer_on = True

    cur_position = 0
    cur_size = 0

    last_rate, last_depth, last_recoil, last_code = 0, 0, 0, 0

    while True:
        # Get frame
        ret, frame = cap.read()
        if ret is False or frame is None:
            break

        faceframe = None
        if facecap:
            faceret, faceframe = facecap.read()

        # Get dimensions
        h, w, _ = frame.shape
        center = (w / 2, h / 2)

        '''
        Output Drawing
        '''

        # Make output image
        output = frame.copy()

        # Display program status
        cv2.putText(output, '<NOT RUNNING>' if not datalog.is_running() else 'RECORDING ' + datalog.get_filename() + ' [' + str(datalog.get_index()) + ']', (0, 30), cv2.FONT_HERSHEY_PLAIN, 1.5, (0, 0, 255), 2)
        cv2.putText(output, 'R: ' + str(last_rate) + ' D: ' + str(last_depth) + ' C: ' + str(last_recoil) + ' S: ' + str(last_code), (0, 60), cv2.FONT_HERSHEY_PLAIN, 1, (0, 0, 255), 2)

        # Draw center and origin lines
        cv2.line(output, (center[0], 0), (center[0], h), (0, 0, 255), 1)
        cv2.line(output, (center[0] - 20, int(tracker.get_origin())), (center[0] + 20, int(tracker.get_origin())), (0, 0, 255), 1)

        # Draw instructions
        if not datalog.is_running():
            cv2.putText(output, 'c - set clr at orig | t - trainer is ' + ('on' if trainer_on else 'off') + ' | space - tgl tracker', (0, h - 4), cv2.FONT_HERSHEY_PLAIN, 1, (255, 0, 0), 1)

        '''
        Tracking
        '''

        # Get tracked marker from image
        tracked_marker = tracker.get_marker(frame, output)
        if tracked_marker:
            draw_marker(output, tracked_marker.marker, tracked_marker.size, tracked_marker.distance, tracked_marker.position)

            # Update cur position/size (for calibration)
            cur_position = tracked_marker.y
            cur_size = tracked_marker.size

        '''
        Analysis
        '''

        if datalog.is_running():
            if tracked_marker:
                # Analyze CPR status
                rate, depth, recoil, code = cprstatus.update(tracked_marker)

                if code is not None:
                    last_rate, last_depth, last_recoil, last_code = rate, depth, recoil, code  # Update
                    print 'R: ' + str(last_rate) + ' D: ' + str(last_depth) + ' C: ' + str(last_recoil) + ' S: ' + str(last_code)

                    # Send status if trainer is turned on
                    if trainer_on:
                        if not (last_rate == 0 and last_depth == 0 and last_recoil == 0):
                            print 'send status ' + str(code)
                            statussender.send_status(code)

                datalog.log(frame, output, tracker.get_origin(), tracked_marker.position if tracked_marker else 0, rate, depth, recoil, code, faceframe)

        '''
        Show Output
        '''

        # Resize frame
        #output = cv2.resize(output, (OUT_WIDTH, OUT_HEIGHT))

        # Show frame
        #cv2.imshow('Frame', frame)
        cv2.imshow('Output', output)
        cv2.setMouseCallback('Output', mouse_callback)

        if faceframe is not None:
            cv2.imshow('Face', faceframe)

        '''
        Process Keypresses
        '''

        k = cv2.waitKey(1)
        if k == 27:
            datalog.stop()
            break
        elif k == ord('v'):
            track_finder.set_color(VIOLET_COLOR_MIN, VIOLET_COLOR_MAX)
        elif k == ord('g'):
            track_finder.set_color(GREEN_COLOR_MIN, GREEN_COLOR_MAX)
        elif k == ord('y'):
            track_finder.set_color(YELLOW_COLOR_MIN, YELLOW_COLOR_MAX)
        elif k == ord('c'):
            # Calibrate tracker (color)
            color = (0, 0, 0)

            # Get origin pixel color
            pixel = frame[int(tracker.get_origin())][center[0]]
            hsv = cvt_bgr2hsv(pixel)
            print 'Calibrate color: ' + str(hsv) + ' | BGR: ' + str(pixel)

            # Apply HSV range
            '''
            lower_bound = tuple(map(lambda x, y: max(0, x - y), hsv, COLOR_VARIANCE))
            upper_bound = tuple(map(lambda x, y: min(255, x + y), hsv, COLOR_VARIANCE))
            '''
            lower_bound = (max(0, hsv[0] - COLOR_MIN[0]), COLOR_MIN[1], COLOR_MIN[2])
            upper_bound = (min(255, hsv[0] + COLOR_MAX[0]), COLOR_MAX[1], COLOR_MAX[2])
            #'''

            track_finder.set_color(lower_bound, upper_bound)
            print 'Color range: ' + str(lower_bound) + ' to ' + str(upper_bound)
        elif k == ord('t'):
            # Toggle trainer
            trainer_on = not trainer_on
        elif k == 32:
            # Toggle on/off
            if datalog.is_running():
                datalog.stop()
            else:
                # Reset logger
                cur_time = datetime.now()
                time_str = cur_time.strftime('%m-%d-%y_%H%M%S')
                datalog.start('CPR_' + str(participant_id) + '_' + time_str)
                cprstatus.reset()

                # Set tracker origin/size
                tracker.set_origin(cur_position)
                tracker.set_force_px_size(cur_size)

    cap.release()


if __name__ == '__main__':
    main()
