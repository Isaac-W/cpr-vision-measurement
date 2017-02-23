PI = 3.141592654

MARKER_SIZE = 0.74

SAMPLE_TIME = 5
FRAMES_PER_SEC = 30
SEC_PER_MIN = 60

RATE_RANGE = (95, 125)  # 100 - 120 BPM (plus some error in measurement)
DEPTH_RANGE = (1.95, 5)  # At least 2 in (plus some error in measurement)
RECOIL_THRESH = 0.3  # Allow for FULL chest recoil


# Color ranges
GREEN_COLOR_MIN = (38, 68, 70)
GREEN_COLOR_MAX = (80, 183, 255)
VIOLET_COLOR_MIN = (140, 110, 21)
VIOLET_COLOR_MAX = (206, 255, 236)
YELLOW_COLOR_MIN = (10, 110, 96)
YELLOW_COLOR_MAX = (47, 255, 255)


def ftoi_point(point):
    return int(point[0]), int(point[1])


def get_ellipse_size(ellipse):
    return max(ellipse[1][0], ellipse[1][1])


def ellipse_area(ellipse):
    return ellipse[1][0] * ellipse[1][1] * PI / 4


def get_pixel_size(marker):
    return get_ellipse_size(marker[1])
