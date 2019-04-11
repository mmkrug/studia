import numpy as py
import sys

def printf(format, *args):
    sys.stdout.write(format % args)

x1r=0.0
x2r=0.0
x3r=0.0
x4r=0.0
x1u=0.0
x2u=0.0
x3u=0.0
x4u=0.0
sr=0.0
su=0.0
ir=0.0
iu=0.0
rr=0.0
ru=0.0
ilr=0.0
ilu=0.0
pp=0.0
po=0.0
ppr=0.0
ppu=0.0
por=0.0
pou=0.0
x1=0
x2=0
x3=0
x4=0

def wprowadz_dane():
    print("Podaj liczby: ")
    a = input("a= ")
    b = input("b= ")
    c = input("c= ")
    d = input("d= ")
    a = float(a)
    b = float(b)
    c = float(c)
    d = float(d)
    args = a,b,c,d
    return args

a,b,c,d = wprowadz_dane()

def formatuj_rownanie(a,b,c,d):
    a = int(a)
    b = int(b)
    c = int(c)
    d = int(d)
    if a > 0:
        printf('%rxx',a) 
    elif a<0:
        printf('%rxx',a)
    else:
        printf(' ')
    if b>0 and a != 0:
        printf('+%rx',b)
    elif b>0 and a==0:
        printf('%rx',b)
    elif b<0:
        printf('%rx',b)
    elif b==0 and a!=0:
        printf(' ')
    else: 
        printf(' ')
    if c>0:
        printf('+%r',c)
    elif c<0:
        printf('%r',c)
    else:
        printf (' ')
    if d>0 and c==0 and b==0 and a==0:
        printf('+%ri=0',d)
    elif d<0:
        printf('%ri=0',d)
    else:
        printf('=0')
    
def oblicz_d_r(a,b,c):
    deltar = (b*b)-(4*a*c)
    return deltar

def oblicz_d_u(a,d):
    deltau= -(4*a*d)
    return deltau

def oblicz_p_d_r(deltar, deltau):
    pdeltar = py.sqrt((py.sqrt((deltar*deltar) + (deltau*deltau)) + deltar) /2 )
    return pdeltar
    
def oblicz_p_d_u(deltar, deltau):
    pdeltau = py.sqrt((py.sqrt((deltar*deltar) + (deltau*deltau)) - deltar) /2 )
    return pdeltau
    
def oblicz_rownanie(a,b,c,d,x1r,x2r,x3r,x4r,x1u,x2u,x3u,x4u):
   #1
    #print(a)
    #print(b)
    #print(c)
    #print(d)
    if a!=0 and d==0:
        deltar = oblicz_d_r(a,b,c)
        deltau = oblicz_d_u(a,d)
        #1.1
        if deltar > 0:
            pdeltar = oblicz_p_d_r(deltar,deltau)
            x1r = (-float(b) -pdeltar) / (2*a)
            x2r = (-float(b) +pdeltar) / (2*a)
            
        #1.2
        if deltar == 0:
            x1r = -float(b) / (2*a)
           
        #1.3
        if deltar < 0:
            deltar = -deltar
            pdeltar = oblicz_p_d_r(deltar, deltau)
            x1r = -float(b) / (2*a)
            x1u = -(pdeltar/(2*a))
            x2r = x1r
            x2u = -x1u
           
    #2        
    if a==0 and b!=0 and d==0:
        x1r = -float(c) / b
       
    #3
    if a==0 and b==0 and (c!=0 or d!=0):
        print("Rownanie sprzeczne!")
    #4
    if a==0 and b==0 and c==0 and d==0:
        print("Rownanie tozsamosciowe!")
    #5
    if a==0 and b!=0 and d!=0:
        x1r = -float(c)/b
        x1u = -float(d)/b
      
    #6
    if a!=0 and d!=0:
        deltar = oblicz_d_r(a,b,c)
        deltau = oblicz_d_u(a,d)
        pdeltar = oblicz_p_d_r(deltar, deltau)
        pdeltau = oblicz_p_d_u(deltar,deltau)
        x1r = (-b-pdeltar)/ (2*a)
        x1u = (-b-pdeltau)/(2*a)
        x2r = (-b+pdeltar)/ (2*a)
        x2u = (-b+pdeltau)/(2*a)
        x3r = (b+pdeltar)/ (2*a)
        x3u = (b+pdeltau)/(2*a)
        x4r = (b-pdeltar)/ (2*a)
        x4u = (b-pdeltau)/(2*a)
        

        
        
    argx = x1r, x2r, x3r, x4r, x1u, x2u, x3u, x4u
    return argx
    
