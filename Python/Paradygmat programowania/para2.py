import numpy as np

dane_wej = []        #a, b, c, d
delta = 0
            #x1,x2,x3,x4,  suma,roznica,iloczyn,iloraz,przeciwny,odwrotny
rozwiazania = [0,0,0,0,0,0,0,0,0,0]     

def wprowadz_dane(dane):
    dane.append(int(input("a= ")))
    dane.append(int(input("b= ")))
    dane.append(int(input("c= ")))
    dane.append(int(input("d= ")))
    
    return



def formatuj_rownanie(dane):
    if(dane[0] == 0 and dane[1] == 0 and dane[2] == 0 and dane[3] == 0):
        print("0 = 0")
    else:
        if(dane[0] != 0):
            print(dane[0],"xx",sep='',end=' ')
        
        if(dane[0] != 0 and dane[1] > 0):
            print('+',dane[1],'x',sep='',end=' ')
        elif(dane[1] != 0):
            print(dane[1],'x',sep='',end=' ')
            
        if((dane[0] !=0 or dane[1] != 0) and dane[2] > 0):
            print('+',dane[2],sep='',end=' ')
        elif(dane[2] != 0):
            print(dane[2],sep='',end=' ')
            
        if((dane[0] !=0 or dane[1] != 0 or dane[2] != 0) and dane[3] > 0):
            print('+',dane[3],'i',sep='',end=' ')
        elif(dane[3] != 0):
            print(dane[3],'i',sep='',end=' ')
    
        print('= 0\n')
    return


def oblicz_delte(dane):
    return np.power(dane[1],2)-4*dane[0]*dane[2]-4j*dane[0]*dane[3]
    

def oblicz_p_delte(delta):
    return np.sqrt(delta)


def oblicz_rownanie(dane,rozwiazania):
    
    #1.  a!=0, d==0
    if(dane[0] != 0 and dane[3] == 0):
        delta = oblicz_delte(dane)
        p_delta = oblicz_p_delte(np.real(delta))
        print('p_delta/2a=',p_delta/(2*dane[0]))
        #print(delta)
        
        #1.1
        if(np.real(delta) > 0):
            rozwiazania[0] = (-dane[1] - np.real(p_delta)) / (2*dane[0])
            rozwiazania[1] = (-dane[1] + np.real(p_delta)) / (2*dane[0])
            
        #1.2
        if(np.real(delta) == 0 ):
            rozwiazania[0] = -dane[1] / (2*dane[0])
    
        #1.3
        if(np.real(delta) < 0 ):
            rozwiazania[0] = (-dane[1]/(2*dane[0])) - (np.sqrt(-np.real(delta))/(2*dane[0]))*1j
            rozwiazania[1] = np.conj(rozwiazania[0])
    
    #2.  a == 0, b != 0, d == 0
    if( dane[0] == 0 and dane[1] != 0 and dane[3]==0):
        rozwiazania[0] = -dane[2]/dane[1]
        
    #5.
    if( dane[0] == 0 and dane[1] != 0 and dane[3] != 0):
        rozwiazania[0] = (-dane[2]/dane[1]) - (dane[3]/dane[1])*1j
        
    #6.
    if (dane[0]!=0 and dane[3]!=0): 
        delta = oblicz_delte(dane)
        rozwiazania[0] = ((-dane[1]-np.real(oblicz_p_delte(delta)))/(2*dane[0])) - ((dane[1]-np.imag(oblicz_p_delte(delta)))/(2*dane[0]))*1j
        rozwiazania[1] = ((-dane[1]-np.real(oblicz_p_delte(delta)))/(2*dane[0])) - ((dane[1]+np.imag(oblicz_p_delte(delta)))/(2*dane[0]))*1j
        rozwiazania[2] = ((-dane[1]+np.real(oblicz_p_delte(delta)))/(2*dane[0])) - ((dane[1]+np.imag(oblicz_p_delte(delta)))/(2*dane[0]))*1j
        rozwiazania[3] = ((-dane[1]+np.real(oblicz_p_delte(delta)))/(2*dane[0])) - ((dane[1]-np.imag(oblicz_p_delte(delta)))/(2*dane[0]))*1j
        
    return

    # SUMA - 4, ROZNICA - 5, ILOCZYN - 6, ILORAZ - 7, PRZECIWNY - 8, ODWROTNY - 9

def suma(dane,rozwiazania):
    delta = oblicz_delte(dane)
    if(np.imag(delta) != 0):
        rozwiazania[4] = rozwiazania[0] + rozwiazania[1] + rozwiazania[2] + rozwiazania[3]
        
    elif(np.real(delta) > 0):
        rozwiazania[4] = np.real(rozwiazania[0]) + np.real(rozwiazania[1])
        
    elif(np.real(delta) < 0):
        rozwiazania[4] = rozwiazania[0] + rozwiazania[1]

    return



def roznica(dane,rozwiazania):
    delta = oblicz_delte(dane)
    if(np.imag(delta) != 0):
        rozwiazania[5] = rozwiazania[0] - rozwiazania[1] - rozwiazania[2] - rozwiazania[3]
        
    elif(np.real(delta) > 0):
        rozwiazania[5] = np.real(rozwiazania[0]) - np.real(rozwiazania[1])
        
    elif(np.real(delta) < 0):
        rozwiazania[5] = rozwiazania[0] - rozwiazania[1]

    return



