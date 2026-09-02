import cv2 as cv
import numpy as np
from matplotlib import pyplot as plt
img=cv.imread("xray_checkered.png",cv.IMREAD_GRAYSCALE)

img_fft=np.fft.fft2(img)
img_fft_shift=np.fft.fftshift(img_fft)
#print(img_fft_shift.max())
img_magnitude=20*np.log(np.abs(img_fft_shift))
#print(img_magnitude.max())

plt.imshow(img,cmap='gray',vmin=0,vmax=255)
plt.title("distorted image")
plt.axis(False)
plt.figure()
plt.imshow(img_magnitude,cmap='gray',vmin=0,vmax=255)
plt.title("distorted image's spectrum")


cv.imwrite("distorted_xray_spectrum.jpg",img_magnitude) # to extract the positions in a viewer
positions=[[67,127],[127,67],[127,187],[187,127]]

for pos in positions:
    result=0
    for i in range(pos[0]-4,pos[0]+5):
        for j in range(pos[1]-4,pos[1]+5):
            result+=img_fft_shift[i][j]
    result/=81
    img_fft_shift[pos[0]][pos[1]]=result

img_magnitude=20*np.log(np.abs(img_fft_shift))
cv.imwrite("repaired_xray_spectrum.jpg",img_magnitude)

plt.figure()
#plt.subplot(121)
#plt.imshow(img,cmap='gray',vmin=0,vmax=255)
#plt.subplot(122)
plt.imshow(img_magnitude,cmap='gray',vmin=0,vmax=255)
plt.title("repaired spectrum")

repaired_ifft_shift=np.fft.ifftshift(img_fft_shift)
repaired_ifft=np.fft.ifft2(repaired_ifft_shift)
repaired_img=np.abs(repaired_ifft)

plt.figure()
plt.imshow(repaired_img,cmap='gray',vmin=0,vmax=255)
plt.title("repaired image")
plt.axis(False)

plt.show()

