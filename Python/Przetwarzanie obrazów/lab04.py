import imageio
import numpy as np
import matplotlib.pyplot as plt
from scipy import misc as mc

#img = mc.imread('E:\Workspace\Python\litery.png')
img = imageio.imread('E:\Workspace\Python\litery.png')
s = img.copy()

M = np.matrix([[1,1,1],
     [1,-8,1],
     [1,1,1]])

N = M.sum()

def funk(img):
    M = img.shape[0]
    N = img.shape[1]
    k=np.sum(img)
    J=((float(1)/(M*N))*k)
    K=np.power((float(1)/(M*N))*np.sum(np.power(img-J,2)),0.5)
    return J,K

def f(img):
    img_copy = img.copy()
    
    for i in range(img.shape[0]):
        for j in range(img.shape[1]):
            img_copy[i][j] = img[img.shape[0]-i-1][img.shape[1]-j-1]        
    return img_copy


def ffitlter(N):
    N = N+20
    return N


print(N)
#plt.imshow(s)