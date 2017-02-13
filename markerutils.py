PI = 3.141592654

FRAMES_PER_SEC = 15
SEC_PER_MIN = 60

RATE_RANGE = (95, 125)  # 100 - 120 BPM (plus some error in measurement)
DEPTH_RANGE = (1.85, 2.55)  # 2 - 2.4 in (plus some error in measurement)
RECOIL_THRESH = 0.15  # Allow for FULL chest recoil


# Color ranges
GREEN_COLOR_MIN = (45, 91, 77)
GREEN_COLOR_MAX = (61, 224, 255)
VIOLET_COLOR_MIN = (141, 89, 58)
VIOLET_COLOR_MAX = (161, 255, 255)
YELLOW_COLOR_MIN = (21, 100, 131)
YELLOW_COLOR_MAX = (30, 245, 255)


def ftoi_point(point):
    return int(point[0]), int(point[1])


def get_ellipse_size(ellipse):
    return max(ellipse[1][0], ellipse[1][1])


def ellipse_area(ellipse):
    return ellipse[1][0] * ellipse[1][1] * PI / 4


def get_pixel_size(marker):
    return get_ellipse_size(marker[1])