def dodaj(sr, su, deltar, deltau, x1r, x1u, x2r, x2u, x3r, x3u, x4r, x4u):
    if deltau != 0:
        sr = x1r + x2r + x3r + x4r
        su = x1u + x2u + x3u + x4u
    
    elif deltar > 0:
        sr = x1r + x2r

    elif deltar < 0:
        sr = x1r + x2r
        su = x1u + x2u
    argsuma = sr,su
    return argsuma

def odejmij(rr, ru, deltar, deltau, x1r, x1u, x2r, x2u, x3r, x3u, x4r, x4u):
    if deltau != 0:
        rr = x1r - x2r - x3r - x4r
        ru = x1u - x2u - x3u - x4u
    elif deltar > 0:
        rr = x1r - x2r
    elif deltar < 0:
        rr = x1r - x2r
        ru = x1u - x2u
    argroznica = rr,ru
    return argroznica
        
def pomnoz(ir, iu, deltar, deltau, x1r, x1u, x2r, x2u, x3r, x3u, x4r, x4u):
    if deltau !=0:
        ir = ((x1r * x2r - x1u * x2u) * (x3r * x4r - x3u * x4u)) - ((x1r * x1u + x2r * x2u) * (x3r * x4u + x4r * x3u))
        iu = ((x1r * x2r - x1u * x2u) * (x3r * x4u + x4r * x3u)) + ((x1r * x2u + x2r * x1u) * (x3r * x4r - x3u * x4u))
        
    elif deltar > 0:
        ir = x1r * x2r
        
    elif deltar < 0:
        ir = (x1r * x2r - x1u * x2u)
        iu = (x1r * x2u + x2r * x1u)
    argiloczyn = ir,iu
    return argiloczyn
    
    
def iloraz(ilr, ilu, deltar, deltau, x1r, x1u, x2r, x2u, x3r, x3u, x4r, x4u):
    if a!=0 and d==0 and deltar >0:
        ilr = x1r/ x2r
        ilu = 0
    elif a!=0 and d==0 and deltar <0:
        ilr = ((x1r*x2r)+(x1u*x2u))/((x2r*x2r) + (x2u*x2u))
        ilu = ((x1r*x2r)-(x1u*x2u))/((x2r*x2r) + (x2u*x2u))
    elif a!=0 and d!=0:
        x1 = complex(x1r,x1u)
        x2 = complex(x2r,x2u)
        x3 = complex(x3r,x3u)
        x4 = complex(x4r,x4u)
        ilr = x1.real / x2.real / x3.real / x4.real
        ilu = x1.imag / x2.imag / x3.imag / x4.imag
        
    argiloraz = ilr, ilu
    return argiloraz
    
def przodw(pp, po, deltar, deltau, x1r, x1u, x2r, x2u, x3r, x3u, x4r, x4u): #przeciwny i odwrotny
    if a!=0 and d==0 and deltar==0:
        pp = -x1r
        po = 1/x1r
    elif a==0 and b!=0 and d==0:
        pp = -x1r
        po = 1/x1r
    argprzodw = pp,po
    return argprzodw
    
def pppiaty(ppr, ppu, por, pou, deltar, deltau, x1r, x1u, x2r, x2u, x3r, x3u, x4r, x4u): #punkt piaty
    if a==0 and b!=0 and d!=0:
        ppr = -x1r
        ppu = -x1u
        por = (x1r / ((x1r*x1r) +(x1u*x1u)))
        pou = (-x1r / ((x1r*x1r) +(x1u*x1u)))
    argpppiaty = ppr, ppu, por, pou 
    return argpppiaty
    
