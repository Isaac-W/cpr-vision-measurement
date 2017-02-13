import math
import cv2
import markerfinder as mk
from markerutils import *

"""
A/S -- adjust the known distance D (in)
Z/X -- adjust the known size S (in)
Space -- collect samples for F

Given known distance between two markers, we can calculate the focal length f using the following:
F = px * D / S  -- where d is pixel size, D is known distance, and S is known size

then we compute distance given a pixel size and known size and focal length:
D = F * S / px
"""

TOTAL_SAMPLES = 100


def draw_marker(img, marker):
    e = marker[1]
    p = ftoi_point(e[0])

    cv2.ellipse(img, e, (0, 255, 0), 2)
    cv2.circle(img, p, 2, (255, 0, 0), 2)

    cv2.putText(img, str(p), (p[0] + 5, p[1]), cv2.FONT_HERSHEY_PLAIN, 1.5, (255, 0, 0), 2)
    cv2.putText(img, 'px: ' + str(round(get_pixel_size(marker), 2)), (p[0] + 5, p[1] + 20), cv2.FONT_HERSHEY_PLAIN, 1, (255, 0, 0), 2)


def main():
    # Setup variables
    px = 0.0
    D = 0.0
    S = 0.0
    F = 0.0

    avg_px = None
    avg_F = None

    collecting_samples = False
    samples = 0
    sum_px = 0
    sum_F = 0

    # Init marker finder
    v_finder = mk.MarkerFinder(VIOLET_COLOR_MIN, VIOLET_COLOR_MAX)

    # Open webcam
    cap = cv2.VideoCapture(0)
    if not cap.isOpened():
        return

    while True:
        ret, frame = cap.read()
        if ret is False or frame is None:
            break

        output = frame.copy()

        # Draw calibration target
        h, w, _ = frame.shape
        center = (w / 2, h / 2)
        cv2.line(output, (center[0] - 20, center[1]), (center[0] + 20, center[1]), (0, 0, 255), 1)
        cv2.line(output, (center[0], center[1] - 20), (center[0], center[1] + 20), (0, 0, 255), 1)

        # Find marker
        violet_matches = v_finder.find_markers(frame, output)
        violet_matches.sort(key=lambda x: math.sqrt(math.pow(x[1][0][0] - center[0], 2) + math.pow(x[1][0][1] - center[1], 2)))  # Get closest to center
        v_marker = violet_matches[0] if len(violet_matches) else None

        # Draw centers and size
        for marker in violet_matches:
            draw_marker(output, marker)

        # Find calculated focal length
        if v_marker:
            px = get_pixel_size(v_marker)

            if S != 0:
                # Compute focal length
                F = px * D / S

        # Display status text
        cv2.putText(output, 'D = %5.2f' % D, (0, 30), cv2.FONT_HERSHEY_PLAIN, 1.5, (0, 0, 255), 2)
        cv2.putText(output, 'S = %5.2f' % S, (0, 60), cv2.FONT_HERSHEY_PLAIN, 1.5, (0, 0, 255), 2)
        cv2.putText(output, 'px = %5.3f' % px, (0, 90), cv2.FONT_HERSHEY_PLAIN, 1.5, (0, 0, 255), 2)
        cv2.putText(output, 'F = %5.3f' % F, (0, 120), cv2.FONT_HERSHEY_PLAIN, 1.5, (0, 0, 255), 2)

        # Collect samples
        if collecting_samples:
            cv2.putText(output, 'Collecting sample %d / %d' % (samples + 1, TOTAL_SAMPLES), (0, 180), cv2.FONT_HERSHEY_PLAIN, 1.5, (0, 0, 255), 2)

            samples += 1
            sum_px += px
            sum_F += F

            if samples >= TOTAL_SAMPLES:
                # Compute averages
                avg_px = sum_px / float(samples)
                avg_F = sum_F / float(samples)

                collecting_samples = False

        elif avg_px:
            cv2.putText(output, 'Average px = %5.6f' % avg_px, (0, 180), cv2.FONT_HERSHEY_PLAIN, 1.5, (0, 0, 255), 2)
            cv2.putText(output, 'Average F = %5.6f' % avg_F, (0, 210), cv2.FONT_HERSHEY_PLAIN, 1.5, (0, 0, 255), 2)

        # Show output image
        cv2.imshow("Output", output)

        # Process keypresses
        key = cv2.waitKey(1)
        if key == 27:
            break
        elif key == 32:
            if not collecting_samples:
                # Start sampling focal length
                collecting_samples = True
                samples = 0
                sum_px = 0
                sum_F = 0
        elif key == ord('a'):
            D -= 0.25
            if D < 0:
                D = 0.0
        elif key == ord('s'):
            D += 0.25
        elif key == ord('z'):
            S -= 0.25
            if S < 0:
                S = 0.0
        elif key == ord('x'):
            S += 0.25

    cap.release()


if __name__ == '__main__':
    main()
