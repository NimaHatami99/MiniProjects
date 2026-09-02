clear
clc
syms s
M=[s -1 0 0;0 s -1 0;0 0 s -1;0.042 0.611 3.207 (s+3.456)];
C=[1 0 0 0];
B=[0;0;0.25;-0.755];
phi=inv(M);
disp('The transfer function of system:');
T=C*phi*B
num=[0.25 0.109];
den=[1 3.456 3.207 0.611 0.042];
disp('The state space matrixes:');
ss(tf(num,den))