def wyswietl_wynik(a,b,c,d,x1r, x1u, x2r, x2u, x3r, x3u, x4r, x4u, su, ru, iu, sr, rr, ir):

    if a!=0 and d==0:
        deltar = oblicz_d_r(a,b,c)
        deltau = oblicz_d_u(a,d)
        #1.1
        if deltar > 0:
            printf("x1r = %f \n", x1r)
            printf("x2r = %f \n", x2r)
            printf("\n");
            printf("sr = %f \n", sr)
            printf("rr = %f \n", rr)
            printf("ir = %f \n", ir)
            printf("iloraz r= %f", ilr)
            printf("iloraz u= %f",ilu)
        #1.2
        if deltar == 0:
            printf("x1r = %f \n", x1r)
            printf("przeciwny = %f",pp)
            printf("odwrotny = %f",po)
        #1.3
        if deltar < 0:
            printf("x1r = %f \n", x1r)
            printf("x1u = %f \n", x1u)
            printf("x2r = %f \n", x2r)
            printf("x2u = %f \n", x2u)
            printf("\n")
            printf("sr = %f \n", sr)
            printf("su = %f \n", su)
            printf("rr = %f \n", rr)
            printf("ru = %f \n", ru)
            printf("ir = %f \n", ir)
            printf("iu = %f \n", iu)
            printf("iloraz= %f + %fi\n", ilr, ilu)

    #2        
    if a==0 and b!=0 and d==0:
        printf("x1r = %f \n", x1r)
        printf("przeciwny = %f\n",pp)
        printf("odwrotny = %f\n",po)

    #5
    if a==0 and b!=0 and d!=0:
        printf("x1r = %f \n", x1r)
        printf("x1u = %f \n", x1u)
        printf("Przeciwny r = %f\n",ppr)
        printf("Przeciwny u = %f\n",ppu)
        printf("Odwrotny r = %f\n", por)
        printf("Odwrotny u = %f\n", pou)
    #6
    if a!=0 and d!=0:
        deltar = oblicz_d_r(a, b, c)
        deltau = oblicz_d_u(a, d)
        printf("Delta = %f ", deltar)
        if deltau > 0:
            printf("+ ")
        printf("%fi\n", deltau)
        printf("x1r = %f\n", x1r)
        printf("x1u = %f\n", x1u)
        printf("x2r = %f\n", x2r)
        printf("x2u = %f\n", x2u)
        printf("x3r = %f\n", x3r)
        printf("x3u = %f\n", x3u)
        printf("x4r = %f\n", x4r)
        printf("x4u = %f\n", x4u)
        printf("\n")
        printf("sr = %f \n", sr)
        printf("su = %f \n", su)
        printf("rr = %f \n", rr)
        printf("ru = %f \n", ru)
        printf("ir = %f \n", ir)
        printf("iu = %f \n", iu)
        printf("iloraz= %f + %fi\n", ilr, ilu)
        

#wprowadz_dane()
formatuj_rownanie(a,b,c,d)
deltar = oblicz_d_r(a,b,c)
deltau = oblicz_d_u(a,d)
pdeltar = oblicz_p_d_r(deltar, deltau)
pdeltau = oblicz_p_d_u(deltar, deltau)
#oblicz_rownanie(a,b,c,d,x1r,x2r,x3r,x4r,x1u,x2u,x3u,x4u)
x1r, x2r, x3r, x4r, x1u, x2u, x3u, x4u = oblicz_rownanie(a,b,c,d,x1r,x2r,x3r,x4r,x1u,x2u,x3u,x4u)
print("")
sr,su = dodaj(sr, su, deltar, deltau, x1r, x1u, x2r, x2u, x3r, x3u, x4r, x4u)
rr, ru = odejmij(rr, ru, deltar, deltau, x1r, x1u, x2r, x2u, x3r, x3u, x4r, x4u)
ir, iu = pomnoz(ir, iu, deltar, deltau, x1r, x1u, x2r, x2u, x3r, x3u, x4r, x4u)
ilr, ilu = iloraz(ilr, ilu, deltar, deltau, x1r, x1u, x2r, x2u, x3r, x3u, x4r, x4u)
pp, po = przodw(pp, po, deltar, deltau, x1r, x1u, x2r, x2u, x3r, x3u, x4r, x4u)
ppr, ppu, por, pou = pppiaty(ppr, ppu, por, pou, deltar, deltau, x1r, x1u, x2r, x2u, x3r, x3u, x4r, x4u)

print("")
wyswietl_wynik(a,b,c,d,x1r, x1u, x2r, x2u, x3r, x3u, x4r, x4u, su, ru, iu, sr, rr, ir)