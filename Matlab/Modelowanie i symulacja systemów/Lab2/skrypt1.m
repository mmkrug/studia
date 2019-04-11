clc
close all
clear all

sim('wahadlo3')
m = str2num(get_param('wahadlo3/Subsystem','m'))
l = str2num(get_param('wahadlo3/Subsystem','l'))

for i=1:length(fi)
    plot([0 -l*sin(fi(i))],[0 -l*cos(fi(i))],'Color','r','LineWidth',2);
    hold on
    plot(-l*sin(fi(i)), -l*cos(fi(i)), 'b.','MarkerSize',5*m);
    hold off
    axis([-1.1*l 1.1*l -1.1*l 1.1*l])
    daspect([1,1,1])
    pause(0.01)
end