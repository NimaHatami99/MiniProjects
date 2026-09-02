import cv2 as cv
import math
import numpy as np
import matplotlib.pyplot as plt

image_CT_1=cv.imread("CT_1.tif",cv.IMREAD_GRAYSCALE)
image_CT_2=cv.imread("CT_2.tif",cv.IMREAD_GRAYSCALE)
#print(image_CT_1.itemsize)

def func1(image):
    L=int(math.pow(2,image.itemsize*8))
    a=np.pi/2/(L-1)
    converted_img=np.zeros(image.shape)
    for i in range(image.shape[0]):
        for j in range(image.shape[1]):
            converted_img[i][j]=np.round((L-1)*math.sin(a*image[i][j]))
    return converted_img.astype(np.uint8)

converted_CT_1=func1(image_CT_1)
converted_CT_2=func1(image_CT_2)

fig , ax = plt.subplots(2,2)
plt.suptitle("images and their conversion")
ax[0,0].imshow(image_CT_1,cmap="gray",vmin=0,vmax=255)
ax[0,0].set_title("CT_1")
ax[0,0].set_axis_off()
ax[1,0].imshow(converted_CT_1,cmap="gray",vmin=0,vmax=255)
ax[1,0].set_title("converted CT_1")
ax[1,0].set_axis_off()
ax[0,1].imshow(image_CT_2,cmap="gray",vmin=0,vmax=255)
ax[0,1].set_title("CT_2")
ax[0,1].set_axis_off()
ax[1,1].imshow(converted_CT_2,cmap="gray",vmin=0,vmax=255)
ax[1,1].set_title("converted CT_2")
ax[1,1].set_axis_off()

plt.show()

L=int(math.pow(2,image_CT_1.itemsize*8))
a=np.pi/2/(L-1)

r=np.arange(0,L-1,0.001)
#print(r.shape[0])
#print(r.max())
s_trans=np.zeros(r.shape[0])
identity_trans=np.zeros(r.shape[0])

for i in range(r.shape[0]):
    s_trans[i]=(L-1)*np.sin(a*r[i])
    identity_trans[i]=r[i]

plt.figure()
plt.plot(r,identity_trans,c='r',linewidth=2,label="identity")   # identity conversion
plt.plot(r,s_trans,c='b',linestyle="--",label="S(r)")           # S(r)=(L-1)sin(ar) conversion
plt.title("identity conversion and S(r) conversion plot")
plt.xlabel("------> r")
plt.ylabel("------> s")
plt.legend()
plt.grid()

plt.show()

