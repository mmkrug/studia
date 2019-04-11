import numpy as np
import matplotlib.pyplot as plot
import matplotlib.image as image

obraz=image.imread('kierowca.png')
obraz=obraz[:,:,0]


def jasnosc (obraz):
    M = obraz.shape[0]
    N = obraz.shape[1]
    
    suma = 0
    for i in range (0,M):
        for j in range (0,N):
            suma = suma + obraz[i,j]
    
    J= suma/(M*N)
    
    return J
    

def kontrast (obraz):
    M = obraz.shape[0]
    N = obraz.shape[1]
    jas = jasnosc(obraz)
    
    suma = 0
    for i in range (0,M):
        for j in range (0,N):
            suma =suma + np.power((obraz[i,j] - jas),2)
    
    
    k=np.sqrt( suma/(M*N))
    
    
    return k




#print (obraz)
#obraz = np.power(obraz,2)
print("Janosc ",jasnosc(obraz))
print("Kontrast",kontrast(obraz))

ile = 5;
jassqrt = [0];
konsqrt = [0];
rozmiar = [0];

obrazsqrt = obraz;
jassqrt[0] = jasnosc(obrazsqrt);
konsqrt[0] = kontrast(obrazsqrt);

for i in range (1,ile):
    obrazsqrt = np.power(obraz,(1/ile));
    jassqrt.append(jasnosc(obrazsqrt));
    konsqrt.append(kontrast(obrazsqrt));
    rozmiar.append(i);


jaspow = [0];
konpow = [0];

obrazpow = obraz;
jaspow[0] = jasnosc(obrazpow);
konpow[0] = kontrast(obrazpow);

for i in range (1,ile):
    obrazpow = np.power(obrazpow,ile);
    jaspow.append(jasnosc(obrazpow));
    konpow.append(kontrast(obrazpow));
    

jasmn = [0];
konmn = [0];

obrazmn = obraz;
jasmn[0] = jasnosc(obrazmn);
konmn[0] = kontrast(obrazmn);

for i in range (1,ile):
    obrazmn = obraz*ile;
    jasmn.append(jasnosc(obrazmn));
    konmn.append(kontrast(obrazmn));
    
jasdz = [0];
kondz = [0];

obrazdz = obraz;
jasdz[0] = jasnosc(obrazdz);
kondz[0] = kontrast(obrazdz);

for i in range (1,ile):
    obrazdz = obraz*(1/ile);
    jasdz.append(jasnosc(obrazdz));
    kondz.append(kontrast(obrazdz));
   





plot.subplot(151)
plot.imshow(obraz)
plot.subplot(152)
plot.imshow(obrazsqrt)
plot.subplot(153)
plot.imshow(obrazpow)
plot.subplot(154)
plot.imshow(obrazmn)
plot.subplot(155)
plot.imshow(obrazdz)
plot.show()

plot.subplot(121)
plot.plot(rozmiar,jassqrt,'g')
plot.subplot(122)
plot.plot(rozmiar,konsqrt,'b')
plot.show()

plot.subplot(121)
plot.plot(rozmiar,jaspow,'g')
plot.subplot(122)
plot.plot(rozmiar,konpow,'b')
plot.show()

plot.subplot(121)
plot.plot(rozmiar,jasmn,'g')
plot.subplot(122)
plot.plot(rozmiar,konmn,'b')
plot.show()

plot.subplot(121)
plot.plot(rozmiar,jasdz,'g')
plot.subplot(122)
plot.plot(rozmiar,kondz,'b')
plot.show()



        
