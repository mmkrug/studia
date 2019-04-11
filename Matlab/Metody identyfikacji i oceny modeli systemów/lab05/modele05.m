clc
close all
clear 

sim('lab5_1')

% s = [5,10,30,100,15000];

A0 = zeros(2);
P0 = 100*eye(2);

fi1=fi1';
fi2=fi2';
fi3=fi3';

x1=[fi1;fi2];
x2=[fi2;fi3];

B = [ 0 ; 0 ];
C = [ 1 0 ; 0 1];
D = [ 0 ; 0];


Ak=zeros(2);
for i = 0:15000
    P0=P0-(P0*x1(:,i+1)*x1(:,i+1)'*P0)/(1+x1(:,i+1)'*P0*x1(:,i+1));
    Ak=Ak+(x2(:,i+1)-Ak*x1(:,i+1))*x1(:,i+1)'*P0;
    
    if(i == 5)
       A5 = Ak; 
    end
    
    if(i == 10)
       A10 = Ak; 
    end
    
    if(i == 30)
       A30 = Ak; 
    end
    
    if(i == 100)
       A100 = Ak; 
    end
    
    if(i == 15000)
       A15000 = Ak; 
    end
       
end


sim('lab5_2')