clc
clear
I=1000; %wielkoœæ zbioru ucz¹cego
blad=0.01;
x=rand(I,2)*pi;
yg=cos(x(:,1).*x(:,2)).*cos(2*x(:,1))+rand(I,1)*blad; %obliczenie próbek wraz z bledem



hold on
scatter3(x(:,1),x(:,2),yg,3);

figure;
[X,Y]=meshgrid(0:0.1:pi,0:0.1:pi);
Z=cos(X.*Y).*cos(2*X);
subplot(1,2,1);
surf(X,Y,Z);

%sieæ
il_neuronow = 70; %iloœæ neuronów

li_epok = 1000; %iloœæ epok uczenia
eta = 0.002; %wsp. prêdkoœci uczenia

popprzednia_poprawkaV=0;
popprzednia_poprawkaW=0;



%losowanie wag
V= (10^-6).*rand(il_neuronow,3);%1-bias 2-3 wejœcia
W= (10^-6).*rand(il_neuronow+1,1);% wyjscie

for nr_epoki=1:li_epok
    networkError = 0;
    
    for i=1:I 
        z1=V(:,1)+V(:,2)*x(i,1)+V(:,3)*x(i,2); %odpowiedz pierwszej warstwy
        z=(1./(1+exp(-z1))); %po funkcji aktywacji
        y=sum(W(2:size(W)).*z)+W(1); %odpowiedz neuronu drugiej warstwy
        
        pochodna_z = z.*(1-z);
        blad = y-yg(i); %blad

       poprawkaW = blad * [1;z]; 
       poprawkaW = eta*poprawkaW;%korekta wag W
       poprawkaW=(-poprawkaW+0.9*popprzednia_poprawkaW);
           
        pochodna_bledu_V = blad.*z.*pochodna_z.*W(2:size(W)); %jw. ale po V
        pochodna2_bledu_V = [pochodna_bledu_V,pochodna_bledu_V*x(i,1),pochodna_bledu_V*x(i,2)]; 
        poprawkaV = eta*pochodna2_bledu_V; %korekta wag V
        poprawkaV=(-poprawkaV+0.9*popprzednia_poprawkaV);
   

         V = V + poprawkaV;%+0.9*popprzednia_poprawkaV; %nowe wagi V

        
        W = W + poprawkaW;% +0.9*popprzednia_poprawkaW; %nowe wagi W
popprzednia_poprawkaV = poprawkaV; %zachowanie korekty dla "pêdu"
popprzednia_poprawkaW = poprawkaW; %zachowanie korekty dla "pêdu"        
    end
    
    if(mod(nr_epoki,10)==0)
        fprintf('Przetwarzanie: Wykonano %g%% ( Epoka: %d/%d )\n',round(100*(nr_epoki-1)/li_epok),nr_epoki,li_epok);
    end
    
end

[X,Y]=meshgrid(0:0.1:pi,0:0.1:pi);

Z(size(X,1),size(X,2))=0;
for i=1:size(X,1)
    for j=1:size(X,2)
        sk=V(:,1)+V(:,2)*X(i,j)+V(:,3)*Y(i,j);
        pochodna_sk=(1./(1+exp(-sk)));
        Z(i,j)=W(1)+sum(W(2:size(W)).*pochodna_sk);
    end
end
subplot(1,2,2);
surf(X,Y,Z);
%axis([0,4,0,4,-1,1,-50,50]);
%caxis auto;