def iloczyn(dane,rozwiazania):
    delta = oblicz_delte(dane)
    if(np.imag(delta) != 0):
        rozwiazania[6] = rozwiazania[0] * rozwiazania[1] * rozwiazania[2] * rozwiazania[3]
        
    elif(np.real(delta) > 0):
        rozwiazania[6] = np.real(rozwiazania[0]) * np.real(rozwiazania[1])
        
    elif(np.real(delta) < 0):
        rozwiazania[6] = rozwiazania[0] * rozwiazania[1]

    return


def iloraz(dane,rozwiazania):
    delta = oblicz_delte(dane)
    if(np.imag(delta) != 0):
        rozwiazania[7] = rozwiazania[0] / rozwiazania[1] / rozwiazania[2] / rozwiazania[3]
        
    elif(np.real(delta) > 0):
        rozwiazania[7] = np.real(rozwiazania[0]) / np.real(rozwiazania[1])
        
    elif(np.real(delta) < 0):
        rozwiazania[7] = rozwiazania[0] / rozwiazania[1]

    return


def przeciwny(dane,rozwiazania):
    delta = oblicz_delte(dane)
    
    if(dane[0] != 0 and dane[3] == 0 and delta == 0):
        rozwiazania[8] = -rozwiazania[0]
    
    if(dane[0] != 0 and dane[1] != 0 and dane[3] == 0):
        rozwiazania[8] = -rozwiazania[0]

    if(dane[0] == 0 and dane[1] != 0 and dane[3] != 0):
        rozwiazania[8] = -rozwiazania[0]
        
    return


def odwrotny(dane,rozwiazania):
    delta = oblicz_delte(dane)
    
    if(dane[0] != 0 and dane[3] == 0 and delta == 0):
        if(np.real(rozwiazania[0])!=0):
            rozwiazania[9] = 1/rozwiazania[0]
        else:
            rozwiazania[9] = 0

    if(dane[0] != 0 and dane[1] != 0 and dane[3] == 0):
        if(np.real(rozwiazania[0])!=0):
            rozwiazania[9] = 1/rozwiazania[0]
        else:
            rozwiazania[9] = 0

    if(dane[0] == 0 and dane[1] != 0 and dane[3] != 0):
        rozwiazania[9] = ((np.real(rozwiazania[0]))/(np.power(np.real(rozwiazania[0]),2) + np.power(np.imag(rozwiazania[0]),2) ) ) +((-np.imag(rozwiazania[0]))/(np.power(np.real(rozwiazania[0]),2) +np.power(np.imag(rozwiazania[0]),2)))*1j
        
    return


def wyswietl_wynik(dane,rozwiazania):
    
    #1.  a!=0, d==0
    if(dane[0] != 0 and dane[3] == 0):
        delta = oblicz_delte(dane)
        #p_delta = oblicz_p_delte(delta)
        print('Delta = ',delta)
        
        #1.1
        if(np.real(delta) > 0):
            print('x1 = ',rozwiazania[0])
            print('x2 = ',rozwiazania[1])
            print('Suma:      ',rozwiazania[4])
            print('Roznica:   ',rozwiazania[5])
            print('Iloczyn:   ',rozwiazania[6])
            print('Iloraz:    ',rozwiazania[7])

            
        #1.2
        if(np.real(delta) == 0 ):
            print('x1 = ',rozwiazania[0])
            print('Przeciwny: ',rozwiazania[8])
            print('Odwrotny:  ',rozwiazania[9])
    
        #1.3
        if(np.real(delta) < 0 ):
            print('x1 = ',rozwiazania[0])
            print('x2 = ',rozwiazania[1])
            print('Suma:      ',rozwiazania[4])
            print('Roznica:   ',rozwiazania[5])
            print('Iloczyn:   ',rozwiazania[6])
            print('Iloraz:    ',rozwiazania[7])
            
    
    
    #2.  a == 0, b != 0, d == 0
    if( dane[0] == 0 and dane[1] != 0 and dane[3]==0):
        print('x1 = ',rozwiazania[0])
        print('Przeciwny: ',rozwiazania[8])
        print('Odwrotny:  ',rozwiazania[9])
        
    #3.
    if(dane[0] == 0 and dane[1] == 0 and (dane[2] != 0 or dane[3] != 0)):
        print('Rownanie sprzeczne')
    
    #4.
    if(dane[0] == 0 and dane[1] == 0 and dane[2] == 0 and dane[3] == 0):
        print('Rownanie tozsamosciowe')
         
    #5.
    if( dane[0] == 0 and dane[1] != 0 and dane[3] != 0):
        print('x1 = ',rozwiazania[0])
        print('Przeciwny: ',rozwiazania[8])
        print('Odwrotny:  ',rozwiazania[9])
        
    #6.
    if (dane[0]!=0 and dane[3]!=0):
        delta = oblicz_delte(dane)
        print('Delta = ',delta)
        print('x1 = ',rozwiazania[0])
        print('x2 = ',rozwiazania[1])
        print('x3 = ',rozwiazania[2])
        print('x4 = ',rozwiazania[3])
        print('Suma:      ',rozwiazania[4])
        print('Roznica:   ',rozwiazania[5])
        print('Iloczyn:   ',rozwiazania[6])
        print('Iloraz:    ',rozwiazania[7])

    
    return



wprowadz_dane(dane_wej)
#print(dane_wej)
formatuj_rownanie(dane_wej)

oblicz_rownanie(dane_wej,rozwiazania)
suma(dane_wej,rozwiazania)
roznica(dane_wej,rozwiazania)
iloczyn(dane_wej,rozwiazania)
iloraz(dane_wej,rozwiazania)
przeciwny(dane_wej,rozwiazania)
odwrotny(dane_wej,rozwiazania)

wyswietl_wynik(dane_wej,rozwiazania)



























