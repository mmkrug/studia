import numpy as np
import matplotlib.pyplot as plot
import matplotlib.image as image

def liczeniesplotu(img,msk):
    obrazek=img.copy();
    M=img.shape[0]
    N=img.shape[1]
    N2=0;
    MM=msk.shape[0];
    #MN=msk.shape[1];
    
    N2=np.sum(msk)
    if N2==0:
        N2=1;
    
    for i in range (0,M-(MM-1)):
        for j in range (0,N-(MM-1)):
            suma=0.0;
            #for k in range(0,MM):
             #   for l in range(0,MN):
              #      suma+=img[i+k][j+l]*msk[k,l];
               
            if MM==2:
                mtt=np.array([[img[i][j],img[i][j+1]],[img[i+1][j],img[i+1][j+1]]])
            elif MM==3:
                mtt=np.array([[img[i][j],img[i][j+1],img[i][j+2]],[img[i+1][j],img[i+1][j+1],img[i+1][j+2]],[img[i+2][j],img[i+2][j+1],img[i+2][j+2]]])
            mno=np.multiply(mtt,msk)
            suma=np.sum(mno)
            s=suma/N2;      
            #print(s)
            obrazek[i+1][j+1]=s;
    
    
    
    return obrazek;


    #


obraz=image.imread('litery.png')
obraz=obraz[:,:,0]

plot.imshow(obraz,cmap='gray')
plot.show();
#maska=np.array([[1,1,1], [1,4,1],[1,1,1]])
#maska=np.array([[-1,0,1], [-1,0,1],[-1,0,1]])


#filtr Robertsa
maska=np.array([[-1,0],[1,0]])
rob=np.power(liczeniesplotu(obraz,maska),2)
maska=np.array([[-1,1],[0,0]])
rob+=np.power(liczeniesplotu(obraz,maska),2)
maska=np.array([[0,1],[-1,0]])
rob+=np.power(liczeniesplotu(obraz,maska),2)
maska=np.array([[1,0],[0,-1]])
rob+=np.power(liczeniesplotu(obraz,maska),2)
rob=np.sqrt(rob)
print("Filtr Robertsa")
plot.imshow(rob,cmap='gray');
plot.show();

#filtr Laplace;a
maska=np.array([[0,1,0],[1,-4,1],[0,1,0]])
lap=np.power(liczeniesplotu(obraz,maska),2)
maska=np.array([[1,1,1],[1,-8,1],[1,1,1]])
lap+=np.power(liczeniesplotu(obraz,maska),2)
lap=np.sqrt(lap)
print("Filtr Laplace'a")
plot.imshow(lap,cmap='gray');
plot.show();

#filtr Prewitta
maska=np.array([[-1,0,1],[-1,0,1],[-1,0,1]])
pre=np.power(liczeniesplotu(obraz,maska),2)
maska=np.array([[-1,-1,-1],[0,0,0],[1,1,1]])
pre+=np.power(liczeniesplotu(obraz,maska),2)
maska=np.array([[0,1,1],[-1,0,1],[-1,-1,0]])
pre+=np.power(liczeniesplotu(obraz,maska),2)
maska=np.array([[-1,-1,0],[-1,0,1],[0,1,1]])
pre+=np.power(liczeniesplotu(obraz,maska),2)
pre=np.sqrt(pre);
print("Filtr Prewitta")
plot.imshow(pre,cmap='gray');
plot.show();




#filtr Sobela
maska=np.array([[-1,0,1],[-2,0,2],[-1,0,1]])
sob=np.power(liczeniesplotu(obraz,maska),2)
maska=np.array([[-1,-2,-1],[0,0,0],[1,2,1]])
sob+=np.power(liczeniesplotu(obraz,maska),2)
maska=np.array([[0,1,2],[-1,0,1],[-2,-1,0]])
sob+=np.power(liczeniesplotu(obraz,maska),2)
maska=np.array([[-2,-1,0],[-1,0,1],[0,1,2]])
sob+=np.power(liczeniesplotu(obraz,maska),2)
sob=np.sqrt(sob);
print("Filtr Sobela")
plot.imshow(sob,cmap='gray');
plot.show();

#filtr Kirscha
maska=np.array([[-3,-3,5],[-3,0,5],[-3,-3,5]])
kir=np.power(liczeniesplotu(obraz,maska),2)
maska=np.array([[-3,5,5],[-3,0,5],[-3,-3,-3]])
kir+=np.power(liczeniesplotu(obraz,maska),2)
maska=np.array([[5,5,5],[-3,0,-3],[-3,-3,-3]])
kir+=np.power(liczeniesplotu(obraz,maska),2)
maska=np.array([[5,5,-3],[5,0,-3],[-3,-3,-3]])
kir+=np.power(liczeniesplotu(obraz,maska),2)
maska=np.array([[5,-3,-3],[5,0,-3],[5,-3,-3]])
kir+=np.power(liczeniesplotu(obraz,maska),2)
maska=np.array([[-3,-3,-3],[5,0,-3],[5,5,-3]])
kir+=np.power(liczeniesplotu(obraz,maska),2)
maska=np.array([[-3,-3,-3],[-3,0,-3],[5,5,5]])
kir+=np.power(liczeniesplotu(obraz,maska),2)
maska=np.array([[-3,-3,-3],[-3,0,5],[-3,5,5]])
kir+=np.power(liczeniesplotu(obraz,maska),2)
kir=np.sqrt(kir);
print("Filtr Kirscha")
plot.imshow(kir,cmap='gray');
plot.show();

