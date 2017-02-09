import sys
import math
import cv2
import numpy as np
import imutils
from markerutils import *
import markerfinder as mk
from wristtracker import WristTracker
from cprstatus import CPRStatus
from statussender import StatusSender
from datalogger import DataLogger


TRACK_COLOR_MIN = VIOLET_COLOR_MIN
TRACK_COLOR_MAX = VIOLET_COLOR_MAX

CPR_BUFFER_SIZE = 150  # 5 seconds (@ 30 fps)


def draw_marker(img, marker, size=None, distance=None, position=None):
    c = marker[0]
    e = marker[1]
    p = ftoi_point(e[0])

    cv2.ellipse(img, e, (0, 255, 0), 2)
    cv2.circle(img, p, 2, (255, 0, 0), 2)
    # cv2.putText(output, 'C: ' + str(cv2.contourArea(c)) + ' | E: ' + str(mk.ellipse_area(e)), (int(e[0][0]), int(e[0][1])), cv2.FONT_HERSHEY_PLAIN, 2, (255, 0, 0), 2)
    cv2.putText(img, str(p), (p[0] + 5, p[1]), cv2.FONT_HERSHEY_PLAIN, 1.5, (255, 0, 0), 2)

    # Print extra
    if size:
        cv2.putText(img, 'Size: ' + str(round(size, 2)), (p[0] + 5, p[1] + 20), cv2.FONT_HERSHEY_PLAIN, 1, (255, 0, 0), 2)

    if distance:
        cv2.putText(img, 'Dist: ' + str(round(distance, 2)), (p[0] + 5, p[1] + 40), cv2.FONT_HERSHEY_PLAIN, 1, (255, 0, 0), 2)

    if position:
        cv2.putText(img, 'Pos: ' + str(round(position, 2)), (p[0] + 5, p[1] + 60), cv2.FONT_HERSHEY_PLAIN, 1, (255, 0, 0), 2)


def main():
    if len(sys.argv) < 3:
        print 'USAGE: runtracker.py marker_size focal_length'
        return

    S = float(sys.argv[1])
    F = float(sys.argv[2])

    # Create instances
    track_finder = mk.MarkerFinder(TRACK_COLOR_MIN, TRACK_COLOR_MAX)
    tracker = WristTracker(track_finder, S, F)

    cprstatus = CPRStatus(CPR_BUFFER_SIZE)
    statussender = StatusSender()
    datalog = DataLogger()

    trainer_active = False

    # Mouse callback for setting origin point
    def mouse_callback(event, x, y, flags, param):
        if event == cv2.EVENT_LBUTTONDOWN:
            # Set new origin_y
            tracker.set_origin(y)

    # Open webcam
    cap = cv2.VideoCapture(0)
    if not cap.isOpened():
        return

    while True:
        # Get frame
        ret, frame = cap.read()
        if ret is False or frame is None:
            break

        # Get dimensions
        h, w, _ = frame.shape
        center = (w / 2, h / 2)

        # Make output image
        output = frame.copy()

        # Draw center and origin lines
        cv2.line(output, (center[0], 0), (center[0], h), (0, 0, 255), 1)
        cv2.line(output, (center[0] - 20, tracker.get_origin()), (center[0] + 20, tracker.get_origin()), (0, 0, 255), 1)

        # Get tracked marker from image
        tracked_marker = tracker.get_marker(frame, output)
        if tracked_marker:
            draw_marker(output, tracked_marker.marker, tracked_marker.size, tracked_marker.distance, tracked_marker.position)

        # Get CPR status
        status = cprstatus.update(tracked_marker)

        # Broadcast status
        if status:
            statussender.send_status(status)

        # Log data
        datalog.log()  # TODO

        # Show frame
        #cv2.imshow('Frame', frame)
        cv2.imshow('Output', output)
        cv2.setMouseCallback('Output', mouse_callback)

        # Process keypresses
        k = cv2.waitKey(1)
        if k == 27:
            break
        elif k == 32:
            # Toggle trainer on/off
            trainer_active = not trainer_active

            if trainer_active:
                pass
            else:
                # Reset logger
                pass

    cap.release()


if __name__ == '__main__':
    main()