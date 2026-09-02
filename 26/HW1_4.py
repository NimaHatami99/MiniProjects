import cv2 as cv
import sys
import time
videocapture=cv.VideoCapture(0)
if (videocapture.isOpened()==False):
    print("Error using webcam. Please try again.")
    sys.exit()
videocapture.set(cv.CAP_PROP_FRAME_WIDTH,640)
videocapture.set(cv.CAP_PROP_FRAME_HEIGHT,480)
frame1=None
while True:
    ret,frame = videocapture.read()
    if frame is None:
        break
    gray=cv.cvtColor(frame,cv.COLOR_BGR2GRAY)
    #print(gray.shape)
    #print(frame.shape)
    gray=cv.GaussianBlur(gray,(5,5),0)
    if frame1 is None:
        frame1=gray
        time.sleep(0.05)
        continue
    diff=cv.absdiff(frame1,gray)
    thresh=cv.threshold(diff,25,255,cv.THRESH_BINARY)[1]   # the first argument of this tuple is an integer
    if thresh.max()==0:
        text="stopped"
    else:
        text="in motion"
    cv.putText(frame,"status: {}".format(text),(10,20),cv.FONT_HERSHEY_SIMPLEX,0.5,(0,255,0),2)
    frame1=None
    cv.imshow("threshold frame",thresh)
    cv.imshow("difference",diff)
    cv.imshow("video frame",frame)
    if cv.waitKey(1) == ord('s'):
        break
videocapture.release()
cv.destroyAllWindows()