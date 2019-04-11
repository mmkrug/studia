import numpy as np
import matplotlib.pyplot as plot
import matplotlib.image as image

#       wykrywa dla R: 14, 24, 28, 54


oryginal = image.imread('E:\Workspace\Python\kolka.png')
oryginal = oryginal[:,:,0]
plot.imshow(oryginal,cmap='gray')
plot.show();

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

# =============================================================================
# ke = 10;
# new = np.sin(ke);
# print(new);
# =============================================================================

def prog(obraz):
    rows = obraz.shape[0]
    columns = obraz.shape[1]
    for x in range(0,columns):
        for y in range(0,rows):
            if(obraz[x,y]>0):
                obraz[x,y] = 1
                
    return obraz


def TH(obraz,R):
    print("Promien: ",R)
    rows = obraz.shape[0]
    columns = obraz.shape[1]
    kopia=np.zeros((rows,columns))
    
    for x in range(0,columns):
        for y in range(0,rows):
            if(obraz[x,y]>0):
                for ang in range(0,360):
                    t=(ang*np.pi)/180
                    x0=int(np.round(x-R*np.cos(t)))
                    y0=int(np.round(y-R*np.sin(t)))
                    if((x0<256) & (y0<256)):
                        kopia[x0,y0]+=1
                    #if(x0>0 & int(y0)>0):
                     #    acc[y0,x0]=acc[y0,x0]+1;
                         
    return kopia;
                

def find_acc(obraz,R):
    w,k = np.where(obraz >= 320)
    czyste = np.zeros((obraz.shape[0],obraz.shape[1]))
    flaga = 0
    for i in range(0, len(w)):
        print("Wartoć w punkcie [",w[i],",",k[i],"] = ",obraz[w[i],k[i]]," promien: ",R)
        for ang in range(0,360):
            t=(ang*np.pi)/180;
            x0=int(np.round(w[i]-R*np.cos(t)))
            y0=int(np.round(k[i]-R*np.sin(t)))
            czyste[x0,y0] = 1
            flaga = 1
            
    if(flaga == 1):
        plot.imshow(czyste, cmap='gray', vmin=0, vmax=1)
        plot.show()
        
    
    
    
    
    
    
    
# =============================================================================
#     rows = obraz.shape[0]
#     columns = obraz.shape[1]
#     
# 
#     w,k = np.where(obraz >= 350)
#     wartosci = [0] * len(w)
# 
#     for i in range(0, len(w)):
#         print("Wartoć w punkcie [",w[i],",",k[i],"] = ",obraz[w[i],k[i]]," promien: ",R)
# =============================================================================
   
    
    
    
# =============================================================================
#     for x in range(R,columns-R):
#         for y in range(R,rows-R):
#             if(obraz[x,y]>350):
#                 print("Wartoć w punkcie [",x,",",y,"] = ",obraz[x,y]," promien: ",R)
# =============================================================================
# =============================================================================
#             ak = (obraz[x-1,y-1]+obraz[x,y-1]+obraz[x+1,y-1]+
#                   obraz[x-1,y]+obraz[x,y]+obraz[x+1,y]+
#                   obraz[x-1,y+1]+obraz[x,y+1]+obraz[x+1,y+1])
# =============================================================================
            
            
                



    


# =============================================================================
# %Hough Transform for Circles
# function HTCircle(inputimage,r)
# 
# %image size
# [rows,columns]=size(inputimage);
# 
# %accumulator
# acc=zeros(rows,columns);
# 
# %image
# for x=1:columns
#   for y=1:rows
#     if(inputimage(y,x)==0)
#       for ang=0:360
#         t=(ang*pi)/180;
#         x0=round(x-r*cos(t));
#         y0=round(y-r*sin(t));
#         if(x0>0 & y0>0)
#           acc(y0,x0)=acc(y0,x0)+1;
#         end
#       end
#     end
#   end
# end
# =============================================================================


