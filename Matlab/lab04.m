clc
close
clear

tic

A=[2 1;
   3 3;
   2 0;
   1 0;
   0 1]
B=[10;24;8;0;0]
Z=[-1;-1;-1;1;1]
F=[300,200]
ogr = length(Z);


k=1;
roz=0;

for i=1:ogr-1
    AT(1,:) = A(i,:)
    BT(1,:) = B(i,:)
    
    for j=i+1:ogr
        AT(2,:) = A(j,:)
        BT(2,:) = B(j,:)
        R= AT\BT
    
        if (sum(isinf(R))==0 & sum(isinf(R))==0)
            T(:,k) = R
            k = k + 1
        end
    
    end
end

p = 1;
for i=1:k-1
    f=0;

    for j=1:ogr
        if (Z(j) == -1)
            if ((A(j,:)*T(:,i))<=B(j))
                f=f+1;
            end
        end
        
        if (Z(j) == 1)
            if (A(j,:)*T(:,i) >= B(j))
                f=f+1;
            end
        end
        
        if (Z(j) == 0)
            if ((A(j,:)*T(:,i)) == B(j))
                f=f+1;
            end
        end
        
    end
    
    
    if f == ogr
            ntab(:,p) = T(:,i)
            p=p+1;
     end
end

%fill( , ,'r')

hold on
for i=1:ogr+1
    X = min(T(1,:))-1 : 0.1 : max(T(1,:))+1;
    Y = (B(i) - A(i,1)*X)/A(i,2);
    plot(X,Y)
end
hold off


convhull(X,Y)
fill(X,Y,'b')
            
ntab

%TRZEBA DOKONCZYC NA NASTEPNE ZAJECIA
%ogarniecie metody tabelkowej LUL


toc


















