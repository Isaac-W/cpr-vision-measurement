import cv2
import numpy as np


PI = 3.141592654

# Color ranges
GREEN_COLOR_MIN = (45, 91, 77)
GREEN_COLOR_MAX = (61, 224, 255)
VIOLET_COLOR_MIN = (141, 89, 58)
VIOLET_COLOR_MAX = (161, 255, 255)
YELLOW_COLOR_MIN = (21, 100, 131)
YELLOW_COLOR_MAX = (30, 245, 255)


def ellipse_area(ellipse):
    return ellipse[1][0] * ellipse[1][1] * PI / 4


class MarkerFinder(object):
    def __init__(self, color_min=(0, 0, 0), color_max=(255, 255, 255), error_thresh=0.1):
        self.COLOR_MIN = color_min
        self.COLOR_MAX = color_max
        self.ERROR_THRESH = error_thresh

    def find_markers(self, img, output=None):
        hsv = cv2.cvtColor(img, cv2.COLOR_BGR2HSV)  # Convert to HSV (for color range)
        filt = cv2.inRange(hsv, self.COLOR_MIN, self.COLOR_MAX)

        # Apply morphological filtering
        k_x = cv2.getGaussianKernel(5, 0)
        k_y = cv2.getGaussianKernel(5, 0)
        kernel = k_x * np.transpose(k_y)

        filt = cv2.morphologyEx(filt, cv2.MORPH_OPEN, kernel, iterations=2)

        # Find contours
        _, contours, _ = cv2.findContours(filt, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_NONE)
        if not output is None:
            cv2.drawContours(output, contours, -1, (0, 0, 255), 3)

        matches = []  # Contours that match a marker

        for c in contours:
            e = cv2.fitEllipse(c)

            area_c = cv2.contourArea(c)
            area_e = ellipse_area(e)

            if abs(area_c - area_e) < (self.ERROR_THRESH * (area_c + area_e) / 2):  # Is within error
                matches.append((c, e))

        # Sort by size
        matches.sort(key=lambda x: ellipse_area(x[1]), reverse=True)

        return matches
