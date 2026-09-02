import numpy as np
import cv2 as cv

### PART A ###

# Load Data
dental = cv.imread('dental_xray.tif')
mask = cv.imread('dental_xray_mask.tif')

# Masked The dental
maskdent = dental * mask

cv.imshow("Masked Image", maskdent)

# Crop uper side of dental
dimup = np.array([[0, 0]])

# For to find the first and Last point of Uper Side
for i in range(0, 882):
    for j in range(0, 340):
        if maskdent[j, i].all() > 0:
            dimup = np.append(dimup, [[j, i]], axis=0)
(px1, py1) = dimup[1]
(px2, py2) = dimup[-1]
dentup = maskdent[px1: px2, py1:py2]

# For to find the first and Last point of Down Side
dimdn = np.array([[0, 0]])
for i in range(0, 882):
    for j in range(341, 670):
        if maskdent[j, i].all() > 0:
            dimdn = np.append(dimdn, [[j, i]], axis=0)
(px1, py1) = dimdn[1]
(px2, py2) = dimdn[-1]
dentdn = maskdent[px1: px2, py1: py2]

# Show and Save the image
cv.imshow("Up Dental", dentup)
cv.imshow("Down Dental", dentdn)
cv.imwrite("Up Dental.png", dentup)
cv.imwrite("Down Dental.png", dentdn)

### PART B ###

# Load image
gbody = cv.imread('partial_body_scan.tif', cv.IMREAD_GRAYSCALE)

invbody = int(255) - gbody  # Inverse Body
twoinvbody = invbody * 2  # Add two inverse

cv.imshow("Grayscale Body", gbody)
cv.imshow("Inverse color Body", invbody)
cv.imwrite("Inverse2.png", twoinvbody)
cv.imwrite("Inverse color Body.png", invbody)
cv.imshow("Inverse + Inverse", twoinvbody)
cv.imwrite("Grayscale Body.png", gbody)

### PART C ###


ang = cv.imread('angiography_live.tif')
angmask = cv.imread('angiography_mask.tif')

diff = cv.absdiff(ang, angmask)
cv.imshow("Diffrent", diff)
cv.imwrite("Diffrent.png", diff)

compdiff = 255 - diff
cv.imshow("INVDiffrent", compdiff)
cv.imwrite("InverseDiffrent.png", compdiff)

normimg = np.zeros((420, 420, 3))
cv.normalize(compdiff, compdiff, 0, 255, cv.NORM_MINMAX)
cv.imshow("Normalize Image", compdiff)
cv.imwrite("Normalize Image.png", compdiff)
cv.waitKey(0)
cv.destroyAllWindows()