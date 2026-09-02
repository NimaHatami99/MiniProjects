clear
clc
clf
t=0:0.001:100;
theta=-2.719.*((2.718281).^(-0.113.*t)).*(cos(0.064.*t)-1.391.*sin(0.064.*t))+0.168.*((2.718281).^(-1.23.*t))-0.071.*((2.718281).^(-2.*t))+2.616;
plot(t,theta);
grid on
xlabel('------->t');
ylabel('------->theta(t)');
title('time response of system to a unit step');