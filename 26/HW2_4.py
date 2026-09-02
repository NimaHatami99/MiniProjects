import cv2 as cv
import numpy as np
from matplotlib.widgets import Slider, Button
import matplotlib.pyplot as plt
import matplotlib
matplotlib.use('TkAgg')
#w=np.array([[1,2,3],[4,5,6],[7,8,9]])
#print(type(w))
#print(isinstance(w,(list,tuple,np.ndarray)))
#print(isinstance(w,np.ndarray))
#print(type('median'))
########################################################## begin
def filter33_fcn(image,mat):
    if not(isinstance(mat,str) or isinstance(mat,np.ndarray)) :
        return False
    else:
        if isinstance(mat,np.ndarray)==True and mat.shape==(3,3) :
            extended_img=np.zeros((image.shape[0]+2,image.shape[1]+2))
            new_img=np.zeros(image.shape)
            for i in range(image.shape[0]):
                for j in range(image.shape[1]):
                    extended_img[i+1][j+1]=image[i][j]
            for i in range(1,extended_img.shape[0]-1):
                for j in range(1,extended_img.shape[1]-1):
                    result=mat[0][0]*extended_img[i-1][j-1]+mat[0][1]*extended_img[i-1][j]+mat[0][2]*extended_img[i-1][j+1]+mat[1][0]*extended_img[i][j-1]+mat[1][1]*extended_img[i][j]+mat[1][2]*extended_img[i][j+1]+mat[2][0]*extended_img[i+1][j-1]+mat[2][1]*extended_img[i+1][j]+mat[2][2]*extended_img[i+1][j+1]
                    if result < 0:
                        result=0
                    elif result > 255:
                        result=255
                    new_img[i-1][j-1]=np.floor(result)
            result_img=new_img.astype(np.uint8)
        else:
            if mat=='median':
                result_img = cv.medianBlur(image, 3)
            else:
                return False
    return result_img
################################################################  finish
img = cv.imread("bone-scan.png",cv.IMREAD_GRAYSCALE)
#cv.imshow("image",img)
median_blurred = filter33_fcn(img,'median')
cv.imshow("median_blurred",median_blurred)
cv.imshow("original image", img)
avg_kernel=(1/9)*np.ones((3,3))
averaged_img = filter33_fcn(img,avg_kernel)
cv.imshow("averaged image",averaged_img)
########################################################  begin
def laplacian90(image):
    extended_img = np.zeros((image.shape[0] + 2, image.shape[1] + 2))
    #extended_img=extended_img.astype(np.float32)
    new_img = np.zeros(image.shape)
    #new_img = new_img.astype(np.float32)
    #image=image.astype(np.float32)
    for i in range(image.shape[0]):
        for j in range(image.shape[1]):
            extended_img[i+1][j+1]=image[i][j]
    for i in range(1,extended_img.shape[0]-1):
        for j in range(1,extended_img.shape[1]-1):
            result=-extended_img[i][j-1]-extended_img[i][j+1]-extended_img[i-1][j]-extended_img[i+1][j]+4*extended_img[i][j]
            if result<0:
                result=0
            elif result>255:
                result=255
            new_img[i-1][j-1]=np.floor(result)
    result_img=new_img.astype(np.uint8)
    return result_img
########################################################  finish
laplacian_img=laplacian90(median_blurred)
cv.imshow("laplacian90 image",laplacian_img)
#laplaciancv_img=cv.Laplacian(median_blurred,-1,3)
isotropic90_kernel=[[0,-1,0],
                    [-1,4,-1],
                    [0,-1,0]]
isotropic90_kernel=np.array(isotropic90_kernel)
laplaciancv_img=cv.filter2D(median_blurred,-1,isotropic90_kernel)
cv.imshow("laplacian cv image",laplaciancv_img)
validation_result=np.all(laplaciancv_img==laplacian_img)
if validation_result==True:
    print("cv laplacian result is equal to func laplacian result.")
else:
    print("cv laplacian result isn't equal to func laplacian result.","Here's the difference between them: ",sep="\n")
