x = 1:2:11;
y = 0.01:0.01:0.06;

z =[0.816,  0.668, 0.646,  0.641,  0.641,  0.642;
    0.821,  0.678, 0.663,  0.6625, 0.669,  0.678;
    0.826,  0.69,  0.68,   0.685,  0.696,  0.71;
    0.832,  0.69,  0.695,  0.7075, 0.7225, 0.743;
    0.8375, 0.71,  0.7125, 0.73,   0.75,   0.775;
    0.842,  0.72,  0.7275, 0.75,   0.7775, 0.81];



[X,Y] = meshgrid(x,y);

xp = reshape(X,1,[]);
yp = reshape(Y,1,[]);
zp = reshape(z,1,[]);
d  = length(xp);


%MODEL 6
subplot(2,2,1)

Z  = [xp.^2;yp.^2;xp.*yp;ones(1,d)];
C = zp * Z' * inv(Z * Z');
F = @(a,b) (C(1).*a.^2+ C(2)*b.^2 + C(3).*a.*b + C(4));
plot3(X,Y,z,'.b')

hold on
xx = 1:0.5:11;
yy = 0.01:0.002:0.06;
[XX,YY] = meshgrid(xx,yy);

W = F(XX,YY);
mesh(XX,YY,W)
title('Model 6')
m6 = [F(8,0.03);
      F(4,0.06);
      F(6,0.05)]
  
m6_blad = sqrt((0.69-F(8,0.03))^2 + (0.69-F(4,0.06))^2 + (0.69-F(6,0.05))^2)

%MODEL 13
subplot(2,2,2)

Z  = [xp.^3;xp.^2;yp.^3;yp.^2;xp.*yp;ones(1,d)];
C = zp * Z' * inv(Z * Z');
F = @(a,b) (C(1).*a.^3+ C(2)*a.^2 + C(3).*b.^3 + C(4).*b.^2 + C(5).*a.*b + C(6));
plot3(X,Y,z,'.b')

hold on
xx = 1:0.5:11;
yy = 0.01:0.002:0.06;
[XX,YY] = meshgrid(xx,yy);

W = F(XX,YY);
mesh(XX,YY,W)
title('Model 13')
m13 = [F(8,0.03);
        F(4,0.06)
        F(6,0.05)]

m13_blad = sqrt((0.69-F(8,0.03))^2 + (0.69-F(4,0.06))^2 + (0.69-F(6,0.05))^2)

%MODEL 4
subplot(2,2,3)

Z  = [xp;yp.^2;yp;ones(1,d)];
C = zp * Z' * inv(Z * Z');
F = @(a,b) (C(1).*a + C(2)*b.^2 + C(3).*b + C(4));
plot3(X,Y,z,'.b')

hold on
xx = 1:0.5:11;
yy = 0.01:0.002:0.06;
[XX,YY] = meshgrid(xx,yy);

W = F(XX,YY);
mesh(XX,YY,W)
title('Model 4')
m4 = [F(8,0.03);
        F(4,0.06);
        F(6,0.05)]

m4_blad = sqrt((0.69-F(8,0.03))^2 + (0.69-F(4,0.06))^2 + (0.69-F(6,0.05))^2)


%MODEL 12
subplot(2,2,4)

Z  = [xp.^3;xp.^2;yp.^3;yp.^2;ones(1,d)];
C = zp * Z' * inv(Z * Z');
F = @(a,b) (C(1).*a.^3 + C(2)*a.^2 + C(3).*b.^3 + C(4).*b.^2 + C(5));
plot3(X,Y,z,'.b')

hold on
xx = 1:0.5:11;
yy = 0.01:0.002:0.06;
[XX,YY] = meshgrid(xx,yy);

W = F(XX,YY);
mesh(XX,YY,W)
title('Model 12')
m12 = [F(8,0.03);
        F(4,0.06);
        F(6,0.05)]
m12_blad = sqrt((0.69-F(8,0.03))^2 + (0.69-F(4,0.06))^2 + (0.69-F(6,0.05))^2)




