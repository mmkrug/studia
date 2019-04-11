import numpy as np
import matplotlib.pyplot as plot
import matplotlib.image as image


oryginal = image.imread('E:\Workspace\Python\kierowca.png')
oryginal = oryginal[:,:,0]

ile = 0;

def jasnosc (obraz):
    M = obraz.shape[0]
    N = obraz.shape[1]
    
    suma = 0
    for x in range (0,M):
        for y in range (0,N):
            suma = suma + obraz[x,y]
    
    J = suma/(M*N)
    
    return J
    


def kontrast (obraz):
    M = obraz.shape[0]
    N = obraz.shape[1]
    jas = jasnosc(obraz)
    
    suma = 0
    for x in range (0,M):
        for y in range (0,N):
            suma = suma + np.power((obraz[x,y] - jas),2)
    
    K=np.sqrt(suma/(M*N))
    
    return K


#       ORYGINAŁ
plot.imshow(oryginal, cmap='gray', vmin=0, vmax=1)
plot.show();
print("Oryginał.")
print("Janosc:   ",jasnosc(oryginal))
print("Kontrast: ",kontrast(oryginal))

#       DODAWANIE
ile = 0.4
plot.subplot(121)
plot.imshow(oryginal, cmap='gray', vmin=0, vmax=1)
kopia = oryginal.copy() + ile
plot.subplot(122)
plot.imshow(kopia, cmap='gray', vmin=0, vmax=1)
plot.show()
print("Dodane: ", ile)
print("Janosc:   ",jasnosc(kopia))
print("Kontrast: ",kontrast(kopia))

#       MNOZENIE
ile = 1.8
plot.subplot(121)
plot.imshow(oryginal, cmap='gray', vmin=0, vmax=1)
kopia = oryginal * ile
plot.subplot(122)
plot.imshow(kopia, cmap='gray', vmin=0, vmax=1)
plot.show()
print("Mnozenie: ",ile)
print("Janosc:   ",jasnosc(kopia))
print("Kontrast: ",kontrast(kopia))

#       POTEGOWANIE
plot.subplot(121)
plot.imshow(oryginal, cmap='gray', vmin=0, vmax=1)
kopia = np.power(oryginal,2)
plot.subplot(122)
plot.imshow(kopia, cmap='gray', vmin=0, vmax=1)
plot.show()
print("Potegowanie")
print("Janosc:   ",jasnosc(kopia))
print("Kontrast: ",kontrast(kopia))

#       PIERWIASTKOWANIE
plot.subplot(121)
plot.imshow(oryginal, cmap='gray', vmin=0, vmax=1)
kopia = np.sqrt(oryginal)
plot.subplot(122)
plot.imshow(kopia, cmap='gray', vmin=0, vmax=1)
plot.show()
print("Pierwiastkowanie")
print("Janosc:   ",jasnosc(kopia))
print("Kontrast: ",kontrast(kopia))

#       LOGARYTMOWANIE
plot.subplot(121)
plot.imshow(oryginal, cmap='gray', vmin=0, vmax=1)
kopia = np.log1p(oryginal)
plot.subplot(122)
plot.imshow(kopia, cmap='gray', vmin=0, vmax=1)
plot.show()
print("Logarytmowanie")
print("Janosc:   ",jasnosc(kopia))
print("Kontrast: ",kontrast(kopia))