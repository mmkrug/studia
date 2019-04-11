import numpy as np


rownanie=[]
rozwiazanie=[] 
suma=[]
roznica=[]
iloraz=[]


def wprowadz_rownanie():
    zmienne = []
    print('Podaj a:',end='')
    zmienne.append(int(input()))
    print('Podaj b:',end='')
    zmienne.append(int(input()))
    print('Podaj c:',end='')
    zmienne.append(int(input()))
    print('Podaj d:',end='')
    zmienne.append(int(input()))
    return zmienne


def formatuj_rownanie(rownanie):
    if(rownanie[0]!=0):
        print(rownanie[0],'xx',sep='',end='')

    if( (rownanie[1]>0) and (rownanie[0]!=0) ):
        print('+',rownanie[1],'x',sep='',end='')
    elif(rownanie[1] != 0):
        print(rownanie[1],'x',sep='',end='')
        
    if(rownanie[2]>0 and rownanie[0]!=0):
        print('+',rownanie[2],sep='',end='')
    elif(rownanie[2]>0 and rownanie[1]!=0):
        print('+',rownanie[2],sep='',end='')
    elif(rownanie[2]<0 and rownanie[0]!=0):
        print(rownanie[2],sep='',end='')
    elif(rownanie[2]<0 and rownanie[1]!=0):
        print(rownanie[2],sep='',end='')
    elif(rownanie[2]!=0):
        print(rownanie[2],sep='',end='')
        
    if(rownanie[3]>0 and (rownanie[0]!=0 or rownanie[1]!=0 or rownanie[2]!=0 )):
        print('+',rownanie[3],sep='',end='')
    elif(rownanie[3]!=0):
        print(rownanie[3],sep='',end='')
        
    if(rownanie[0]==0 and rownanie[1]==0 and rownanie[2]==0 and rownanie[3]==0):
        print('0',sep='',end='')
        
    print(' = 0 ',sep='')
    


def oblicz_delte(rownanie):
    return np.power(rownanie[1],2)-4*rownanie[0]*rownanie[2]-4j*rownanie[0]*rownanie[3]
    

def oblicz_pdelte(delta):
    return np.sqrt(delta)
    

def oblicz_rownanie(rownanie,rozwiazanie):
    #rozwiazanie = []
    if(rownanie[0]!=0 and rownanie[3]==0):
        rozwiazanie.append(oblicz_delte(rownanie))
        #1.1
        if(np.real(oblicz_delte(rownanie)) > 0):
            rozwiazanie.append( (-rownanie[1]-np.real( oblicz_pdelte(oblicz_delte(rownanie)) )) / (2*rownanie[0]) )
            rozwiazanie.append( (-rownanie[1]+np.real( oblicz_pdelte(oblicz_delte(rownanie)) )) / (2*rownanie[0]) )
    
        #1.2
        if(np.real( oblicz_delte(rownanie) ) == 0 ):
            rozwiazanie.append( -rownanie[1]/2*rownanie[0] )
    
        #1.3
        if(np.real( oblicz_delte(rownanie) ) < 0 ):
            rozwiazanie.append(0.5*(-rownanie[1]-np.sqrt(-np.real(oblicz_delte(rownanie)))*1j)/rownanie[0])
            rozwiazanie.append(np.conj(rozwiazanie[1]))
            
    
    
    #2
    if( rownanie[0] == 0 and rownanie[1]!=0 and rownanie[3]==0):
        rozwiazanie.append(-(rownanie[2]/rownanie[1]))
        
    #5
    if( rownanie[0]==0 and rownanie[1]!=0 and rownanie[3]!=0):
        rozwiazanie.append( -(rownanie[2]/rownanie[1]) -1j*(rownanie[3]/rownanie[1]))
        
        
    #6
    if (rownanie[0]!=0 and rownanie[3]!=0):
        rozwiazanie.append(oblicz_delte(rownanie))
        
        rozwiazanie.append((-rownanie[1]-np.real(oblicz_pdelte(rozwiazanie[0]))- ((rownanie[1]-np.imag(oblicz_pdelte(rozwiazanie[0])))*1j))/(2*rownanie[0]))
        rozwiazanie.append((-rownanie[1]-np.real(oblicz_pdelte(rozwiazanie[0]))-((rownanie[1]+np.imag(oblicz_pdelte(rozwiazanie[0])))*1j))/(2*rownanie[0]))
        rozwiazanie.append((-rownanie[1]+np.real(oblicz_pdelte(rozwiazanie[0]))-((rownanie[1]+np.imag(oblicz_pdelte(rozwiazanie[0])))*1j))/(2*rownanie[0]))
        rozwiazanie.append((-rownanie[1]+np.real(oblicz_pdelte(rozwiazanie[0]))-((rownanie[1]-np.imag(oblicz_pdelte(rozwiazanie[0])))*1j))/(2*rownanie[0]))
        
    return rozwiazanie
    

