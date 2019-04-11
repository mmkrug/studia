clc 
close all
clear


sim('lab4')

fi1=fi1';
fi2=fi2';
fi3=fi3';

x1=[fi1;fi2];
x2=[fi2;fi3];

Rs=x2*x1';
Ps=x1*x1';


A=Rs*(Ps^(-1));
B=[ 0; 0];
C=[ 1 0 ; 0 1 ];
D=[ 0 ; 0 ];


