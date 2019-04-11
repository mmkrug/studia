import numpy as np
import matplotlib.pyplot as plot
import matplotlib.image as image



def f(obraz,maska):
    wynikowy=obraz.copy();    
    
    norm = maska.sum()
    if (norm==0):
        norm=1
    
    
    for i in range (0,obraz.shape[0]-(maska.shape[0]-1)):
        for j in range (0,obraz.shape[1]-(maska.shape[1]-1)):
            suma=0.0;
            for k in range(0,maska.shape[0]):
                for l in range(0,maska.shape[0]):
                    suma+=obraz[i+k][j+l]*maska[k,l];
            
            wynikowy[i+1][j+1]=suma/norm
    
    return wynikowy;







oryginal = image.imread('E:\Workspace\Python\litery.png')
oryginal = oryginal[:,:,0]
plot.imshow(oryginal,cmap='gray')
plot.show();
#kopia = oryginal.copy()

 
    

#filtr Robertsa
maska=np.array([[-1,0],[1,0]])
rob=np.power(f(oryginal,maska),2)
maska=np.array([[-1,1],[0,0]])
rob+=np.power(f(oryginal,maska),2)
maska=np.array([[0,1],[-1,0]])
rob+=np.power(f(oryginal,maska),2)
maska=np.array([[1,0],[0,-1]])
rob+=np.power(f(oryginal,maska),2)
rob=np.sqrt(rob)
print("Filtr Robertsa")
plot.imshow(rob,cmap='gray');
plot.show();

#filtr Laplace;a
maska=np.array([[0,1,0],[1,-4,1],[0,1,0]])
lap=np.power(f(oryginal,maska),2)
maska=np.array([[1,1,1],[1,-8,1],[1,1,1]])
lap+=np.power(f(oryginal,maska),2)
lap=np.sqrt(lap)
print("Filtr Laplace'a")
plot.imshow(lap,cmap='gray');
plot.show();

#filtr Prewitta
maska=np.array([[-1,0,1],[-1,0,1],[-1,0,1]])
pre=np.power(f(oryginal,maska),2)
maska=np.array([[-1,-1,-1],[0,0,0],[1,1,1]])
pre+=np.power(f(oryginal,maska),2)
maska=np.array([[0,1,1],[-1,0,1],[-1,-1,0]])
pre+=np.power(f(oryginal,maska),2)
maska=np.array([[-1,-1,0],[-1,0,1],[0,1,1]])
pre+=np.power(f(oryginal,maska),2)
pre=np.sqrt(pre);
print("Filtr Prewitta")
plot.imshow(pre,cmap='gray');
plot.show();

#filtr Sobela
maska=np.array([[-1,0,1],[-2,0,2],[-1,0,1]])
sob=np.power(f(oryginal,maska),2)
maska=np.array([[-1,-2,-1],[0,0,0],[1,2,1]])
sob+=np.power(f(oryginal,maska),2)
maska=np.array([[0,1,2],[-1,0,1],[-2,-1,0]])
sob+=np.power(f(oryginal,maska),2)
maska=np.array([[-2,-1,0],[-1,0,1],[0,1,2]])
sob+=np.power(f(oryginal,maska),2)
sob=np.sqrt(sob);
print("Filtr Sobela")
plot.imshow(sob,cmap='gray');
plot.show();

#filtr Kirscha
maska=np.array([[-3,-3,5],[-3,0,5],[-3,-3,5]])
kir=np.power(f(oryginal,maska),2)
maska=np.array([[-3,5,5],[-3,0,5],[-3,-3,-3]])
kir+=np.power(f(oryginal,maska),2)
maska=np.array([[5,5,5],[-3,0,-3],[-3,-3,-3]])
kir+=np.power(f(oryginal,maska),2)
maska=np.array([[5,5,-3],[5,0,-3],[-3,-3,-3]])
kir+=np.power(f(oryginal,maska),2)
maska=np.array([[5,-3,-3],[5,0,-3],[5,-3,-3]])
kir+=np.power(f(oryginal,maska),2)
maska=np.array([[-3,-3,-3],[5,0,-3],[5,5,-3]])
kir+=np.power(f(oryginal,maska),2)
maska=np.array([[-3,-3,-3],[-3,0,-3],[5,5,5]])
kir+=np.power(f(oryginal,maska),2)
maska=np.array([[-3,-3,-3],[-3,0,5],[-3,5,5]])
kir+=np.power(f(oryginal,maska),2)
kir=np.sqrt(kir);
print("Filtr Kirscha")
plot.imshow(kir,cmap='gray');
plot.show();
    
# =============================================================================
# 
# for x in range(1,oryginal.shape[0]-1):
#     for y in range(1,oryginal.shape[1]-1):
#         suma=0.0;
#         for a in range(-1,2):
#             for b in range(-1,2):
#                 suma+=oryginal[x+a, y+b]*M[a+1,b+1];
#         kopia[x, y]=suma/N;
#                 
# =============================================================================
        
# =============================================================================
#         
# obrazek=oryginal.copy();
# M=oryginal.shape[0]
# N=oryginal.shape[1]
# norm=0;
# MM=maska.shape[0];
# MN=maska.shape[1];
# 
# for k in range(0,MM):
#     for l in range(0,MN):
#          norm+=maska[k,l]
# if norm==0:
#     norm=1;
# 
# for i in range (0,M-(MM-1)):
#     for j in range (0,N-(MM-1)):
#         suma=0.0;
#         for k in range(0,MM):
#             for l in range(0,MN):
#                 suma+=oryginal[i+k][j+l]*maska[k,l];
#                 #N2+=msk[k,l]
#         print(oryginal[i+k][j+l], "  ", suma/norm)
#         s=suma/norm;      
#         #print(s)
#         obrazek[i+1][j+1]=s;
# =============================================================================
    
    
    
   #return obrazek;

# =============================================================================
# for i in range (0,oryginal.shape[0]-2):
#     for j in range(0,oryginal.shape[1]-2):
#         suma = 0.0;
#         for k in range (0,3):
#             for l in range (0, 3):
#                 suma = suma + oryginal[i+k][j+l]*M[k,l];
#         kopia[i+1][j+1]=suma/N;    
#             
# =============================================================================
                

#plot.subplot(121)
#plot.imshow(oryginal)

#plot.subplot(122)
#plt.imshow(obrazek,cmap='gray')