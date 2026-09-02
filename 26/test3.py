import cv2 as cv
import numpy as np
videocapture=cv.VideoCapture(0)
if (videocapture.isOpened()==False):
    print("Error using webcam")
videocapture.set(cv.CAP_PROP_FRAME_WIDTH,640)
videocapture.set(cv.CAP_PROP_FRAME_HEIGHT,480)
while True:
    ret,frame = videocapture.read()
    cv.imshow("video frame",frame)
    if cv.waitKey(1) == ord('s'):
        break
videocapture.release()
cv.destroyAllWindows()