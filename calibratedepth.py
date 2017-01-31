import cv2
import markerfinder as mk

"""
Given known distance between two markers, we can calculate the focal length f using the following:

f = d * Z / D  -- where d is pixel size, Z is known distance, and D is known size
f = dz * d1 * d2 / (D * abs(d1 - d2))  -- where d1 and d2 are pixel sizes, and dz is known difference

then we compute distance given a pixel size and known size and focal length:

Z = f * D / d
"""

def main():
    g_finder = mk.MarkerFinder(mk.GREEN_COLOR_MIN, mk.GREEN_COLOR_MAX)
    v_finder = mk.MarkerFinder(mk.VIOLET_COLOR_MIN, mk.VIOLET_COLOR_MAX)

    cap = cv2.VideoCapture(0)
    if not cap.isOpened():
        return

    while True:
        ret, frame = cap.read()
        if ret is False or frame is None:
            break

    output = frame.copy()

    green_matches = g_finder.find_markers(frame, output)
    violet_matches = v_finder.find_markers(frame, output)

    g_marker = green_matches[0] if len(green_matches) else None
    v_marker = violet_matches[0] if len(violet_matches) else None

    # Draw centers and size
    # TODO Continue


if __name__ == '__main__':
    main()
