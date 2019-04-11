import numpy as np

def wprowadzenie(rownanie):
    print('Podaj a:')
    rownanie.append(int(input()))
    print('Podaj b:')
    rownanie.append(int(input()))
    print('Podaj c:')
    rownanie.append(int(input()))
    print('Podaj d:')
    rownanie.append(int(input()))
    return rownanie


def formatuj_rownanie(rownanie):
    if(rownanie[0]!=0):
        print(rownanie[0],'xx',sep='',end='')
    #wypisanie b
    if( (rownanie[1]>0) and (rownanie[0]!=0) ):
        print('+',rownanie[1],'x',sep='',end='')
    elif(rownanie[1] != 0):
        print(rownanie[1],'x',sep='',end='')
        
    #wypisanie c
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
        
        
    #wypisanie d
    if(rownanie[3]>0 and (rownanie[0]!=0 or rownanie[1]!=0 or rownanie[2]!=0 )):
        print('+',rownanie[3],sep='',end='')
    elif(rownanie[3]!=0):
        print(rownanie[3],sep='',end='')
        
    if(rownanie[0]==0 and rownanie[1]==0 and rownanie[2]==0 and rownanie[3]==0):
        print('0',sep='',end='')
        
    print(' = 0 ',sep='')
    #end formatuj_rownanie
    


def oblicz_delte(rownanie):
    return np.power(rownanie[1],2)-4*rownanie[0]*rownanie[2]-4j*rownanie[0]*rownanie[3]

    
    
def oblicz_pdelte(delta):
    return np.sqrt(delta)
    

def oblicz_rownanie(rownanie,rozwiazanie):
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
    

def dodaj(rozwiazanie,suma):
    if( np.imag(rozwiazanie[0]) != 0 ):
        suma.append( rozwiazanie[1]+rozwiazanie[2]+rozwiazanie[3]+rozwiazanie[4] )
    elif(np.real(rozwiazanie[0]) > 0 ):
        suma.append( np.real( rozwiazanie[1])+np.real(rozwiazanie[2])  )
    elif(np.real(rozwiazanie[0]) < 0 ):
        suma.append( rozwiazanie[1]+rozwiazanie[2] )
    return suma
def odejmij(rozwiazanie,roznica):
    if( np.imag(rozwiazanie[0]) != 0 ):
        roznica.append( rozwiazanie[1]-rozwiazanie[2]-rozwiazanie[3]-rozwiazanie[4] )
    elif(np.real(rozwiazanie[0]) > 0 ):
        roznica.append( np.real( rozwiazanie[1])-np.real(rozwiazanie[2])  )
    elif(np.real(rozwiazanie[0]) < 0 ):
        roznica.append( rozwiazanie[1]-rozwiazanie[2] )
    return roznica
def pomnoz(rozwiazanie,iloraz):
    if( np.imag(rozwiazanie[0]) != 0 ):
        iloraz.append( rozwiazanie[1]*rozwiazanie[2]*rozwiazanie[3]*rozwiazanie[4] )
    elif(np.real(rozwiazanie[0]) > 0 ):
        iloraz.append( np.real( rozwiazanie[1])*np.real(rozwiazanie[2])  )
    elif(np.real(rozwiazanie[0]) < 0 ):
        iloraz.append( rozwiazanie[1]*rozwiazanie[2] )
    return iloraz


def wyswietlenie(rownanie,rozwiazanie,suma,roznica,iloraz):
    if(rownanie[0]!=0 and rownanie[3]==0):       
        #1.1
        print('Delta: ',rozwiazanie[0])
        if(np.real(rozwiazanie[0]) > 0):
            print('x1: ',np.real(rozwiazanie[1]))  
            print('x2: ',np.real(rozwiazanie[2]))
            print('Suma: ',np.real(suma[0]))
            print('Roznica: ',np.real(roznica[0]))
            print('Iloraz: ',np.real(iloraz[0]))
    
        #1.2
        if(np.real( rozwiazanie[0] ) == 0 ):
           print('x1: ',np.real(rozwiazanie[1])) 
    
        #1.3
        if(np.real(rozwiazanie[0] ) < 0 ):
            print('x1: ',rozwiazanie[1])  
            print('x2: ',rozwiazanie[2])
            print('Suma: ',suma[0])
            print('Roznica: ',roznica[0])
            print('Iloraz: ',iloraz[0])
    
    
    #2
    if( rownanie[0] == 0 and rownanie[1]!=0 and rownanie[3]==0):
         print('x1: ',np.real(rozwiazanie[1]))  
         
    #3
    if(rownanie[0]==0 and rownanie[1]==0 and (rownanie[2]!=0 or rownanie[3]!=0)):
        print('Rownanie sprzeczne')
    
    #4
    if(rownanie[0]==0 and rownanie[1]==0 and rownanie[2]==0 and rownanie[3]==0):
        print('Rownanie tozsamosciowe')
    
    #5
    if( rownanie[0]==0 and rownanie[1]!=0 and rownanie[3]!=0):
        print('x1: ',rozwiazanie[1])  
        
    #6
    if (rownanie[0]!=0 and rownanie[3]!=0):
         print('Delta: ',rozwiazanie[0])
         print('x1: ',rozwiazanie[1])  
         print('x2: ',rozwiazanie[2])
         print('x3: ',rozwiazanie[3])
         print('x4: ',rozwiazanie[4])
         print('Suma: ',suma[0])
         print('Roznica: ',roznica[0])
         print('Iloraz: ',iloraz[0])
    
    
    
0rownanie=[]
rozwiazanie=[] 
suma=[]
roznica=[]
iloraz=[]

rownanie=wprowadzenie(rownanie)   
rozwiazanie=oblicz_rownanie(rownanie,rozwiazanie)
formatuj_rownanie(rownanie)
suma=dodaj(rozwiazanie,suma)
roznica=odejmij(rozwiazanie,roznica)
iloraz=pomnoz(rozwiazanie,iloraz)

wyswietlenie(rownanie,rozwiazanie,suma,roznica,iloraz)
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    