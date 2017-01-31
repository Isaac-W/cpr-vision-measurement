import cv2
import numpy as np
import imutils
import markerfinder as mk


CALIB_COLOR_MIN = mk.VIOLET_COLOR_MIN
CALIB_COLOR_MAX = mk.VIOLET_COLOR_MAX
TRACK_COLOR_MIN = mk.GREEN_COLOR_MIN
TRACK_COLOR_MAX = mk.GREEN_COLOR_MAX


prevCalib = []
prevTrack = None


def ftoi_point(point):
    return int(point[0]), int(point[1])


def draw_marker(img, marker):
    c = marker[0]
    e = marker[1]
    p = ftoi_point(e[0])

    cv2.ellipse(img, e, (0, 255, 0), 2)
    cv2.circle(img, p, 2, (255, 0, 0), 2)
    # cv2.putText(output, 'C: ' + str(cv2.contourArea(c)) + ' | E: ' + str(mk.ellipse_area(e)), (int(e[0][0]), int(e[0][1])), cv2.FONT_HERSHEY_PLAIN, 2, (255, 0, 0), 2)
    cv2.putText(img, str(p), p, cv2.FONT_HERSHEY_PLAIN, 1.5, (255, 0, 0), 2)
    cv2.putText(img, 'L: ' + str(round(max(e[1][0], e[1][1]), 2)), (p[0], p[1] + 20), cv2.FONT_HERSHEY_PLAIN, 1, (255, 0, 0), 2)


def main():
    # Create marker finders
    calib_finder = mk.MarkerFinder(CALIB_COLOR_MIN, CALIB_COLOR_MAX)
    track_finder = mk.MarkerFinder(TRACK_COLOR_MIN, TRACK_COLOR_MAX)

    # Open webcam
    cap = cv2.VideoCapture(0)
    if not cap.isOpened():
        return

    while True:
        # Get frame
        ret, frame = cap.read()
        if ret is False or frame is None:
            break

        output = frame.copy()

        calib_matches = calib_finder.find_markers(frame, output)

        # Get 2 best ellipses
        calib_markers = []
        for i in range(0, min(len(calib_matches), 2)):
            draw_marker(output, calib_matches[i])
            calib_markers.append(calib_matches[i][1][0])

        # Get line between markers
        if len(calib_markers) == 2:
            p1 = ftoi_point(calib_markers[0])
            p2 = ftoi_point(calib_markers[1])
            cv2.line(output, p1, p2, (255, 0, 0), 2)

        # Find tracker
        track_matches = track_finder.find_markers(frame, output)

        # Get best ellipse
        track_markers = []
        for i in range(0, min(len(track_matches), 1)):
            draw_marker(output, track_matches[i])
            track_markers.append(track_matches[i][1][0])

        # Show frame
        #cv2.imshow('Frame', frame)
        cv2.imshow('Output', output)
        if cv2.waitKey(1) == 27:
            break

    cap.release()


if __name__ == '__main__':
    main()