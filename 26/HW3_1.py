import cv2 as cv
import numpy as np
from matplotlib import pyplot as plt

img_chest=cv.imread("chest.tif",cv.IMREAD_GRAYSCALE)
cv.imshow("image",img_chest)

dft_img=cv.dft(np.float32(img_chest),flags=cv.DFT_COMPLEX_OUTPUT)
#cv.imshow("dft",dft_img)
#print(dft_img.shape)
#print(type(img_chest))
dft_shifted_img=np.fft.fftshift(dft_img)
dft_magnitude=20*np.log(cv.magnitude(dft_shifted_img[:,:,0],dft_shifted_img[:,:,1]))
#cv.imshow("dft_mag",dft_magnitude)
fig , ax = plt.subplots(1,3)
ax[0].imshow(img_chest,cmap="gray")
ax[1].imshow(dft_magnitude,cmap="gray")
dft_phase=cv.phase(dft_shifted_img[:,:,0],dft_shifted_img[:,:,1])
ax[2].imshow(dft_phase,cmap="gray")
plt.show()

gx=cv.Sobel(img_chest,cv.CV_32F,1,0)
gy=cv.Sobel(img_chest,cv.CV_32F,0,1)
mag,ph=cv.cartToPolar(gx,gy)

plt.figure('real img and its spectrum with cartopolar')
plt.subplot(1,3,1)
plt.imshow(img_chest,cmap='gray')
plt.title('img')
plt.subplot(1,3,2)
plt.imshow(mag,cmap='gray')
plt.title('mag spect')
plt.subplot(1,3,3)
plt.imshow(ph,cmap='gray')
plt.title('ph spect')


fig2,ax2=plt.subplots(1,2)
ifftshift=np.fft.ifftshift(dft_shifted_img)
idft=cv.idft(ifftshift)
img_reconstructed=cv.magnitude(idft[:,:,0],idft[:,:,1])
ax2[0].imshow(img_reconstructed,cmap="gray")

conj=np.conj(dft_shifted_img)
miror=cv.idft(conj)
mirored_img=cv.magnitude(miror[:,:,0],miror[:,:,1])
ax2[1].imshow(mirored_img,cmap="gray")

plt.show()
cv.waitKey(0)
cv.destroyAllWindows()

