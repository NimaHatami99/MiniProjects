import cv2 as cv
import sys
import time
import imutils
import argparse
import datetime
ap = argparse.ArgumentParser()
ap.add_argument("-a", "--min-area", type=int, default=500, help="minimum area size")
args = vars(ap.parse_args())
videocapture=cv.VideoCapture(0)
if (videocapture.isOpened()==False):
    print("Error using webcam. Please try again.")
    sys.exit()
videocapture.set(cv.CAP_PROP_FRAME_WIDTH,640)
videocapture.set(cv.CAP_PROP_FRAME_HEIGHT,480)
frame1=None
while True:
    ret,frame = videocapture.read()
    text="stopped"
    if frame is None:
        break
    gray=cv.cvtColor(frame,cv.COLOR_BGR2GRAY)
    gray=cv.GaussianBlur(gray,(5,5),0)
    if frame1 is None:
        frame1=gray
        time.sleep(0.05)
        continue
    diff=cv.absdiff(frame1,gray)
    thresh=cv.threshold(diff,10,255,cv.THRESH_BINARY)[1]   # the first argument of this tuple is an integer
    thresh = cv.dilate(thresh, None, iterations=2)
    cnts = cv.findContours(thresh.copy(), cv.RETR_EXTERNAL,cv.CHAIN_APPROX_SIMPLE)
    cnts = imutils.grab_contours(cnts)
    for c in cnts:
        if cv.contourArea(c) < args["min_area"]:
            continue
        (x, y, w, h) = cv.boundingRect(c)
        cv.rectangle(frame, (x, y), (x + w, y + h), (255, 0, 0), 2)
        text="in motion"
    cv.putText(frame,"status: {}".format(text),(10,20),cv.FONT_HERSHEY_SIMPLEX,0.5,(0,255,0),2)
    cv.putText(frame, datetime.datetime.now().strftime("%A %d %B %Y %I:%M:%S%p"),(10, frame.shape[0] - 10), cv.FONT_HERSHEY_SIMPLEX, 0.35, (0, 255, 0), 1)
    frame1=None
    cv.imshow("threshold frame",thresh)
    cv.imshow("difference",diff)
    cv.imshow("video frame",frame)
    if cv.waitKey(1) == ord('s'):
        break
videocapture.release()
cv.destroyAllWindows()