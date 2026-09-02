import cv2 as cv
import numpy as np
import math
import sys
img=cv.imread("dental_xray.tif")
img_mask=cv.imread("dental_xray_mask.tif")
res=cv.bitwise_and(img,img_mask)
cv.imshow("image",img)
cv.imshow("masked image",res)
###################################
#print(img.shape)
#print(img_mask.shape)
#img_mask=cv.rectangle(img_mask,(400,300),(404,304),(255,255,0),-1)
#print(img_mask[301,401])
#cv.imshow("mask",img_mask)
#print(img_mask[2,0:10])
coordup=np.array([[0,0]])
for i in range(300):
    for j in range(882):
        if img_mask[i,j].all() > 0:
            coordup=np.append(coordup,[[i,j]],axis=0)
ux1,uy1=coordup[1]
ux2,uy2=coordup[-1]
coordn=np.array([[0,0]])
for i in range(300,673):
    for j in range(882):
        if img_mask[i,j].all() > 0:
            coordn=np.append(coordn,[[i,j]],axis=0)
dx1,dy1=coordn[1]
dx2,dy2=coordn[-1]
#print(ux1,uy1,sep=",")
#print(ux2,uy2,sep=",")
#print(dx1,dy1,sep=",")
#print(dx2,dy2,sep=",")
toothup=img[ux1:ux2+1,uy1:uy2+1]
cv.imshow("up tooth",toothup)
toothdn=img[dx1:dx2+1,dy1:dy2+1]
cv.imshow("down tooth",toothdn)
#####################################
img_body=cv.imread("partial_body_scan.tif",0)    # reading an image using grayscale method
img_body_comp_1=int((math.pow(2,img_body.itemsize*8)-1))-img_body
#print(img_body.itemsize)
#print(math.pow(2,img_body.itemsize*8)-1)
#print(img_body)
img_body_comp=img_body_comp_1.astype(np.uint8)
print(img_body_comp.shape)
cv.imshow("Complemented image",img_body_comp)
#print("Size of the image: ",img_body.shape)
#print("The type of any component in matrix(image): ",img_body.dtype.name)
#print(img_body_comp)
#print("Size of the image: ",img_body_comp.shape)
#print("The type of any component in matrix(image): ",img_body_comp.dtype.name)
cv.imshow("body image",img_body)
cv.imshow("orig + result",img_body+img_body_comp)
img_angio=cv.imread("angiography_live.tif")
img_angio_mask=cv.imread("angiography_mask.tif")
diff_angio=cv.absdiff(img_angio,img_angio_mask)
cv.imshow("Difference angiography",diff_angio)
diff_angio_comp=int((math.pow(2,diff_angio.itemsize*8)-1))-diff_angio
cv.imshow("difference angiography complement",diff_angio_comp)
######################################
comp_norm=cv.normalize(diff_angio_comp,diff_angio_comp,0,255,cv.NORM_MINMAX)
#cv.normalize(diff_angio_comp,diff_angio_comp,0,255,cv.NORM_MINMAX)
cv.imshow("difference angiography complement normalized",comp_norm)
######################################
np.set_printoptions(threshold=sys.maxsize)
cv.waitKey(0)
cv.destroyAllWindows()