clear
clc
clf
kc=22.754;
k=0.5*kc;
for m=1:3
    KGH=tf([0.25*k 0.109*k],[1 3.456 3.207 0.611 0.042]);
    nichols(KGH)
    ngrid
    X=sprintf('in figure%d k=%f .',m,k);
    disp(X);
    if m<3
        figure()
    end
    k=k*2;
end