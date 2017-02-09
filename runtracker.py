import sys
import math
import cv2
import numpy as np
import imutils
import markerfinder as mk


TRACK_COLOR_MIN = mk.VIOLET_COLOR_MIN
TRACK_COLOR_MAX = mk.VIOLET_COLOR_MAX


origin_y = -1


def mouse_callback(event, x, y, flags, param):
    global origin_y

    if event == cv2.EVENT_LBUTTONDOWN:
        # Set new origin_y
        origin_y = y


def ftoi_point(point):
    return int(point[0]), int(point[1])


def get_ellipse_size(ellipse):
    return max(ellipse[1][0], ellipse[1][1])


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

    # Create marker finders
    track_finder = mk.MarkerFinder(TRACK_COLOR_MIN, TRACK_COLOR_MAX)

    # prevCalib = []
    prevTrack = None
    global origin_y

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

        # Draw calibrated origin
        if origin_y < 0:
            origin_y = center[1]  # Reset to center

        # Draw center line (for calibration)
        cv2.line(output, (center[0], 0), (center[0], h), (0, 0, 255), 1)
        cv2.line(output, (center[0] - 20, origin_y), (center[0] + 20, origin_y), (0, 0, 255), 1)

        # Find tracker (closest to last location or center line)
        track_matches = track_finder.find_markers(frame, output, False)
        if prevTrack:
            # Ellipse: ((x, y), (MA, ma), angle)
            track_matches.sort(key=lambda x: math.sqrt(math.pow(x[1][0][0] - prevTrack[1][0][0], 2) + math.pow(x[1][0][1] - prevTrack[1][0][1], 2)))  # Get closest to center
        else:
            track_matches.sort(key=lambda x: x[1][0][0] - center[0])  # Get closest to center

        # Get best ellipse
        curTrack = None
        if track_matches:
            curTrack = track_matches[0]
            prevTrack = curTrack

        # Operate on prevTrack (retain last known position if no new marker found)
        if prevTrack:
            # Calculate distance
            px = get_ellipse_size(prevTrack[1])
            D = F * S / px

            # Calculate position
            y = prevTrack[1][0][1]
            pos = (y - origin_y) * (S / px)

            draw_marker(output, prevTrack, px, D, pos)

        # Show frame
        #cv2.imshow('Frame', frame)
        cv2.imshow('Output', output)
        cv2.setMouseCallback('Output', mouse_callback)

        if cv2.waitKey(1) == 27:
            break

    cap.release()


if __name__ == '__main__':
    main()