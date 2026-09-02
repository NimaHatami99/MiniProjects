import cv2 as cv
import matplotlib.pyplot as plt
import math
import numpy as np
img = cv.imread("brains.png")
#print(img.itemsize)
#print(img)
fig , ax = plt.subplots(2,3)
#t1=np.arange(0,5,0.1)
#plt.plot(t1,np.exp(t1))
def pow_tran(r,gamma):
    c=math.pow(int((math.pow(2,r.itemsize*8)-1)),1-gamma)
    u1=np.floor((r**gamma)*c)
    u2=u1.astype(np.uint8)
    return u2
img_tran_pow = pow_tran(img,2)              ### gamma = 1
#print(img_tran_pow)
#print(img_tran_pow.itemsize)
ax[0,0].imshow(img_tran_pow,cmap="gray",vmin=0,vmax=255)
ax[0,0].set_axis_off()
ax[0,0].set_title("power transformation")
histogram_pow , _ = np.histogram(img_tran_pow, bins=256 , range=(0,255))
ax[1,0].plot(histogram_pow)
ax[1,0].get_yaxis().set_visible(False)
def log_tran(r,k):
    c=(int((math.pow(2,r.itemsize*8)-1)))/math.log(int(math.pow(2,r.itemsize*8)),k)
    #print(c)
    v1=np.floor(np.log(r+1)*c/math.log(k))
    v2=v1.astype(np.uint8)
    return v2
img_tran_log = log_tran(img,2)             ### k=2
ax[0,1].imshow(img_tran_log,cmap="gray",vmin=0,vmax=255)
ax[0,1].set_axis_off()
ax[0,1].set_title("logarithm transformation")
histogram_log , _ = np.histogram(img_tran_log, bins=256 )
ax[1,1].plot(histogram_log)
ax[1,1].get_yaxis().set_visible(False)
histogram , _ = np.histogram(img,bins=256)
ax[0,2].imshow(img,cmap="gray",vmin=0,vmax=255)
ax[0,2].set_axis_off()
ax[0,2].set_title("original image")
ax[1,2].plot(histogram)
ax[1,2].get_yaxis().set_visible(False)
ax[1,2].set_title("intesity histogram")
plt.suptitle("Brains")
plt.show()