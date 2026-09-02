import numpy as np
import matplotlib.pyplot as plt
import cv2

img = cv2.imread('lung.png')

img_2 = cv2.blur(img, (3, 3))
img_3 = cv2.Sobel(img_2, cv2.CV_64F, dx=1, dy=0)

plt.figure()
plt.suptitle('Problem 3 Figure')

plt.subplot(1, 3, 1)
plt.title('Original')
plt.imshow(img, cmap='gray')
plt.axis(False)

plt.subplot(1, 3, 2)
plt.title('Denoised')
plt.imshow(img_2, cmap='gray')
plt.axis(False)

plt.subplot(1, 3, 3)
plt.title('Gradient')
plt.imshow(img_3, cmap='gray')
plt.axis(False)

plt.show()