import cv2
import numpy as np
import imutils


PI = 3.141592654

AREA_ERROR_THRESH = 0.05  # Error away from the mean area


# Color ranges
#CALIB_COLOR_MIN = ( 70,  40,  61)
#CALIB_COLOR_MAX = (110, 175, 255)
CALIB_COLOR_MIN = ( 52,  24,  56)
CALIB_COLOR_MAX = ( 98, 169, 178)
TRACK_COLOR_MIN = (  0,   0,   0)
TRACK_COLOR_MAX = (255, 225, 255)


prevCalib = []
prevTrack = None


def ellipseArea(ellipse):
    return ellipse[1][0] * ellipse[1][1] * PI / 4


def main():
    # Open webcam
    cap = cv2.VideoCapture(0)

    while True:
        # Get frame
        ret, frame = cap.read()
        output = frame.copy()
        hsv = cv2.cvtColor(frame, cv2.COLOR_BGR2HSV)  # Convert to HSV (for color range)

        # Apply morphological filtering
        k_x = cv2.getGaussianKernel(8, 0)
        k_y = cv2.getGaussianKernel(8, 0)
        kernel = k_x * np.transpose(k_y)

        filt = cv2.inRange(hsv, CALIB_COLOR_MIN, CALIB_COLOR_MAX)
        filt = cv2.morphologyEx(filt, cv2.MORPH_OPEN, kernel, iterations=2)

        # Find contours
        _, contours, _ = cv2.findContours(filt, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_NONE)
        cv2.drawContours(output, contours, -1, (0, 0, 255), 3)

        matches = []  # Contours that match a marker

        for c in contours:
            e = cv2.fitEllipse(c)

            area_c = cv2.contourArea(c)
            area_e = ellipseArea(e)

            if abs(area_c - area_e) < (AREA_ERROR_THRESH * (area_c + area_e) / 2):  # Is within error
                matches.append((c, e))

        # Sort by size
        matches.sort(key=lambda x: ellipseArea(x[1]), reverse=True)

        # Get 2 best ellipses
        for i in range(0, min(len(matches), 2)):
            c = matches[i][0]
            e = matches[i][1]
            cv2.ellipse(output, e, (0, 255, 0), 2)
            cv2.putText(output, 'C: ' + str(cv2.contourArea(c)) + ' | E: ' + str(ellipseArea(e)), (int(e[0][0]), int(e[0][1])), cv2.FONT_HERSHEY_PLAIN, 2, (255, 0, 0), 2)

        # Show frame
        cv2.imshow('Frame', frame)
        cv2.imshow('Filtered', filt)
        cv2.imshow('Output', output)
        if cv2.waitKey(1) == 27:
            break


if __name__ == '__main__':
    main()