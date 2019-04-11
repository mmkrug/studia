import numpy as np
import matplotlib.pyplot as plt
from scipy import misc as mc

img = mc.imread('kierowca.png')
print (img.dtype)
print (img.shape)

img00 = img[:,:,0]

def rgb2gray(img):
    r = img[:, :, 0]
    g = img[:, :, 1]
    b = img[:, :, 2]
    s1 = 0.2126 * r + 0.7152 * g + 0.0722 * b
    return s1


def funk(img):
    M = img.shape[0]
    N = img.shape[1]
    k=np.sum(img)
    J=((float(1)/(M*N))*k)
    K=np.power((float(1)/(M*N))*np.sum(np.power(img-J,2)),0.5)
    return J,K

print (funk(img00))
img01=img00.copy()
img01=img01.astype('float64')
print (img01.dtype)
print (funk(img01))

img10 = img00.copy() #uint dodanie
img10 = img10 + 60
plt.subplot(3, 3, 1)
plt.imshow(img10, cmap=plt.cm.gray, vmin=0, vmax=255)

img11 = img01.copy() #float dodanie
img11 = img11 + 60
plt.subplot(3, 3, 2)
plt.imshow(img11, cmap=plt.cm.gray, vmin=0, vmax=255)

img20 = img00.copy() #uint mnozenie
img20 = img20 * 3
plt.subplot(3, 3, 3)
plt.imshow(img20, cmap=plt.cm.gray, vmin=0, vmax=255)

img21 = img01.copy() #float mnozenie
img21 = img21 * 3
plt.subplot(3, 3, 4)
plt.imshow(img21, cmap=plt.cm.gray, vmin=0, vmax=255)

img30 = img00.copy() #uint potegowanie
img30 = np.power(img30,2)
plt.subplot(3, 3, 5)
plt.imshow(img30, cmap=plt.cm.gray, vmin=0, vmax=255)

img31 = img01.copy() #float potegowanie
img31 = np.power(img31,2)
plt.subplot(3, 3, 6)
plt.imshow(img31, cmap=plt.cm.gray, vmin=0, vmax=255)

img40 = img00.copy() #uint pierwiastkowanie
img40 = np.power(img40,0.8)
plt.subplot(3, 3, 7)
plt.imshow(img40, cmap=plt.cm.gray, vmin=0, vmax=255)

img41 = img01.copy() #float pierwiastkowanie
img41 = np.power(img41,0.8)
plt.subplot(3, 3, 8)
plt.imshow(img41, cmap=plt.cm.gray, vmin=0, vmax=255)


plt.imshow(img)
plt.show()
