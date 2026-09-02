import cv2 as cv
import numpy as np
img=cv.imread("mandrill.jpg")
print("Size of the image: ",img.shape)
print("The type of any component in matrix(image): ",img.dtype.name)
gray=cv.cvtColor(img,cv.COLOR_BGR2GRAY)
cv.imshow("Original image",img)
cv.imshow("GRAY image",gray)
#cv.waitKey(0)
#cv.destroyAllWindows()
#print(img)
img64_1=np.floor(img/4)
img64_1 *= 4
img64=img64_1.astype(np.uint8)
cv.imshow("64 level image",img64)
#print(img64)
img16_1=np.floor(img/16)
img16_1 *= 16
img16 = img16_1.astype(np.uint8)
cv.imshow("16 level image",img16)
#print(img16)
img2_1=np.floor(img/128)
img2_1 *= 128
img2=img2_1.astype(np.uint8)
cv.imshow("2 level image",img2)
#print(img2)
img_left=img[:,0:255,:]
img_right=img[:,256:511,:]
cv.imshow("left image",img_left)
cv.imshow("right image",img_right)
img_updown=np.zeros((512,512,3),dtype="uint8")
#print(img_updown)
for i in range(512):
    img_updown[i,:,:]=img[512-(i+1),:,:]
img_leftright=np.zeros((512,512,3),dtype="uint8")
for i in range(512):
    img_leftright[:,i,:]=img[:,512-(i+1),:]
cv.imshow("horizontal inverse",img_leftright)
cv.imshow("vertical inverse",img_updown)
cv.imwrite("mandrill2.png",img_updown)
img3_bilinear=cv.resize(gray,None,fx=3,fy=3,interpolation=cv.INTER_LINEAR)
img3_repetition=cv.resize(gray,None,fx=3,fy=3,interpolation=cv.INTER_AREA)
img3_nearest=cv.resize(gray,None,fx=3,fy=3,interpolation=cv.INTER_NEAREST)
img33_bilinear=cv.resize(gray,None,fx=1/3,fy=1/3,interpolation=cv.INTER_LINEAR)
img33_repetition=cv.resize(gray,None,fx=1/3,fy=1/3,interpolation=cv.INTER_AREA)
img33_nearest=cv.resize(gray,None,fx=1/3,fy=1/3,interpolation=cv.INTER_NEAREST)
cv.imshow("upscale bilinear",img3_bilinear)
cv.imshow("upscale repetition",img3_repetition)
cv.imshow("upscale nearest neighbor",img3_nearest)
cv.imshow("downscale bilinear",img33_bilinear)
cv.imshow("downscale repetition",img33_repetition)
cv.imshow("downscale nearest neighbor",img33_nearest)
cv.waitKey(0)
cv.destroyAllWindows()