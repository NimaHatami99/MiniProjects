import cv2 as cv
import numpy as np
import sys
import time
"""
image1=cv.imread("brains.png",cv.IMREAD_GRAYSCALE)
image2=image1.copy()
image3=cv.imread("angiography_live.tif",cv.IMREAD_GRAYSCALE)
#image2[50:150,50:150]=image3[50:150,50:150]
#image2[10:200,10:200]=image3[10:200,10:200]
image2[10:20,10:20]=image3[10:20,10:20]
cv.imshow("img2",image2)
cv.imshow("img1",image1)
"""
def phase_correlation(image1,image2):
    img1_fft=np.fft.fft2(image1)
    img2_fft=np.fft.fft2(image2)
    img2_fft_conj=np.ma.conjugate(img2_fft)
    R=img1_fft*img2_fft_conj
    R /=np.absolute(R)
    r=np.fft.ifft2(R).real
    return r
"""
corr_img=phase_correlation(image1,image2)
cv.imshow("phase_correlation",corr_img)
print(corr_img.max())
print(corr_img.shape)

for i in range(corr_img.shape[0]):
    for j in range(corr_img.shape[1]):
        if corr_img[i][j]!=0:
            print(f"{i}th row & {j}th column is {corr_img[i][j]}")

print(corr_img.max())
print(corr_img.min())
print(np.sum(corr_img)/(corr_img.shape[0]*corr_img.shape[1]))
"""

videocapture=cv.VideoCapture(0)

if (videocapture.isOpened()==False):
    print("Error using webcam. Please try again.")
    sys.exit()

videocapture.set(cv.CAP_PROP_FRAME_HEIGHT,480)
videocapture.set(cv.CAP_PROP_FRAME_WIDTH,640)

frame1=None

while True:
    ret, frame = videocapture.read()
    if frame is None:
        break
    channel = frame[:,:,1]     # green channel
    color_channel=frame.copy()
    color_channel[:,:,0]=0
    color_channel[:, :, 2] = 0
    if frame1 is None:
        frame1=channel
        time.sleep(0.05)
        continue
    phase_corr=phase_correlation(frame1,channel)
    #print(phase_corr.max())
    if phase_corr.max()>=0.35:
        text="stopped"
    else:
        text="in motion"
    cv.putText(frame, "status: {}".format(text), (10, 20), cv.FONT_HERSHEY_SIMPLEX, 0.5, (0, 255, 0), 2)
    frame1 = None
    cv.imshow("green channel", color_channel)
    cv.imshow("video frame", frame)
    if cv.waitKey(1) == ord('s'):
        break

videocapture.release()
cv.destroyAllWindows()

