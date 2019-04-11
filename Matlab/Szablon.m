clc
close
clear
tic

x0=0.1;
y0=1;
%i=0;
iteracje=0;
krok=5;
dokl=0.01;

z=@(x,y)x.^2+y.^2;
%z=@(x,y)100.*(y-x.^2).^2+(1-x).^2;
%z=@(x,y)-cos(x).*cos(y).*exp(-((x-pi).^2+(y-pi).^2));
%[x,y]=meshgrid([-2.048:0.1:2.048],[-2.048:0.1:2.048]);
[x,y]=meshgrid([-5:0.1:5],[-5:0.1:5]);

%11111111111111

while krok>dokl && i<5
    f1=z(x0,y0);         %zerowy
    f2=z(x0, y0+krok);   %gora
    f3=z(x0+krok, y0);   %prawo
    f4=z(x0, y0-krok);   %dol
    f5=z(x0-krok, y0);   %lewo

    [w,p] = min([f1,f2,f3,f4,f5]);

    switch p
        case 1
            krok= krok /2;
            i = i+1;
        case 2
            y0 = y0+krok;
            i=0;
        case 3
            x0 = x0+krok;
            i=0;
        case 4
            y0 = y0-krok;
            i=0;
        case 5
            x0 = x0-krok;
            i=0;
    end
    iteracje = iteracje + 1;
end

subplot(2,1,1)
mesh(x,y,z(x,y))
%colormap(hot)
subplot(2,1,2)
[c,h]=contour(x,y,z(x,y))
title('Metoda ...')


%axis square
clabel(c,h)
hold on
dx=[-8,-2,-2,0];
dy=[-5,-5,0,0];

plot(dx(1),dy(1),'r*')
text(dx(1),dy(1),'START')
plot(dx(end),dy(end),'r*')
text(dx(end),dy(end),'STOP')

plot(dx(2:end-1),dy(2:end-1),'g.')
plot(dx,dy)
toc

iteracje
[x0, y0]
z(x0,y0)

%w odpowiedzi ma byc:
%x,y minimum
%wartosc funkcji w min
%liczba iteracji  (liczba ile bylo przejsc w nowe miejsce)
%czas tic ... toc

%dobra strona http://geatbx.com/docu/fcnindex-01.html#TopOfPage




