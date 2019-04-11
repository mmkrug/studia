import numpy as np
import matplotlib.pyplot as plot
import matplotlib.image as image

oryginal=image.imread('E:\Workspace\Python\kierowca.png')
obraz=oryginal[:,:,0]
obraz2=np.zeros([obraz.shape[0],obraz.shape[1]])


def rgb2gray(img):
    r = img[:, :, 0]
    g = img[:, :, 1]
    b = img[:, :, 2]
    s1 = 0.2126 * r + 0.7152 * g + 0.0722 * b
    return s1


for x in range(0,obraz.shape[0]):
    for y in range(0,obraz.shape[1]):
        obraz2[x,y] = obraz[x,y]+np.random.rand(1)
        
kopia = oryginal.copy()
for k in range(0,1000):
    for x in range(0,oryginal.shape[0]-1):
        for y in range(0,oryginal.shape[1]-1):
            kopia[x,y] = (kopia[x,y]+oryginal[x,y])/2
        
        
        

plot.subplot(121)
plot.imshow(obraz)

plot.subplot(122)
plot.imshow(obraz2)

plot.show()

plot.subplot(121)
plot.imshow(oryginal)

plot.subplot(122)
plot.imshow(kopia)