difference=laplaciancv_img-laplacian_img
#print(difference.min())
#cv.imshow("difference",difference)
for i in range(laplacian_img.shape[0]):
    for j in range(laplacian_img.shape[1]):
        if not(laplacian_img[i][j]==laplaciancv_img[i][j]):
            print((i,j),"fun ",laplacian_img[i][j],"cv ",laplaciancv_img[i][j],sep=",")
#################################################  begin
def sharpening_func(image,c):
    extended_img = np.zeros((image.shape[0] + 2, image.shape[1] + 2))
    new_img = np.zeros(image.shape)
    for i in range(image.shape[0]):
        for j in range(image.shape[1]):
            extended_img[i+1][j+1]=image[i][j]
    for i in range(1,extended_img.shape[0]-1):
        for j in range(1,extended_img.shape[1]-1):
            result=image[i-1][j-1]+c*(extended_img[i][j-1]+extended_img[i][j+1]+extended_img[i-1][j]+extended_img[i+1][j]-4*extended_img[i][j])
            if result<0:
                result=0
            elif result>255:
                result=255
            new_img[i-1][j-1]=np.floor(result)
    result_img = new_img.astype(np.uint8)
    return result_img
#################################################  finish
c0=0
delta_c=0.5
sharpened_img=sharpening_func(median_blurred,c0)
histogram , _ =np.histogram(sharpened_img,bins=256,range=(0,255))
fig , ax = plt.subplots(1,2)
plt.suptitle("adding laplacian to original image via c parameter variation")
plt.subplots_adjust(bottom=0.25,top=0.9)
#plt.subplot(121)
#l_img , = plt.imshow(sharpened_img,cmap="gray",vmin=0,vmax=255)
#ax.set_axis_off()
#ax.set_title("sharpened image")
#plt.subplot(122)
#l_hist , = ax.plot(histogram)
#ax.set_title("histogram")
#ax.margins(x=0)
l_img = ax[0].imshow(sharpened_img,cmap="gray",vmin=0,vmax=255)
ax[0].set_axis_off()
ax[0].set_title("sharpened image")
l_hist , = ax[1].plot(histogram)
plt.yscale("log")
ax[1].set_title("histogram")
ax[1].margins(x=0)

axcolor = 'lightgoldenrodyellow'
ax_c = plt.axes([0.25, 0.1, 0.65, 0.03], facecolor=axcolor)
s_c = Slider(ax_c, 'c', -20.0, 20.0, valinit=c0, valstep=delta_c)

def update(val):
    c=s_c.val
    #l_img.set_data(sharpening_func(median_blurred,c))
    #l_hist.set_ydata(np.histogram(sharpening_func(median_blurred,c),bins=256,range=(0,255)))
    #ax[0].imshow(sharpening_func(median_blurred,c), cmap="gray", vmin=0, vmax=255)
    #ax1[0].remove()
    #ax1[1].remove()
    #ax.cla()
    #fig, ax = plt.subplots(1, 2)
    #plt.subplots_adjust(bottom=0.25, top=0.9)
    ax[0].imshow(sharpening_func(median_blurred, c), cmap="gray", vmin=0, vmax=255)
    histogram, _ = np.histogram(sharpening_func(median_blurred,c), bins=256, range=(0, 255))
    #ax[1].clear()
    #l_hist.remove()
    ax[1].lines.pop(-1)
    #ax[1].lines.pop(1)
    #ax[1].set_axis_off()
    #ax[1].set_axis_on()
    #ax[1].cla()
    l_hist , = ax[1].plot(histogram, "C0")
    plt.yscale("log")
    #ax[1].remove()
    #plt.show()
    fig.canvas.draw_idle()
s_c.on_changed(update)

resetax = plt.axes([0.8, 0.025, 0.1, 0.04])
button = Button(resetax, 'Reset', color=axcolor, hovercolor='0.975')  # hovercolor= its color when the cursor is on it


def reset(event):
    s_c.reset()
button.on_clicked(reset)

plt.show()
cv.waitKey(0)
cv.destroyAllWindows()