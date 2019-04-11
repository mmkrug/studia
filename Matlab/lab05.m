clc
close
clear
 
A=[2,1,1,0,0;3,3,0,1,0;2,0,0,0,1];
B=[10;24;8];
Z=[-1;-1;-1];
F=[300,200,0,0,0];
WB=[3,4,5];
CB=[F(WB(1)),F(WB(2)),F(WB(3))]
 
FC=CB*B;
 
for i=1:size(A,2)
    ww(i)=CB*A(:,i)-F(i);    
end
 
[w, KK]=min(ww);
while 1
if( w>=0 )
    disp('koniec')
    FC
    %wartosci zmiennych
    break;
else
    disp('Kolejna tab')
    %szukanie wiersza kluczowego WK
    for i=1:size(A,1)
        if A(i,KK) >0
            t(i)=B(i)./A(i,KK);   %daje zera cza zmienic jesli ominie
        else 
            t(i)=Inf;
        end
    end
    [w,WK]=min(t);
    WB(WK)=KK;
    CB=[F(WB(1)),F(WB(2)),F(WB(3))];
    ER=A(WK,KK);
    B(WK)=B(WK)/ER;
    A(WK,:)=A(WK,:)./ER;
    
    for i=1:size(A,1)
        if (WK~=i)
            B(i)=B(i)-A(i,KK)*B(WK); %cos uzupelnic
            A(i,:)=A(i,:)- A(i,KK)*A(WK,:) 
        end
    end
   
    FC=CB*B;
 
    for i=1:size(A,2)
         ww(i)=CB*A(:,i)-F(i);    
    end
    
    [w, KK]=min(ww);
end
end

wynik=zeros(1,size(A,2));
 
for i=1:size(B)
    wynik(WB(i))=B(i);
end
 
 
 wynik
 
 