def dodaj(dane_wej,rozwiazanie,suma):
    #if(dane_wej[3]!=0):
    if( np.imag(rozwiazanie[0]) != 0 ):
        suma.append( rozwiazanie[1]+rozwiazanie[2]+rozwiazanie[3]+rozwiazanie[4] )
    elif(np.real(rozwiazanie[0]) > 0 ):
        suma.append( np.real( rozwiazanie[1])+np.real(rozwiazanie[2])  )
    elif(np.real(rozwiazanie[0]) < 0 ):
        suma.append( rozwiazanie[1]+rozwiazanie[2] )
    return suma


def odejmij(dane_wej,rozwiazanie,roznica):
    #if(dane_wej[3]!=0):
    if( np.imag(rozwiazanie[0]) != 0 ):
        roznica.append( rozwiazanie[1]-rozwiazanie[2]-rozwiazanie[3]-rozwiazanie[4] )
    elif(np.real(rozwiazanie[0]) > 0 ):
        roznica.append( np.real( rozwiazanie[1])-np.real(rozwiazanie[2])  )
    elif(np.real(rozwiazanie[0]) < 0 ):
        roznica.append( rozwiazanie[1]-rozwiazanie[2] )
    return roznica


def pomnoz(dane_wej,rozwiazanie,iloczyn):
    #if(dane_wej[3]!=0):
    if( np.imag(rozwiazanie[0]) != 0 ):
        iloraz.append( rozwiazanie[1]*rozwiazanie[2]*rozwiazanie[3]*rozwiazanie[4] )
    elif(np.real(rozwiazanie[0]) > 0 ):
        iloraz.append( np.real( rozwiazanie[1])*np.real(rozwiazanie[2])  )
    elif(np.real(rozwiazanie[0]) < 0 ):
        iloraz.append( rozwiazanie[1]*rozwiazanie[2] )
    return iloczyn

def iloraz(rozwiazanie,iloraz):
    
    
    
    return iloraz


def wyswietlenie(rownanie,rozwiazanie,suma,roznica,iloraz):
    #if rownanie[3] in locals:
    if(rownanie[0]!=0 and rownanie[3]==0):       
        #1.1
        print('Delta: ',rozwiazanie[0])
        if(np.real(rozwiazanie[0]) > 0):
            print('x1: ',np.real(rozwiazanie[1]))  
            print('x2: ',np.real(rozwiazanie[2]))
            print('Suma: ',np.real(suma[0]))
            print('Roznica: ',np.real(roznica[0]))
            #print('Iloraz: ',np.real(iloraz[0]))
    
        #1.2
        if(np.real( rozwiazanie[0] ) == 0 ):
           print('x1: ',np.real(rozwiazanie[1])) 
    
        #1.3
        if(np.real(rozwiazanie[0] ) < 0 ):
            print('x1: ',rozwiazanie[1])  
            print('x2: ',rozwiazanie[2])
            print('Suma: ',suma[0])
            print('Roznica: ',roznica[0])
            #print('Iloraz: ',iloraz[0])
    
    
    #2
    if( rownanie[0] == 0 and rownanie[1]!=0 and rownanie[3]==0):
         print('x1: ',np.real(rozwiazanie[0]))  
         
    #3
    if(rownanie[0]==0 and rownanie[1]==0 and (rownanie[2]!=0 or rownanie[3]!=0)):
        print('Rownanie sprzeczne')
    
    #4
    if(rownanie[0]==0 and rownanie[1]==0 and rownanie[2]==0 and rownanie[3]==0):
        print('Rownanie tozsamosciowe')
    
    #5
    if( rownanie[0]==0 and rownanie[1]!=0 and rownanie[3]!=0):
        print('x1: ',rozwiazanie[0])  
        
    #6
    if (rownanie[0]!=0 and rownanie[3]!=0):
         print('Delta: ',rozwiazanie[0])
         print('x1: ',rozwiazanie[1])  
         print('x2: ',rozwiazanie[2])
         print('x3: ',rozwiazanie[3])
         print('x4: ',rozwiazanie[4])
         print('Suma: ',suma[0])
         print('Roznica: ',roznica[0])
         #print('Iloraz: ',iloraz[0])
    
    

dane_wej = wprowadz_rownanie()   
rozwiazanie = oblicz_rownanie(dane_wej,rozwiazanie)
print(rozwiazanie)
formatuj_rownanie(dane_wej)
suma = dodaj(dane_wej,rozwiazanie,suma)
roznica = odejmij(dane_wej,rozwiazanie,roznica)
#iloraz = pomnoz(dane_wej,rozwiazanie,iloraz)

wyswietlenie(dane_wej,rozwiazanie,suma,roznica,iloraz)
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    