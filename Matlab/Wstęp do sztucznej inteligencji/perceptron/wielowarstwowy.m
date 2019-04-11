clc
clear
I=100; %wielkoœæ zbioru ucz¹cego
x1=rand(I,1)*pi;
x2=rand(I,1)*pi;
yg(I,1)=0;
%for i=1:I
%    yg(i)=cos(x1(i)*x2(i))*cos(2*x1(i));
%end
 yg=cos(x1.*x2).*cos(2*x1); %obliczenie próbek

% scatter3(x1,x2,yg,3);
surfRes=0:0.05:pi;

figure;
[X,Y]=meshgrid(surfRes,surfRes);
Z(size(X,1),size(X,2))=0;
for i=1:size(X,1)
    for j=1:size(X,2)
        Z(i,j)=cos(X(i,j)*Y(i,j))*cos(2*X(i,j));
    end
end
surf(X,Y,Z);

%sieæ
nrOfNs = 70; %iloœæ neuronów
nrOfVs = 2; %iloœæ zmiennych
nrOfEpochs = 1000; %iloœæ epok uczenia
eta = 0.002; %wsp. prêdkoœci uczenia
momentum = 0.9; %wsp. pêdu
corrWold=0;
corrVold=0;

%losowanie wag V i W
a=-10^-6;
b=10^-6;
V= a + (b-a).*rand(nrOfNs,nrOfVs+1);
W=a+(b-a).*rand(nrOfNs+1,1);

for epoch=1:nrOfEpochs
    networkError = 0;
    for i=1:I %numer próbki
        
        sk=V(:,1)+V(:,2)*x1(i)+V(:,3)*x2(i); %odpowiedz pierwszej warstwy
        fi_sk=(1./(1+exp(-sk))); %po funkcji aktywacji
        y=W(1)+sum(W(2:size(W)).*fi_sk); %odpowiedz neuronu drugiej warstwy
        
        dfi_sk = fi_sk.*(1-fi_sk);
        error = y-yg(i); %blad
        err = 1/2 * error^2; %blad kwadratowy
        networkError=networkError + err;
        
        dErrdW = error * [1;fi_sk]; %pochodna bledu kwadratowego po W
        corrW = eta*dErrdW; %korekta wag W
        corrW = (-corrW + momentum*corrWold);
        
        dErrdV = error.*fi_sk.*dfi_sk.*W(2:size(W)); %jw. ale po V
        dErrdV = [dErrdV,dErrdV*x1(i),dErrdV*x2(i)]; %wiersz - neuron, kolumna - zmienna
        corrV = eta*dErrdV; %korekta wag V
        corrV = (-corrV +momentum*corrVold);
        V = V + corrV; %nowe wagi W
        corrVold = corrV; %zachowanie korekty dla "pêdu"
        
        W = W + corrW; %nowe wagi W
        corrWold = corrW; %zachowanie korekty dla "pêdu"
    end
    if(mod(epoch,100)==0)
        disp(['Epoka ',num2str(epoch)]);
        disp(['Error ',num2str(networkError)]);
    end
end

figure;
[Xn,Yn]=meshgrid(surfRes,surfRes);
Zn(size(Xn,1),size(Xn,2))=0;
for i=1:size(Xn,1)
    for j=1:size(Xn,2)
        sk=V(:,1)+V(:,2)*Xn(i,j)+V(:,3)*Yn(i,j);
        fi_sk=(1./(1+exp(-sk)));
        Zn(i,j)=W(1)+sum(W(2:size(W)).*fi_sk);
    end
end
surf(Xn,Yn,Zn);
axis([0,4,0,4,-1,1,-50,50]);
caxis auto;
% funkcja aktywacji fi(sk) = 1/(1+exp(-sk))
% pochodna fi(sk) po sk = fi(sk)*(1-fi(sk))
% X_j = zmienna wejœciowa sieci
% sk = wyjscie pojedynczego k-tego neuronu
% Vkj = waga j-tego wejœcia do k-tego neuronu
% Wk = waga k-tego neuronu
% sk = Vk0 + suma(Vkj * Xj)
% y = W0 + suma(Wk * fi(sk))
% err = 1/2 * error^2 ; error = y - y* ; * - ze wzoru, poprawne
% Wnowa = Wstara - eta*(pochodna err/d Wstara)
% d err / d Wk = (y - y*)*fi_k(s_k)
% d err / d Vkj = (y - y*)*W_k*fi_k(s_k)*(1-fi_k(s_k))*X_j
% wylosowaæ wagi oko³o 0.001
% b³¹d ca³ej sieci - suma b³êdów w punktach