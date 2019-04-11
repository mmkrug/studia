import numpy as np
import matplotlib.pyplot as plot
import matplotlib.image as image

oryginal = image.imread('E:\Workspace\Python\kierowca.png')
oryginal = oryginal[:,:,0]*255
oryginal = oryginal.astype(int);

ile = 256;

def histogram (obraz,ile):   
    M=obraz.shape[0]
    N=obraz.shape[1]    
    H=np.zeros(256);    
    
    for i in range (0,M):
        for j in range (0,N):
            H[obraz[i][j]] +=1;

    przedzialy = np.zeros(ile);
    rozm = np.arange(ile);
    
    for i in range (0,256):
        n = int( i%ile);
        przedzialy[n] += H[i];
    
    plot.plot(rozm,przedzialy,'g');
    plot.show();
    return przedzialy;


def fh(obraz, ile):
    
    M = obraz.shape[0]
    N = obraz.shape[1] 
    H = [0]

    for i in range (0,ile-1):
        H.append(0)
        
    for x in range(0, M):
        for y in range (0, N):
            H[int(obraz[x,y]/255*ile)] += 1
            #H[(ile*obraz[x,y]) % (ile+1)] += 1
            #for k in range (0, ile):
                #if((obraz[x,y] >= k*(1/ile)) & (obraz[x,y] <  (k+1)*(1/ile))):
                #    H[k] += 1
    
    return H

# =============================================================================
# def roz(histogram, ile):
#     H = 
#     
#     return H
# =============================================================================


# =============================================================================
# moc = [5,8,7,1,2,3]
# ile = 2
# H = [0]
# 
# for i in range (0,ile-1):
#     H.append(0)
# 
# for i in range(0, len(moc)):
#     for k in range (0, ile):
#         if((moc[i] >= k*(10/ile)) & (moc[i] <  (k+1)*(10/ile))):
#             H[k] += 1
#             
# print("H: ",H)
# =============================================================================




#       ORYGINAL
plot.imshow(oryginal, cmap='gray', vmin=0, vmax=255)
plot.show()

H = fh(oryginal, ile)
x = range(len(H))
plot.bar(x, H, 1, color="green")


aktualne = 0
suma = 0
for i in range(0,ile):
    suma += H[i]


print(suma)
funkcja = [0]
for i in range (0,ile):
    aktualne += H[i]
    funkcja.append((aktualne/suma)*max(H))
        

plot.plot(funkcja,'blue')
plot.show()



#       POTEGOWANIE
kopia = oryginal.copy()
for x in range(0, oryginal.shape[0]):
    for y in range(0, oryginal.shape[1]):
        wartosc = np.power(oryginal[x,y],2)
        kopia[x,y] = wartosc
        
        if(power > 255):
            kopia[x,y] = 255

kopia = np.power(oryginal,2)
plot.imshow(kopia, cmap='gray', vmin=0, vmax=255)
plot.show()

H = fh(kopia, ile)
x = range(len(H))
plot.bar(x, H, 1, color="green")


aktualne = 0
suma = 0
for i in range(0,ile):
    suma += H[i]


print(suma)
funkcja = [0]
for i in range (0,255):
    aktualne += H[i]
    funkcja.append((aktualne/suma)*max(H))
        

plot.plot(funkcja,'blue')
plot.show()




# =============================================================================
# a = np.random.rand(2, 3)
# print(a)
# print (a > 0.33)
# print (a < 0.55)
# print ((a > 0.33) & (a < 0.55))
# 
# y = [3, 10, 7, 5, 3, 4.5, 6, 8.1]
# N = len(y)
# x = range(N)
# width = 1/1.5
# plot.bar(x, y, width, color="blue")
# =============================================================================
# od 0 do 8 wyswietl wektor y
