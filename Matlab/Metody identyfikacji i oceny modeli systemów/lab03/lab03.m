clc
close
clear

%Model 1, na dwóch poziomach

% x=1:4:17;
% y=0.01:0.01:0.05;
% 
% 
% z =[0, 6.25, 8.75, 10.15, 11.15;
%     0, 4.6,  6.25, 7.25,  8;
%     0, 3.8,  5.2,  6,     6.65;
%     0, 3.4,  4.5,  5.25,  2.8;
%     0, 3,    4,    4.75,  5.25;];



%MODEL 1, 2 poziomy
x=[1,    19];
y=[0.01, 0.05];

z=[0, 11.6;
   0, 5.5];


[X,Y] = meshgrid(x,y);

xp = reshape(X,1,[]);
yp = reshape(Y,1,[]);
zp = reshape(z,1,[]);
d  = length(xp);


%MODEL typu Z = c + ax + bx
subplot(2,2,1)

Z  = [ones(1,d);xp;yp];
C = zp * Z' * inv(Z * Z');
F = @(a,b) (C(1) + C(2)*a + C(3)*b);
%Z=F(XX,YY);
plot3(X,Y,z,'.b')
hold on

xx=1:0.5:19;
yy=0.01:0.001:0.06;

[XX,YY]=meshgrid(xx,yy);
W=F(XX,YY);
mesh(XX,YY,W)
title('Model 1, na 2 poziomach')

F_1=[F(3,0.03);
    F(11,0.02);
    F(15,0.04);]

F1_blad = sqrt((F_1(1)-2.6).^2 + (F_1(2)-6.8).^2 + (F_1(3)-5.5).^2)




% MODEL 2, trzy poziomy
subplot(2,2,2)

x=[1,10,19];
y=[0.01,0.03,0.05];
z=[0, 9.1, 11.6;
    0 5.4 6.9;
    0 4.25 5.5];

[X,Y] = meshgrid(x,y);
xp = reshape(X,1,[]);
yp = reshape(Y,1,[]);
zp = reshape(z,1,[]);
d  = length(xp);


Z  = [ones(1,d);xp;yp];
C = zp * Z' * inv(Z * Z');
F = @(a,b) (C(1) + C(2)*a + C(3)*b);
%Z=F(XX,YY);
plot3(X,Y,z,'.b')
hold on

xx=1:0.5:19;
yy=0.01:0.001:0.06;
[XX,YY]=meshgrid(xx,yy);
W=F(XX,YY);
mesh(XX,YY,W)
title('Model 2, na 3 poziomach')

F_2=[F(3,0.03);
	F(11,0.02);
	F(15,0.04)]

F2_blad = sqrt((F_2(1)-2.6).^2 + (F_2(2)-6.8).^2 + (F_2(3)-5.5).^2)






%MODEL 3
x=1:4:17;
y=0.01:0.01:0.05;
z =[0, 6.25, 8.75, 10.15, 11.15;
    0, 4.6,  6.25, 7.25,  8;
    0, 3.8,  5.2,  6,     6.65;
    0, 3.4,  4.5,  5.25,  2.8;
    0, 3,    4,    4.75,  5.25];
subplot(2,2,3)


[X,Y] = meshgrid(x,y);

xp = reshape(X,1,[]);
yp = reshape(Y,1,[]);
zp = reshape(z,1,[]);
d  = length(xp);

Z  = [ones(1,d);xp;yp];
C = zp * Z' * inv(Z * Z');
F = @(a,b) (C(1) + C(2)*a + C(3)*b);
%Z=F(XX,YY);
plot3(X,Y,z,'.b')
hold on

xx=1:0.5:19;
yy=0.01:0.001:0.06;

[XX,YY]=meshgrid(xx,yy);
W=F(XX,YY);
mesh(XX,YY,W)
title('Model 3.')

F_3=[F(3,0.03);
    F(11,0.02);
    F(15,0.04);]

F3_blad = sqrt((F_3(1)-2.6).^2 + (F_3(2)-6.8).^2 + (F_3(3)-5.5).^2)





% 
% 
% 
% xx = 1:0.5:11;
% yy = 0.01:0.002:0.06;
% [XX,YY] = meshgrid(xx,yy);
% 
% W = F(XX,YY);
% mesh(XX,YY,W)
% title('Model 6')
% m6 = [F(8,0.03);
%       F(4,0.06);
%       F(6,0.05)]
%   
% m6_blad = sqrt((0.69-F(8,0.03))^2 + (0.69-F(4,0.06))^2 + (0.69-F(6,0.05))^2)
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% xx = 1:0.05:11;
% yy = 0.01:0.002:0.06;
% [XX,YY] = meshgrid(xx,yy);
% 
% %xp = reshape(X,1,[]);
% %yp = reshape(Y,1,[]);
% %zp = reshape(z,1,[]);
% 
% 
% subplot(2,2,1)
% W = interp2(X,Y,Z,XX,YY,'nearest');
% mesh(XX, YY, W)
% title('nearest')
% 
% subplot(2,2,2)
% W = interp2(X,Y,Z,XX,YY,'linear');
% mesh(XX, YY, W)
% title('linear')
% 
% subplot(2,2,3)
% W = interp2(X,Y,Z,XX,YY,'spline');
% mesh(XX, YY, W)
% title('spline')
% 
% subplot(2,2,4)
% W = interp2(X,Y,Z,XX,YY,'cubic');
% mesh(XX, YY, W)
% title('cubic')
% 
% 
% x1 = 8;
% y1 = 0.03;
% 
% x2 = 4;
% y2 = 0.06;
% 
% nearest1 = interp2(X,Y,Z,x1,y1,'nearest')
% nearest2 = interp2(X,Y,Z,x2,y2,'nearest')
% 
% linear1 = interp2(X,Y,Z,x1,y1,'linear')
% linear2 = interp2(X,Y,Z,x2,y2,'linear')
% 
% spline1 = interp2(X,Y,Z,x1,y1,'spline')
% spline2 = interp2(X,Y,Z,x2,y2,'spline')
% 
% cubic1  = interp2(X,Y,Z,x1,y1,'cubic')
% cubic2  = interp2(X,Y,Z,x2,y2,'cubic')
% 
% 
% blad_neares = sqrt((nearest1 - 0.69)^2 + (nearest2 - 0.69)^2)
% blad_linear = sqrt((linear1 - 0.69)^2 + (linear2 - 0.69)^2)
% blad_spline = sqrt((spline1 - 0.69)^2 + (spline2 - 0.69)^2)
% blad_cubic  = sqrt((cubic1 - 0.69)^2 + (cubic2 - 0.69)^2)
% 
% 



