import cv2 as cv
import numpy as np
import matplotlib.pyplot as plt

mandrill_img=cv.imread("mandrill.tif",cv.IMREAD_GRAYSCALE)
clown_img=cv.imread("clown.tif",cv.IMREAD_GRAYSCALE)

mandrill_fft=np.fft.fft2(mandrill_img)
mandrill_phase_spectrum=np.angle(mandrill_fft)
mandrill_magnitude_spectrum=np.abs(mandrill_fft)

clown_fft=np.fft.fft2(clown_img)
clown_phase_spectrum=np.angle(clown_fft)
clown_magnitude_spectrum=np.abs(clown_fft)

mandmag_cloph=np.multiply(mandrill_magnitude_spectrum,np.exp(1j*clown_phase_spectrum))
mandmag_cloph=np.fft.ifft2(mandmag_cloph)
mandmag_cloph=np.abs(mandmag_cloph)
mandmag_cloph=np.uint32(mandmag_cloph)

clomag_mandph=np.multiply(clown_magnitude_spectrum,np.exp(1j*mandrill_phase_spectrum))
clomag_mandph=np.fft.ifft2(clomag_mandph)
clomag_mandph=np.abs(clomag_mandph)
clomag_mandph=np.uint32(clomag_mandph)

plt.figure()

plt.subplot(221)
plt.imshow(mandrill_img,cmap='gray')
plt.title('mandrill image')
plt.xticks([])
plt.yticks([])

plt.subplot(222)
plt.imshow(clown_img,cmap='gray')
plt.title('clown image')
plt.xticks([])
plt.yticks([])

plt.subplot(223)
plt.imshow(mandmag_cloph,cmap='gray')
plt.title('mag mand + ph clwn')
plt.xticks([])
plt.yticks([])

plt.subplot(224)
plt.imshow(clomag_mandph,cmap='gray')
plt.title('mag clwn + ph mand')
plt.xticks([])
plt.yticks([])

plt.show()
cv.waitKey(0)
cv.destroyAllWindows()

