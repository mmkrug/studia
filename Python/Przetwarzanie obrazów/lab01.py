import numpy as np
import matplotlib.pyplot as plt
from scipy import misc as misc
import imageio

img = imageio.imread('kierowca.png')
#scipy.misc.imread()
img=img[:,:,0]
print(img.dtype)
print(img.shape)

M = img.shape[0]
N = img.shape[1]
j=0

def jas(img):
    for x in range(0,M):
        for y in range(0,N):
            j=j+img[x,y,0]
            print(j)
    j = j / (M*N)
    return j


print(jas(img))
#J = 1/M*N


for x in range(0, 3):
    print ("We're on time %d" % (x))