# =============================================================================
# #filtr Robersa
# maska=np.array([[-1,0],[1,0]])
# rob=np.power(f(oryginal,maska),2)
# maska=np.array([[-1,1],[0,0]])
# rob+=np.power(f(oryginal,maska),2)
# maska=np.array([[0,1],[-1,0]])
# rob+=np.power(f(oryginal,maska),2)
# maska=np.array([[1,0],[0,-1]])
# rob+=np.power(f(oryginal,maska),2)
# rob=np.sqrt(rob)
# print("Filtr Robertsa")
# plot.imshow(rob,cmap='gray');
# plot.show();
# =============================================================================



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



kir = prog(kir)
plot.imshow(kir,cmap='gray');
plot.show()


# =============================================================================
# wyszuk = TH(kir,14)
# plot.imshow(wyszuk, cmap='gray', vmin=0, vmax=500)
# plot.show();
# 
# 
# w,k = np.where(wyszuk >= 350)
# 
# wartosci = [0] * len(w)
# 
# for i in range(0, len(w)):
#     print("Wartoć w punkcie [",w[i],",",k[i],"] = ",wyszuk[w,k]," promien: ",R)
#     wartosci[i] = wyszuk[w[i],k[i]]
# =============================================================================

#srodek = max(wartosci)


# =============================================================================
# find_acc(wyszuk,14)
# =============================================================================




# =============================================================================
# kopia = TH(kir,24)
# plot.imshow(kopia, cmap='gray', vmin=0, vmax=450)
# plot.show()
# 
# w, k = np.where(kopia >= 300)
# 
# for i in range(0, len(w)):
#     print("Wartoć w punkcie [",w[i],",",k[i],"] = ",kopia[w[i],k[i]]," promien: ",R)
# 
# 
# 
# 
# kopia = TH(kir,26)
# plot.imshow(kopia, cmap='gray', vmin=0, vmax=450)
# plot.show()
# 
# w, k = np.where(kopia >= 300)
# 
# for i in range(0, len(w)):
#     print("Wartoć w punkcie [",w[i],",",k[i],"] = ",kopia[w[i],k[i]]," promien: ",R)
# =============================================================================


# =============================================================================
# print(w,k)
# 
# for x in range(10,40):
#     for y in range(10,40):
#         if(kopia[x,y]>300):
#             print("Wartoć w punkcie [",x,",",y,"] = ",kopia[x,y])
#             #print("Znaleziono srodek: [",x,",",y,"], promien: 14" )
# =============================================================================
        
        
# =============================================================================
#         ak = (kopia[x-1,y-1] + kopia[x,y-1] + kopia[x+1,y-1] +
#               kopia[x-1,y]   + kopia[x,y]   + kopia[x+1,y]   +
#               kopia[x-1,y+1] + kopia[x,y+1] + kopia[x+1,y+1])
#         
#         if(ak>50):
#             print("Wartoć w punkcie [",x,",",y,"] = ",ak)
# =============================================================================
        
# =============================================================================
# plot.imshow(kopia, cmap='gray', vmin=0, vmax=100)
# plot.show()
# =============================================================================


for R in range(12,30,2):
    wyszuk = TH(kir,R)
    plot.imshow(wyszuk, cmap='gray', vmin=0, vmax=450)
    plot.show();
    find_acc(wyszuk,R)



# =============================================================================
# ob = np.zeros([oryginal.shape[0],oryginal.shape[1]])
# 
# 
# for x in range(0,200):
#     for y in range(0,200):
#         ob[x][y]=255;
# 
# plot.imshow(ob);
# print(ob[2][2])
# plot.show()
# 
# 
# 
# =============================================================================

# =============================================================================
# wynikowy=np.zeros((oryginal.shape[0],oryginal.shape[1]))   
# 
# def hough(obraz,r):  
#     for x in range (0,obraz.shape[0]):
#         for y in range (0,obraz.shape[1]):
#             if(rob[x][y]>0):
#                 for ang in range(0,360):
#                     t=(ang*np.pi)/180;
#                     x0=np.round(x-r*np.cos(t));
#                     y0=np.round(x-r*np.sin(t));
#                     if(x0>0 & int(y0)>0):
#                          acc[y0,x0]=acc[y0,x0]+1;
#             
#             wynikowy[i+1][j+1]=suma/norm
# 
# =============================================================================



print("koniec");








