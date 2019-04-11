clc
clear
close

tic
[x,y]=meshgrid([-5:0.1:5],[-5:0.1:5]);
%[x,y]=meshgrid([-2:0.1:2],[-1:0.1:3]);
%[x,y]=meshgrid([-20:0.1:20],[-20:0.1:20]);
x0 = 4;
y0 = 4;
k = 1;
lambda = k;
h=0.000001;
dokl = 0.001;
dx(1) = x0;
dy(1) = y0;

f1=@(x,y) (x.^2)+(y.^2);
%f1=@(x,y) (100*(y-(x.^2)).^2)+(1-x).^2;
%f1=@(x,y) -(cos(x).*cos(y).*exp(-(  ((x-pi).^2) + (y-pi).^2)));
z1 = (f1(x0+h, y0) - f1(x0-h, y0)) / (2*h);
z2 = (f1(x0, y0+h) - f1(x0, y0-h)) / (2*h);



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


while 1
grad = [z1, z2];
if norm(grad)<dokl
    break
end

alfa = lambda / norm(grad);
x0 = x0 - alfa*grad(1);
y0 = y0 - alfa*grad(2);

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