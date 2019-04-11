Z = [0.818 0.669 0.648 0.641 0.641 0.644;
    0.821 0.679 0.662  0.662 0.67 0.678;
    0.828 0.69 0.68 0.685 0.697 0.71;
    0.831 0.699 0.698 0.708 0.723 0.743;
    0.838 0.715 0.712 0.729 0.75 0.776;
    0.842 0.72 0.729 0.75 0.779 0.812];

X = 1:2:11;
Y = 0.01:0.01:0.06;

xx = 1:0.1:11;
yy = 0.01:0.005:0.06;

[XX,YY] = meshgrid(xx,yy);

subplot(2,2,1)
W = interp2(X,Y,Z,XX,YY,'nearest')
mesh(XX, YY, W)
title('nearest')

subplot(2,2,2)
W = interp2(X,Y,Z,XX,YY,'linear')
mesh(XX, YY, W)
title('linear')

subplot(2,2,3)
W = interp2(X,Y,Z,XX,YY,'spline')
mesh(XX, YY, W)
title('spline')

subplot(2,2,4)
W = interp2(X,Y,Z,XX,YY,'cubic')
mesh(XX, YY, W)
title('cubic')

x1 = 8;
y1 = 0.03;
x2 = 4;
y2 = 0.06;

% zadanie 3 porownania modeli w punktach
nearest_1 = interp2(X,Y,Z,x1,y1,'nearest')
nearest_2 = interp2(X,Y,Z,x2,y2,'nearest')

linear_1 = interp2(X,Y,Z,x1,y1,'linear')
linear_2 = interp2(X,Y,Z,x2,y2,'linear')

spline_1 = interp2(X,Y,Z,x1,y1,'spline')
spline_2 = interp2(X,Y,Z,x2,y2,'spline')

cubic_1 = interp2(X,Y,Z,x1,y1,'cubic')
cubic_2 = interp2(X,Y,Z,x2,y2,'cubic')

% zadanie 4 b³¹d œredniokwadratowy

nearest_blad = sqrt((nearest_1-0.69).^2 + (nearest_2-0.721).^2)
linear_blad = sqrt((linear_1-0.69).^2 + (linear_2-0.721).^2)
spline_blad = sqrt((spline_1-0.69).^2 + (spline_2-0.721).^2)
cubic_blad = sqrt((cubic_1-0.69).^2 + (cubic_2-0.721).^2)