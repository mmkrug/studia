%#ok<*SAGROW>
%#ok<*NOPTS>
clc
clear
%próbki
I=1000;
x1=rand(I,1)*2-1;
x2=rand(I,1)*2-1;
y(I,1)=0; %rezerwacja pamiêci
for i=1:I
    if(abs(sin((x1(i)+1)*pi))>abs(x2(i)))
        y(i)=-1;
    else
        y(i)=1;
    end
end
%plotpv([x1;x2],(y+1)==2)


%cechy
M=80;
c1=rand(M,1)*2-1;
c2=rand(M,1)*2-1;
% M=4;
% c1=[-0.5,0.5,-0.5,0.5];
% c2=[-0.4,-0.4,0.4,0.4];
ro=0.36;

%wartoœci cech dla próbek
z(I,M)=0; %rezerwacja pamiêci
for i=1:I
    for m=1:M
        z(i,m)=exp(((x1(i)-c1(m))^2+(x2(i)-c2(m))^2)/(-2*ro^2));
    end
end

%dane
D=[ones(I,1),z(:,:),y(:,1)]

%magic
W=zeros(1,M+1);
k=0;
iter=0;
eta=0.1; %wspó³czynnik uczenia
while(1)
    iter=iter+1;
    A=[];
    for i=1:I
        x=D(i,1:M+1);
        s=W*x';
        t=-1;
        if s>0
            t=1;
        end
        if ~(t==D(i,M+2))
            A=[A;D(i,:)];
        end
    end
    [rows,col]=size(A);
    if(mod(iter,100)==0)
        disp(['iteracja ', num2str(iter),',size(A) = ',num2str(rows)]);
    end
    if rows==0
        break;
    end
    index=1+floor(rand()*rows);
    x=A(index,1:M+1);
    yy=A(index,M+2);
    W=W+eta*yy*x;
    k=k+1;
    if(iter>1500)
        break
    end
end
[W,k] = simp_perc(D,eta)


W
iter
gridRes=-1:0.025:1;
[X,Y]=meshgrid(gridRes);
Z(size(X,1),size(X,2))=0; %rezerwacja pamiêci
Z2(size(X,1),size(X,2))=0;
for i=1:size(X,1)
    for j=1:size(X,2)
        for m=1:M
            tempCh(m) = exp(((X(i,j)-c1(m))^2+(Y(i,j)-c2(m))^2)/(-2*ro^2));
        end
        Z2(i,j)= sum(W.*[1,tempCh]);
        if (sum(W.*[1,tempCh])>0)
            Z(i,j)=1;
        else
            Z(i,j)=-1;
        end
    end
end
surf(gridRes,gridRes,Z2);
figure
hold on
contour(gridRes,gridRes,Z,1,'linewidth',2);
scatter(x1,x2,3,y)
for m=1:M
    plot(c1(m),c2(m),'.k','MarkerSize',15);
end