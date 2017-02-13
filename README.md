# cpr-vision-measurement
Computer vision project to determine the quality of CPR chest compressions.

A circle sticker of known size is placed on the person's wrist, facing the camera. The position of this sticker is tracked as the person performs chest compressions on a CPR dummy. This generates a 1D waveform that represents the depth and rate of the compressions. From this, the quality of the compressions can be determined (rate too fast/slow, depth too shallow/deep, partial chest recoil).

Dependencies
------------
- OpenCV 3.2
- numpy 1.12.0
- PeakUtils 1.0.3
- (optional) matplotlib 2.0.0
