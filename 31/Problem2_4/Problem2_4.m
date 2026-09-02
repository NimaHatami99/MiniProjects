clear
clc
clf
KGH=tf([2.844 1.24],[1 3.456 3.207 0.611 0.042]);
margin(KGH)
[Gm,Pm,Wcg,Wcp]=margin(KGH)
grid on
disp('Gm is linear gain margin and GM is gain margin in dB.');
GM=20*log10(Gm)