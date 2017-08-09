import math
from markerutils import *


class TrackedMarker(object):
    def __init__(self, marker, size, distance, position, y):
        self.marker = marker
        self.size = size
        self.distance = distance
        self.position = position
        self.y = y


class WristTracker(object):
    def __init__(self, marker_finder, marker_size, focal_length, origin_y=0, force_px_size=None):
        self.marker_finder = marker_finder
        self.S = marker_size
        self.F = focal_length
        self.origin_y = origin_y
        self.cur_track = None
        self.force_px_size = force_px_size

    def set_origin(self, origin_y):
        self.origin_y = origin_y

    def get_origin(self):
        return self.origin_y

    def set_force_px_size(self, size):
        self.force_px_size = size

    def get_marker(self, img, output=None):
        h, w, _ = img.shape
        center = (w / 2, h / 2)

        # Find tracker (closest to last location or center line)
        track_matches = self.marker_finder.find_markers(img, output)
        if self.cur_track:
            # Ellipse: ((x, y), (MA, ma), angle)
            track_matches.sort(key=lambda x: math.sqrt(
                math.pow(x[1][0][0] - self.cur_track[1][0][0], 2) + math.pow(x[1][0][1] - self.cur_track[1][0][1], 2)))  # Get closest to center
        else:
            track_matches.sort(key=lambda x: x[1][0][0] - center[0])  # Get closest to center

        # Get best ellipse
        if track_matches:
            self.cur_track = track_matches[0]

        # Operate on prev_track (retain last known position if no new marker found)
        if self.cur_track:
            # Calculate distance from camera (unused)
            px = get_pixel_size(self.cur_track)
            D = self.F * self.S / px

            # Check for force size
            if self.force_px_size:
                # More stable calculation (assumes no movement perpendicular to camera plane)
                px = self.force_px_size

            # Calculate position
            y = self.cur_track[1][0][1]
            pos = (self.origin_y - y) * (self.S / px)

            return TrackedMarker(self.cur_track, px, D, pos, y)

        return None
