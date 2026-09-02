import numpy as np
import cv2 as cv
import matplotlib as plt
rg=np.random.default_rng(1)
a=np.ones((50,40,3),dtype=float)
b=rg.random((50,40,3))
a *= -3.2
b *= 12.5
b += a
print(b.max())
print(b.min())
def im_fun(x):
    ma_max=x.max()
    ma_min=x.min()
    m=255/(ma_max - ma_min)
    d= - m * ma_min
    c=np.ones((50,40,3),dtype=float)
    c *= d
    x *= m
    x += c
    u1=np.floor(x)
    u2=u1.astype(np.uint8)
    return u2
img=im_fun(b)
print(img)
print("The datatype of function's output matrix: ",img.dtype.name)
cv.imshow("stochastic image",img)
print(img.max())
print(img.min())
cv.imwrite("stochastic50_40_1.jpg",img)
cv.waitKey(0)
cv.destroyAllWindows()