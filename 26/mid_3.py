import cv2 as cv
import matplotlib.pyplot as plt
import numpy as np

img = cv.imread('lung.png',cv.IMREAD_GRAYSCALE)

img_2 = cv.medianBlur(img, 3)

img_3 = cv.Sobel(img_2,ddepth=-1,dx=1,dy=0)
img_3 = np.uint8(img_3)

#img_4=cv.Sobel(img_2, cv.CV_8U, dx=1, dy=0)
#print(np.bitwise_xor(img_3,img_4).max())

plt.figure()
plt.suptitle('Problem 3 Figure')

plt.subplot(1, 4, 1)
plt.title('original')
plt.imshow(img, cmap='gray')
plt.axis(False)

plt.subplot(1, 4, 2)
plt.title('denoised')
plt.imshow(img_2, cmap='gray')
plt.axis(False)

plt.subplot(1, 4, 3)
plt.title('gradient')
plt.imshow(img_3, cmap='gray')
plt.axis(False)

laplacian_img = cv.Laplacian(img,cv.CV_8U)

plt.subplot(1, 4, 4)
plt.title('laplacian')
plt.imshow(laplacian_img, cmap='gray')
plt.axis(False)

plt.show()