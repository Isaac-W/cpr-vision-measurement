import sys
from datetime import datetime
import markerfinder as mk
import cv2
from cprstatus import CPRStatus
from datalogger import DataLogger
from markerutils import *
from statussender import StatusSender
from wristtracker import WristTracker

SOCK_ADDR = 'localhost'
SOCK_PORT = 5123
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

    # Mouse callback for setting origin point
    def mouse_callback(event, x, y, flags, param):
        if event == cv2.EVENT_LBUTTONDOWN:
            # Set new origin_y
            tracker.set_origin(y)

    # Open webcam
    cap = cv2.VideoCapture(0)
    if not cap.isOpened():
        return

    # Get video parameters (try to retain same attributes for output video)
    fps = float(cap.get(cv2.CAP_PROP_FPS))
    width = int(cap.get(cv2.CAP_PROP_FRAME_WIDTH))
    height = int(cap.get(cv2.CAP_PROP_FRAME_HEIGHT))

    # Create instances
    track_finder = mk.MarkerFinder(VIOLET_COLOR_MIN, VIOLET_COLOR_MAX)
    tracker = WristTracker(track_finder, S, F)

    cprstatus = CPRStatus(CPR_BUFFER_SIZE)
    statussender = StatusSender(SOCK_ADDR, SOCK_PORT)
    datalog = DataLogger(fps if (0 < fps <= 60) else 30, width, height)

    while True:
        # Get frame
        ret, frame = cap.read()
        if ret is False or frame is None:
            break

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

        # Draw center and origin lines
        cv2.line(output, (center[0], 0), (center[0], h), (0, 0, 255), 1)
        cv2.line(output, (center[0] - 20, tracker.get_origin()), (center[0] + 20, tracker.get_origin()), (0, 0, 255), 1)

        '''
        Tracking
        '''

        # Get tracked marker from image
        tracked_marker = tracker.get_marker(frame, output)
        if tracked_marker:
            draw_marker(output, tracked_marker.marker, tracked_marker.size, tracked_marker.distance, tracked_marker.position)

        '''
        Analysis
        '''

        rate, depth, recoil, code = None, None, None, None

        if tracked_marker:
            # Analyze CPR status
            rate, depth, recoil, code = cprstatus.update(tracked_marker)

        if datalog.is_running():
            if code:
                statussender.send_status(code)
            datalog.log(frame, output, tracked_marker.position if tracked_marker else 0, rate, depth, recoil, code)

        '''
        Show Output
        '''

        # Show frame
        #cv2.imshow('Frame', frame)
        cv2.imshow('Output', output)
        cv2.setMouseCallback('Output', mouse_callback)

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
        elif k == 32:
            # Toggle on/off
            if datalog.is_running():
                datalog.stop()
            else:
                # Reset logger
                cur_time = datetime.now()
                time_str = cur_time.strftime('%m-%d-%y_%H%M%S')
                datalog.start('CPR_' + time_str)
                cprstatus.reset()

    cap.release()


if __name__ == '__main__':
    main()