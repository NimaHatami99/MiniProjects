clear
clc
i=input("inter the new data: ");
newpoint=[i,i];
clf
S=load('FC5_ClassA_preprocessed.mat');
A=S.data;
T=load('FC5_ClassB_preprocessed.mat');
B=T.data;
mat=[9.85,10.76,11.427,8.782,12.799,7.262,9.666,9.61,15.712,9.801,10.621,12.417,13.52,9.836,12.58,11.915,12.523,11.993,19.7,10.536];
meas=mat';
species={'classA';'classA';'classA';'classA';'classA';'classA';'classA';'classA';'classA';'classA';'classB';'classB';'classB';'classB';'classB';'classB';'classB';'classB';'classB';'classB'};
gscatter(meas,meas,species);
legend('Location','best');
line(newpoint(1),newpoint(2),'marker','+','color','k','markersize',10,'linewidth',2);
x=[meas,meas];
Mdl = KDTreeSearcher(x);
[n,d] = knnsearch(Mdl,newpoint,'k',5);
line(x(n,1),x(n,2),'color',[.5 .5 .5],'marker','o','linestyle','none','markersize',10);
p=tabulate(species(n));
tabulate(species(n))
k=cell2mat(p(:,3));
if k(1,1)>k(2,1)
    disp('new data is in '+string(p(1,1)))
else
    disp('new data is in '+string(p(2,1)))
end