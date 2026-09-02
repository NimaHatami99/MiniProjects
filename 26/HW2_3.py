import cv2 as cv
import numpy as np
import matplotlib.pyplot as plt
import math
img = cv.imread("Lowcontrast.tif",0)  # or
#img = cv.imread("brains.png",cv.IMREAD_GRAYSCALE)
img2 = cv.imread("Dark.tif",0)
img3 = cv.imread("Bright.tif",0)
fig , ax = plt.subplots(2,2)
plt.suptitle("Histogram equalization")
ax[0,0].imshow(img,cmap="gray",vmin=0,vmax=255)
ax[0,0].set_axis_off()
histogram , _ =np.histogram(img,bins=256,range=(0,255))
#ax[1].plot(histogram)
#print(img.shape[0])
def norm_hist(image):
    hist , _ = np.histogram(image,bins=256,range=(0,255))
    hist = hist /(image.shape[0]*image.shape[1])
    return hist
#print(norm_hist(img).shape)
def norm_img(r,normedhist):
    #s=np.zeros((1,int(math.pow(2,r.itemsize*8))))
    #print(s[0][0]+s[0][1])
    #print(normedhist[0]+normedhist[1])
    #print(normedhist.shape)
    #print(s.shape)
    #for k in range(0,int(math.pow(2,r.itemsize*8))):
        #for j in range(0,k+1):
            #s[0][k] += normedhist[j]
        #s[0][k]=int(math.pow(2,r.itemsize*8)-1)*s[0][k]
    #s1=np.floor(s)
    #s2=s1.astype(np.uint8)
    #for m in range(0,r.shape[0]):
        #for n in range(0,r.shape[1]):
            #for i in range(0,int(math.pow(2,r.itemsize*8))):
                #if r[m][n]==i:
                    #r[m][n]= s2[0][i]
    g1=np.zeros(r.shape)
    #g1[20][40]=255;
    #r=g1;
    #print(g1.shape)
    #print(r.shape)
    for i in range(0,r.shape[0]):
        for j in range(0,r.shape[1]):
            for n in range(0,r[i][j]+1):
                g1[i][j] += normedhist[n]
    g2=np.floor(int(math.pow(2,r.itemsize*8)-1)*g1)
    g=g2.astype(np.uint8)
    return g
ax[1,0].plot(histogram)
ax[0,1].imshow(norm_img(img,norm_hist(img)),cmap="gray",vmin=0,vmax=255)
ax[0,1].set_axis_off()
hist_next , bin = np.histogram(norm_img(img,norm_hist(img)),bins=256,range=(0,255))
ax[1,1].plot(hist_next)
#print(norm_hist(img)[45])
#print(histogram[0])
#print(img.shape[0]*img.shape[1])
#cv.imshow("image",norm_img(img,norm_hist(img)))
fig2 , ax2 = plt.subplots(2,2)
plt.suptitle("Histogram equalization")
ax2[0,0].imshow(img2,cmap="gray",vmin=0,vmax=255)
ax2[0,0].set_axis_off()
ax2[0,0].set_title("Dark image")
histogram2 , _ =np.histogram(img2,bins=256,range=(0,255))
ax2[1,0].plot(histogram2)
ax2[1,0].set_title("histogram")
ax2[0,1].imshow(norm_img(img2,norm_hist(img2)),cmap="gray",vmin=0,vmax=255)
ax2[0,1].set_axis_off()
ax2[0,1].set_title("equalized")
hist_next2 , bin2 = np.histogram(norm_img(img2,norm_hist(img2)),bins=256,range=(0,255))
ax2[1,1].plot(hist_next2)
ax2[1,1].set_title("equalized histogram")
fig3 , ax3 = plt.subplots(2,2)
plt.suptitle("Histogram equalization")
ax3[0,0].imshow(img3,cmap="gray",vmin=0,vmax=255)
ax3[0,0].set_axis_off()
histogram3 , _ =np.histogram(img3,bins=256,range=(0,255))
ax3[1,0].plot(histogram3)
ax3[0,1].imshow(norm_img(img3,norm_hist(img3)),cmap="gray",vmin=0,vmax=255)
ax3[0,1].set_axis_off()
hist_next3 , bin3 = np.histogram(norm_img(img3,norm_hist(img3)),bins=256,range=(0,255))
ax3[1,1].plot(hist_next3)
plt.show()
#cv.waitKey(0)
#cv.destroyAllWindows()