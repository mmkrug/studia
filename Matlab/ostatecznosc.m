clc
clear
close

tic
%[x,y]=meshgrid([-5:0.1:5],[-5:0.1:5]);
[x,y]=meshgrid([-2:0.1:2],[-1:0.1:3]);
%[x,y]=meshgrid([-20:0.1:20],[-20:0.1:20]);
x0=-3;
y0=2;
k=1;
dokl=0.0001;
dx(1)=x0;
dy(1)=y0;

%f1=@(x,y) (x.^2)+(y.^2);
f1=@(x,y) (100*(y-(x.^2)).^2)+(1-x).^2;
%f1=@(x,y) -(cos(x).*cos(y).*exp(-(  ((x-pi).^2) + (y-pi).^2)));

subplot(2,1,1)
mesh(x,y,f1(x,y))
subplot(2,1,2)
[c,h]=contour(x,y,f1(x,y))
title('Metoda ...')
%axis square
clabel(c,h)
hold on
czybyl=0;
iteracje=1;

while(k>dokl)
    [w,p]=min([f1(x0,y0),f1(x0,y0+k),f1(x0+k,y0),f1(x0,y0-k),f1(x0-k,y0),f1(x0+k,y0+k),f1(x0+k,y0-k),f1(x0-k,y0-k),f1(x0-k,y0+k)]);
    iteracje=iteracje+1;
    switch(p)
        case 1
            k=k/2;
            czybyl=czybyl+1;
            dx(iteracje)=x0;
            dy(iteracje)=y0;
            if(czybyl>6)
               break; 
            end
            continue;
        case 2
            y0=y0+k;
            dx(iteracje)=x0;
            dy(iteracje)=y0;
           czybyl=0;
            continue;
        case 3
            x0=x0+k;
            dx(iteracje)=x0;
            dy(iteracje)=y0;
            czybyl=0;
            continue;
        case 4
            y0=y0-k;
            dx(iteracje)=x0;
            dy(iteracje)=y0;
            czybyl=0;
            continue;
        case 5
            x0=x0-k;
            dx(iteracje)=x0;
            dy(iteracje)=y0;
            czybyl=0;
           continue;   
         case 6
            x0=x0+k;
            y0=y0+k;
            dx(iteracje)=x0;
            dy(iteracje)=y0;
            czybyl=0;
           continue;   
          case 7
            x0=x0+k;
            y0=y0-k;
            dx(iteracje)=x0;
            dy(iteracje)=y0;
            czybyl=0;
           continue; 
        case 8
            x0=x0-k;
            y0=y0-k;
            dx(iteracje)=x0;
            dy(iteracje)=y0;
            czybyl=0;
           continue; 
         case 9
            x0=x0-k;
            y0=y0+k;
            dx(iteracje)=x0;
            dy(iteracje)=y0;
            czybyl=0;
           continue; 
    end  
end

plot(dx(1),dy(1),'r*')
text(dx(1),dy(1),'START')
plot(dx(end),dy(end),'r*')
text(dx(end),dy(end),'STOP')

plot(dx(2:end-1),dy(2:end-1),'g.')
plot(dx,dy)

toc

x0
y0
f1(x0,y0)
iteracje-1
%dx
%dy

%-2 3
%