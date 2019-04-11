clc
close
clear

m = 1000;   % proponowane 1000
x0 = ones(m,1);

x1 = rand(m,1);
x2 = rand(m,1);
x1 = x1*2*pi; % przedzial  0 : 2pi
x2 = x2*2-1;  % przedzial -1 : 1
y = ones(m,1);

centra = 50;    % w zakresie 20-100
c = rand(centra,2)*2-1;

sigma = 0.5;


for i=1:m
    if abs(sin(x1(i))) > abs(x2(i))
        y(i)=-1;
        %plot(x1(i),x2(i),'.r');
    else
        y(i)=1;
        %plot(x1(i),x2(i),'.g');

    end
end


x1 = x1/pi -1;  % normalizacja

hold on
for i=1:m
    if y(i)>0
        plot(x1(i),x2(i),'.r');
    else
        plot(x1(i),x2(i),'.g');        
    end
end



plot(c(:,1),c(:,2),'ko','markerfacecolor','k');

z=zeros(centra,m);
for i=1:m

    for j=1:centra
        z(i,j)=exp(((x1(i)-c(j,1))^2+(x2(i)-c(j,2))^2)/(-2*sigma^2));
        
    end

end

z;

D = [x0, z, y];

eta = 1;
[w,k] = simp_perc(D,eta);


gridRes=-1:0.025:1;
[X,Y]=meshgrid(gridRes);


tempCh = zeros(1,m);
Z=zeros(size(X,1),size(X,2));



for i=1:size(X,1)
    for j=1:size(X,2)
        for k=1:centra
            tempCh(k) = exp(((X(i,j)-c (k,1))^2+(Y(i,j)-c (k,2))^2)/(-2*sigma^2));

        end
        if (w*[1,tempCh]'>0)
            Z(i,j)=1;
        else
            Z(i,j)=-1;
        end
    end
end


contour(gridRes,gridRes,Z,'m');
%surf(gridRes,gridRes,Z);










