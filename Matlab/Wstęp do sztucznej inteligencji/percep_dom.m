clc
close
clear

m = 10000;
x0 = ones(m,1);
x1 = rand(m,1);
%x2 = [rand(m/2,1)*0.4 + 0.6; rand(m/2,1)*0.4];
%y = [ones(m/2,1); -ones(m/2,1)];
x2 = [rand(m/2,1)*0.49 + 0.51; rand(m/2,1)*0.49];
y = [ones(m/2,1); -ones(m/2,1)];


D = [x0,x1,x2,y]

scatter(D(1:m/2,2),D(1:m/2,3), '.g');

hold on;

scatter(D(m/2+1:end,2),D(m/2+1:end,3), '.r');

%wywolanie funkcji
eta = 1;
[w,k] = simp_perc(D,eta)

%   w0 + w1*x1 + w2*x2 = 0
%   x2 = -(w0 + w1*x1)/w2
%   w matlabie jest indeksowane od 1

x1 = [0,1];
x2 = -(w(1) + w(2)*x1)/w(3);

%   znajduje w ogolnosci plaszczyzne

plot(x1,x2)

%   czy m ma wplyw
%   czy wsp. uczenia ma wplyw na liczbe krokow?
%   zsunac prostakaty. normalnie przerwa jest 0.2
%   
%   im mniej miejsca, tym bardziej wielkosc m ma znaczenie, troche

%   zadanie domowe.
%   podnoszenie wymiarowosci
%   D    ->  D'
%   R^2  ->  IR^100