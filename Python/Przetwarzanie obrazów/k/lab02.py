import numpy as np
import matplotlib.pyplot as plot
import matplotlib.image as image

obraz=image.imread('kierowca.png')
obraz=obraz[:,:,0]
obraz = obraz*255;
obraz=obraz.astype(int);


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


    #
#print(obraz);
def rozciaganie (obrazek):
    M=obrazek.shape[0]
    N=obrazek.shape[1]
    x1 = np.min(obrazek)
    x2 = np.max(obrazek)
    wektor = np.zeros((M,N))
    for i in range (0,M):
        for j in range (0,N):
          wektor[i,j]=((obrazek[i,j] - x1)/(x2-x1))
          
                
            
    wektor = wektor*255;
    wektor=wektor.astype(int);      
    return wektor;
    

    #
    
plot.imshow(obraz,cmap='gray')
plot.show();
histogram(obraz,256);
    
rozobr=rozciaganie(obraz);    
plot.imshow(rozobr,cmap='gray')
plot.show(); 
histogram(rozobr,256);

print('Potegowanie');
powobr = np.power(obraz,2)*0.01;
powobr[powobr>255]=255;
powobr=powobr.astype(int);
plot.imshow(powobr,cmap='gray')
plot.show(); 
histogram(powobr,256);

print('Pierwiastkowanie');
sqrobr = np.sqrt(obraz);
sqrobr[sqrobr>255]=255;
sqrobr=sqrobr.astype(int);
plot.imshow(sqrobr,cmap='gray')
plot.show(); 
#sqrobr=rozciaganie(sqrobr)
histogram(sqrobr,256);

print('Logarytmowanie');
logobr = 5*np.log(obraz);
logobr[logobr>255]=255;
logobr[logobr<0]=0;
logobr=logobr.astype(int);
plot.imshow(logobr,cmap='gray')
plot.show(); 
histogram(logobr,256);


print('E');
eobr = np.power(np.e,obraz)*0.00000000000000000000000000000001;
eobr[eobr>255]=255;
eobr[eobr<0]=0;
eobr=eobr.astype(int);
plot.imshow(eobr,cmap='gray')
plot.show(); 
histogram(eobr,256);

print("Wyrownywanie")
#wyrobr=obraz[:,:];
wyrobr=image.imread('kierowca.png')
wyrobr=wyrobr[:,:,0]
wyrobr = wyrobr*255;
wyrobr=wyrobr.astype(int);
x = np.arange(256)
# zwykly histogram
hist = histogram(wyrobr,256)
# dystrybuanta
d = np.cumsum(hist) #zwraca laczna sume elementow wzdluz danej osi
dfmin = d[d>0][0]
M = wyrobr.shape[0]
N = wyrobr.shape[1]
h = np.round(((d - dfmin) / ((M*N) - 1)) * (256 - 1))

h=h.astype(int);
wyrobr = h[wyrobr]
hist = histogram(wyrobr,256)

plot.plot(x, hist)
plot.plot(x, h)
plot.show(); 
plot.imshow(wyrobr,cmap='gray')
plot.show()















