clear
clc
clf
T=[19,16,15,13,12,10,8,7,6,5];
I=[2.5,3,3.5,4.5,6,10,15,20,40,100];
a=plot(T,I);
xlabel('T (ms)');
ylabel('I (mA/cm^2)');
title('I-T characteristic');