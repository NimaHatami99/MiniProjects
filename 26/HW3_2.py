import cv2 as cv
import matplotlib.pyplot as plt
import math
import numpy as np
image=cv.imread("a.tif",cv.IMREAD_GRAYSCALE)
cv.imshow("original image",image)
def filteration(img,type,LowHigh,radius):
    D0=radius
    n=1
    row,col=image.shape
    H=np.zeros((2*row,2*col))
    F=np.zeros((2*row,2*col))
    F[0:row,0:col]=img
    F=((-1)**(row+col))*F
    dft=np.fft.fft2(F)
    fftshift=np.fft.fftshift(dft)
    for i in range(2*row):
        for j in range(2*col):
            D=math.pow(math.pow(i-row,2)+math.pow(j-col,2),0.5)
            if type=="ideal":
                if D>D0:
                    H[i,j]=0
                else:
                    H[i,j]=1
            elif type=="butterworth":
                H[i,j]=1/(1 + (D/D0)**(2*n))
            elif type=="gausian":
                H[i,j]=np.exp(-(D**2)/(2*D0**2))
    if LowHigh=="lowpass":
        _H=H
    elif LowHigh=="highpass":
        _H=1-H
    new_img_fftshift=fftshift*_H
    new_big_img=np.abs(np.fft.ifft2(np.fft.ifftshift(new_img_fftshift)))
    new_img=new_big_img[0:row,0:col]
    return new_img
types=["ideal","butterworth","gausian"]
lowhighs=["lowpass","highpass"]
for type in types:
    for lowhigh in lowhighs:
        plt.figure()
        plt.suptitle(f"{lowhigh}-{type}")
        plt.subplot(131)
        plt.imshow(filteration(image,type,lowhigh,50), cmap='gray', vmin=0, vmax=255)
        plt.title('filted img 50')
        plt.subplot(132)
        plt.imshow(filteration(image,type,lowhigh,100), cmap='gray', vmin=0, vmax=255)
        plt.title('filted img 100')
        plt.subplot(133)
        plt.imshow(filteration(image,type,lowhigh,200), cmap='gray', vmin=0, vmax=255)
        plt.title('filted img 200')
plt.show()
cv.waitKey(0)
cv.destroyAllWindows()