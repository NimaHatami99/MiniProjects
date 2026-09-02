import cv2 as cv
import numpy as np
import matplotlib.pyplot as plt
import math

def norm_hist(image):
    hist , _ = np.histogram(image,bins=256,range=(0,255))
    hist = hist /(image.shape[0]*image.shape[1])
    return hist

#image=cv.imread("brains.png",cv.IMREAD_GRAYSCALE)
#hist=norm_hist(image)
#print(len(hist))

def entropy_calculator(image):
    result=0
    hist=norm_hist(image)
    for i in range(len(hist)):
        if not(hist[i]==0):
            result -= hist[i]*np.log2(hist[i])
    return np.abs(result)


img_shade1=cv.imread("shade1.tif",cv.IMREAD_GRAYSCALE)
img_shade2=cv.imread("shade2.tif",cv.IMREAD_GRAYSCALE)
#print(img_shade1==img_shade2)

print(f"Contrast of shade2 is {np.abs(entropy_calculator(img_shade2))} and contrast of shade1 is {np.abs(entropy_calculator(img_shade1))} .")

img_brains=cv.imread("brains.png",cv.IMREAD_GRAYSCALE)
#image2=cv.imread("brains_lower.png",cv.IMREAD_GRAYSCALE)
#print(np.abs(entropy_clculator(image1)),np.abs(entropy_clculator(image2)),sep="\n")
#print(img_shade1)

def pow_tran(r,gamma):
    c=math.pow(int((math.pow(2,r.itemsize*8)-1)),1-gamma)
    u1=np.floor((r**gamma)*c)
    u2=u1.astype(np.uint8)
    return u2

def optimize_entropy_gamma(image):
    gamma_range=np.arange(0,2,0.1)
    old_ent , old_gamma=(0,0)
    ent=0
    for gamma in gamma_range:
        new_img=pow_tran(image,gamma)
        ent=np.abs(entropy_calculator(new_img))
        if ent > old_ent:
            old_ent,old_gamma=(ent,gamma)
    return old_gamma

optimized_entropy_gamma=optimize_entropy_gamma(img_brains)
new_entropy_brains=pow_tran(img_brains,optimized_entropy_gamma)

def std_calculator(image):
    var=0
    mean=np.sum(image)/(image.shape[0]*image.shape[1])
    for i in range(image.shape[0]):
        for j in range(image.shape[1]):
            var += np.power((image[i][j]-mean),2)
    std=np.power(var,0.5)
    return std

def optimize_std_gamma(image):
    gamma_range=np.arange(0,2,0.1)
    old_std , old_gamma=(0,0)
    std=0
    for gamma in gamma_range:
        new_img=pow_tran(image,gamma)
        std=std_calculator(new_img)
        if std > old_std:
            old_std,old_gamma=(std,gamma)
    return old_gamma

optimized_std_gamma=optimize_std_gamma(img_brains)
new_std_brains=pow_tran(img_brains,optimized_std_gamma)

cv.imshow("entropy_brains",new_entropy_brains)
cv.imshow("std_brains",new_std_brains)

cv.waitKey(0)
cv.destroyAllWindows()

