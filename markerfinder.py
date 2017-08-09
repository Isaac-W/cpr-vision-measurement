import cv2
import numpy as np
from markerutils import *


class MarkerFinder(object):
    def __init__(self, color_min=(0, 0, 0), color_max=(255, 255, 255), error_thresh=0.1):
        self.color_min = color_min
        self.color_max = color_max
        self.ERROR_THRESH = error_thresh

    def set_color(self, color_min, color_max):
        self.color_min = color_min
        self.color_max = color_max

    def find_markers(self, img, output=None, sort_by_size=False):
        """
        Returns a list of markers found in the image.
        Marker structure is (contour, ellipse) where ellipse is ((x, y), (MA, ma), angle)
        """

        hsv = cv2.cvtColor(img, cv2.COLOR_BGR2HSV)  # Convert to HSV (for color range)
        filt = cv2.inRange(hsv, self.color_min, self.color_max)

        # Apply morphological filtering
        k_x = cv2.getGaussianKernel(5, 0)
        k_y = cv2.getGaussianKernel(5, 0)
        kernel = k_x * np.transpose(k_y)

        filt = cv2.morphologyEx(filt, cv2.MORPH_OPEN, kernel, iterations=2)

        # DEBUG: Show filter
        #cv2.imshow('Filter', filt)

        # Find contours
        _, contours, _ = cv2.findContours(filt, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_NONE)
        if not output is None:
            cv2.drawContours(output, contours, -1, (0, 0, 255), 1)

        matches = []  # Contours that match a marker

        for c in contours:
            e = cv2.fitEllipse(c)

            area_c = cv2.contourArea(c)
            area_e = ellipse_area(e)

            if abs(area_c - area_e) < (self.ERROR_THRESH * (area_c + area_e) / 2):  # Is within error
                matches.append((c, e))

        # Sort by size
        if sort_by_size:
            matches.sort(key=lambda x: ellipse_area(x[1]), reverse=True)

        return matches
