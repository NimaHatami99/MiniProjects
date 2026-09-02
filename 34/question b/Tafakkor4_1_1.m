clear
clc
clf
g(1)=36;
g(2)=120;
g(3)=0.3;
E(1)=-12;
E(2)=115;
E(3)=10.613;
I_ext=0;
V=-10;
x=zeros(1,3);
x(3)=1;
t_rec=0;
t_final=150;
I_on1=2.35;
T1=10;
Tw1=5;
dt=0.001;
for t=-30:dt:t_final
    if t==T1
        I_ext=I_on1;
    end
    if t==T1+Tw1
        I_ext=0;
    end
    alpha(1)=(10-V)/(100*(exp((10-V)/10)-1));
    alpha(2)=(25-V)/(10*(exp((25-V)/10)-1));
    alpha(3)=0.07*exp(-V/20);
    beta(1)=0.125*exp(-V/80);
    beta(2)=4*exp(-V/18);
    beta(3)=1/(exp((30-V)/10)+1);
    tau=1./(alpha+beta);
    x_0=alpha.*tau;
    x=(1-dt./tau).*x+x_0.*dt./tau;
    gnmh(1)=g(1)*x(1)^4;
    gnmh(2)=g(2)*x(2)^3*x(3);
    gnmh(3)=g(3);
    I=gnmh.*(V-E);
    V=V+dt*(I_ext-sum(I));
    if t>=0
        t_rec=t_rec+1;
        x_plot(t_rec)=t;
        y_plot(t_rec)=V;
        G(1,t_rec)=gnmh(1);
        G(2,t_rec)=gnmh(2);
        n(t_rec)=x(1);
        m(t_rec)=x(2);
        h(t_rec)=x(3);
    end
end
plot(x_plot,y_plot);
title('vm=Vm-Vrest');
xlabel('time (ms)');
ylabel('relative membrane voltage (mv)');
figure();
plot(x_plot,G);
xlabel('time (ms)');
ylabel('conductance (mS/cm^2)');
legend('gK','gNa');
figure();
z=plot(x_plot,n,x_plot,m,x_plot,h);
z(1).Color='r';
z(2).Color='g';
z(3).Color='y';
xlabel('time (ms)');
ylabel('n,m,h(t)');
legend('n(t)','m(t)','h(t)');