clc
close all
clear all

sim('lab04_zad1')
m = str2num(get_param('lab04_zad1/Subsystem','m'))
l = str2num(get_param('lab04_zad1/Subsystem','l'))
k = str2num(get_param('lab04_zad1/Subsystem','k'))

l_max = l + max(r);



for i=1:length(fi)
    l2 = l+r(i);
    xa = 0; ya = 0; xb = -l2*sin(fi(i)); yb = -l2*cos(fi(i)); ne = 10; a = 1; ro = 0.2;
    [xs,ys] = spring(xa,ya,xb,yb,ne,a,ro);
    
    plot(xs,ys,'LineWidth',2)
   % plot([0 -l2*sin(fi(i))],[0 -l2*cos(fi(i))],'Color','r','LineWidth',2);
    hold on
    plot(-l2*sin(fi(i)), -l2*cos(fi(i)), 'b.','MarkerSize',5*m);
    hold off
    axis([-1.1*l_max 1.1*l_max -1.1*l_max 1.1*l_max])
    daspect([1,1,1])
    pause(0.01)
end