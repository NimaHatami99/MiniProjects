import cv2 as cv
import numpy as np
import matplotlib.pyplot as plt
img = cv.imread("kidney.tif")
def tran_1(x,a,b,s1,s2):
    if a<x<b:
        x=s2
        return x
    else:
        x=s1
        return x
def tran_2(x,a,b,s0):
    if a<x<b:
        x=s0
        return x
    else:
        return x
tran_1_func = np.vectorize(tran_1)
img_1=tran_1_func(img,160,240,20,150)
img_1=img_1.astype(np.uint8)
tran_2_func = np.vectorize(tran_2)
img_2=tran_2_func(img,100,165,200)
img_2=img_2.astype(np.uint8)
fig , ax = plt.subplots(1,3)
print(img.shape)
print(img.itemsize)
print(img_1.shape)
print(img_1.itemsize)
ax[0].imshow(img_1,cmap="gray",vmin=0,vmax=255)
ax[0].set_axis_off()
ax[0].set_title("tran_1")
ax[1].imshow(img_2,cmap="gray",vmin=0,vmax=255)
ax[1].set_axis_off()
ax[1].set_title("tran_2")
ax[2].imshow(img,cmap="gray",vmin=0,vmax=255)
ax[2].set_axis_off()
ax[2].set_title("image")
plt.show()