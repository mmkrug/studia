
X = 1:2:11;
Y = 0.01:0.01:0.06;
%[X,Y] = meshgrid(x,y);

Z =[0.816,  0.668, 0.646,  0.641,  0.641,  0.642;
    0.821,  0.678, 0.663,  0.6625, 0.669,  0.678;
    0.826,  0.69,  0.68,   0.685,  0.696,  0.71;
    0.832,  0.69,  0.695,  0.7075, 0.7225, 0.743;
    0.8375, 0.71,  0.7125, 0.73,   0.75,   0.775;
    0.842,  0.72,  0.7275, 0.75,   0.7775, 0.81];



xx = 1:0.05:11;
yy = 0.01:0.002:0.06;
[XX,YY] = meshgrid(xx,yy);

%xp = reshape(X,1,[]);
%yp = reshape(Y,1,[]);
%zp = reshape(z,1,[]);


subplot(2,2,1)
W = interp2(X,Y,Z,XX,YY,'nearest');
mesh(XX, YY, W)
title('nearest')

subplot(2,2,2)
W = interp2(X,Y,Z,XX,YY,'linear');
mesh(XX, YY, W)
title('linear')

subplot(2,2,3)
W = interp2(X,Y,Z,XX,YY,'spline');
mesh(XX, YY, W)
title('spline')

subplot(2,2,4)
W = interp2(X,Y,Z,XX,YY,'cubic');
mesh(XX, YY, W)
title('cubic')


x1 = 8;
y1 = 0.03;

x2 = 4;
y2 = 0.06;

nearest1 = interp2(X,Y,Z,x1,y1,'nearest')
nearest2 = interp2(X,Y,Z,x2,y2,'nearest')

linear1 = interp2(X,Y,Z,x1,y1,'linear')
linear2 = interp2(X,Y,Z,x2,y2,'linear')

spline1 = interp2(X,Y,Z,x1,y1,'spline')
spline2 = interp2(X,Y,Z,x2,y2,'spline')

cubic1  = interp2(X,Y,Z,x1,y1,'cubic')
cubic2  = interp2(X,Y,Z,x2,y2,'cubic')


blad_neares = sqrt((nearest1 - 0.69)^2 + (nearest2 - 0.69)^2)
blad_linear = sqrt((linear1 - 0.69)^2 + (linear2 - 0.69)^2)
blad_spline = sqrt((spline1 - 0.69)^2 + (spline2 - 0.69)^2)
blad_cubic  = sqrt((cubic1 - 0.69)^2 + (cubic2 - 0.69)^2)





