N=200 %liczba punktów
x= rand(N,2);
x(:,1)=x(:,1)*2*pi;
x(:,2)=x(:,2)*2-1;
y=zeros(N,1)
for i=1:length(x)
if abs(sin(x(i,1)))>abs(x(i,2))
    y(i)=-1;
else
    y(i)=1;
end
end

hold on
for i=1:length(x)
    if y(i)>0
plot(x(i,1),x(i,2),'ro');
    else
plot(x(i,1),x(i,2),'go');        
    end
end

%niepotrzebne
%x(:,1)=2*abs((x(:,1)-min(x(:,1)))/(max(x(:,1))-min(x(:,1))))-1;
%x(:,2)=2*abs((x(:,2)-min(x(:,2)))/(max(x(:,2))-min(x(:,2))))-1;

x(:,1)=x(:,1)/pi-1;


%losowanie centrów
m=30;
c= 2*rand(m,2)-1;
%wsp=01.10;
wsp=0.5;
%liczenie cech
z=ones(N,m);
for i=1:N
    for j=1:m
        sum=0;
        for k=1:2
           sum=sum+ (x(i,k)-c(j,k))^2;
        end
       z(i,j)=exp( -1*sum/(2*wsp^2));  
    end
end
clc

M=[ones(1,N)' z y];
size(z)
size(M)


hold on
% M=zeros(100,4);
% I=1000;
% for i=1:I
% M(i,:)=[1 rand() 0.8*rand() 0];
% if M(i,3)>0.4
% M(i,3)=M(i,3)+0.2;
% end
% if M(i,3)>0.5
% M(i,4)=1;
% plot(M(i,2),M(i,3),'r+')
% else
% M(i,4)=-1;
% plot(M(i,2),M(i,3),'go')
% end
% end
I=N;
W=zeros(size(M(1,1:end-1)));
k=0;
eta=0.001;
licz=0;
while 1 && licz<1000
    licz =licz+1;
A=[];
for i=1:I
x=M(i,1:end-1);
s=W*x';
f=-1;
if s>0
f=1;
end
if ~(f==M(i,m))
A=[A, M(i,:)];
end
end
[rows, cols]=size(A);
if rows==0
break
end
index=1+floor(rand()*rows);
x=A(index, 1:m+1);
y=A(index,end);
W=W+eta*y*x;
k=k+1;
end
W
x1=0:0.005:1;
x2=(-W(1)-W(2)*x1)/W(3);
for i=2:m+1
    
end


siatka=-1:0.1:1;
[X,Y]=meshgrid(siatka);
Z=zeros(size(X,1),size(X,2)); %rezerwacja pamiêci
for i=1:size(X,1)
    for j=1:size(X,2)
        tmp=W(1);
        for k=2:m
            tmp =  tmp+W(k)*exp(((X(i,j)-c(k,1))^2+(Y(i,j)-c(k,2))^2)/(-2*wsp^2));
        end
        Z(i,j)=tmp;
        if (tmp>0)

            Z(i,j)=1;
        else
            Z(i,j)=-1;
        end
    end
end
Z
figure
hold on

contour(siatka,siatka,Z);
%scatter(x(:,1),x(:,2),3,y)
for i=1:m
    plot(c(i,1),c(i,2),'ko');
end


