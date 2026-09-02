clear
clc
clf
GH=tf([0.008 -0.059 0.223 0.109],[0.031 0.357 1.963 4.277 3.361 0.622 0.042]);
margin(GH)
[Gm,Pm,Wcg,Wcp]=margin(GH)
grid on
disp('Gm is linear gain margin and GM is gain margin in dB.');
GM=20*log10(Gm)
figure()
kc=8.9325;
k=0.5*kc;
for m=1:3
    KGH=tf([0.008*k -0.059*k 0.223*k 0.109*k],[0.031 0.357 1.963 4.277 3.361 0.622 0.042]);
    nyquist(KGH)
    figure()
    X=sprintf('in figure%d k=%f .',m+1,k);
    disp(X);
    k=k*2;
end
k=0.5*kc;
for m=1:3
    KGH=tf([0.008*k -0.059*k 0.223*k 0.109*k],[0.031 0.357 1.963 4.277 3.361 0.622 0.042]);
    nichols(KGH)
    ngrid
    X=sprintf('in figure%d k=%f .',m+4,k);
    disp(X);
    if m<3
        figure()
    end
    k=k*2;
end