clear
clc
clf
x=[-0.435];
y=[0];
a=plot(x,y,'marker','o');
a.Color='g';
hold on
X=[-2 -1.23 -0.113 -0.113];
Y=[0 0 0.064 -0.064];
x_length=length(X);
for s=1:x_length
    x1=X(s);
    y1=Y(s);
    b=plot(x1,y1,'marker','*');
    b.Color='r';
end
title('zeros and poles from U(s) to theta(s)');