clc
close all
clear all

sim('miss_lab6')
m1 = str2num(get_param('miss_lab6/Subsystem', 'm1'));
m2 = str2num(get_param('miss_lab6/Subsystem', 'm2'));
l1 = str2num(get_param('miss_lab6/Subsystem', 'l1'));
l2 = str2num(get_param('miss_lab6/Subsystem', 'l2'));
for i = 1:length(fi10)
     plot(0-l1*sin(fi10(i)), 0-l1*cos(fi10(i)), 'r.','MarkerSize',20*m1)
     hold on
     line([0 0-l1*sin(fi10(i))],[0 0-l1*cos(fi10(i))],'Color','r','LineWidth',1)
     hold on
     plot(-l1*sin(fi10(i))-l2*sin(fi20(i)), -l1*cos(fi10(i))-l2*cos(fi20(i)), 'b.','MarkerSize',20*m2)
     hold on
     line([-l1*sin(fi10(i)) -l1*sin(fi10(i))-l2*sin(fi20(i))],[-l1*cos(fi10(i)) -l1*cos(fi10(i))-l2*cos(fi20(i))],'Color','b','LineWidth',1)
     hold off
    axis([-2.5 2.5 -3.5 5])
    daspect([1,1,1])
    pause(0.01)
end