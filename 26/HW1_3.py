import cv2 as cv
import numpy as np
import math
img=cv.imread("T.jpg",0)
cv.imshow("T",img)
#print(img.shape)
##############################   scaling
scaled=cv.resize(img,None,fx=2,fy=2,interpolation=cv.INTER_CUBIC)
cv.imshow("scaled T by 2 times",scaled)
##############################   translation   (tx=100 , ty=50)
rows , cols = img.shape
M=np.float32([[1,0,100],[0,1,50]])
wrapped=cv.warpAffine(img,M,(cols,rows))
cv.imshow("wrapped T by (tx=100 , ty=50)",wrapped)
##############################  vertical shear   sv=0.25
rowssv , colssv = img.shape
SV=np.float32([[1,0,0],[0.25,1,0]])
shearedV=cv.warpAffine(img,SV,(colssv,rowssv))
cv.imshow("sheared T by sv=0.25",shearedV)
##############################  horizontal shear    sh=-0.5
rowssh , colssh = img.shape
SH=np.float32([[1,-0.5,0],[0,1,0]])
shearedH=cv.warpAffine(img,SH,(colssh,rowssh))
cv.imshow("sheared T by sh=-0.5",shearedH)
##############################  30 degree clockwise   forward method
#print(math.sin(math.pi/2))
#def get_rotation(angle):
#    angle=np.radians(angle)
#    return np.array([
#        [np.cos(angle),-np.sin(angle),0],
#        [np.sin(angle),np.cos(angle),0],
#        [0, 0, 1]
#    ])
#R1=get_rotation(30)
#coords_rot=R1 @ img
#cv.imshow("rotated T by angle=30",coords_rot)
angle=30
angle=np.radians(angle)
r1 , c1 = img.shape
cw=np.float32([[np.cos(angle),-np.sin(angle),0],[np.sin(angle),np.cos(angle),0]])
rotatedcw=cv.warpAffine(img,cw,(c1,r1))
cv.imshow("rotated T by angle=30 clockwise",rotatedcw)
################################################    rotation 30 degree counterclockwise  backward method (using inverse of rotation matrix)
angle2=30
angle2=np.radians(angle2)
r2 , c2 = img.shape
cc=np.float32([[np.cos(angle2),np.sin(angle2),0],[-np.sin(angle2),np.cos(angle2),0]])
rotatedcc=cv.warpAffine(img,cc,(c2,r2))
cv.imshow("rotated T by angle=30 counterclockwise",rotatedcc)
cv.waitKey(0)
cv.destroyAllWindows()