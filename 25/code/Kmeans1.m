clear
clc
clf
mat=[9.85,10.76,11.427,8.782,12.799,7.262,9.666,9.61,15.712,9.801,10.621,12.417,13.52,9.836,12.58,11.915,12.523,11.993,19.7,10.536];
meas=mat';
X=[meas,meas];
[idx,ctrs] = kmeans(X,2);
plot(X(idx==1,1),X(idx==1,2),'r.','MarkerSize',12)
hold on
plot(X(idx==2,1),X(idx==2,2),'b.','MarkerSize',12)
plot(ctrs(:,1),ctrs(:,2),'kx','MarkerSize',12,'LineWidth',2)
plot(ctrs(:,1),ctrs(:,2),'ko','MarkerSize',12,'LineWidth',2)
legend('Cluster 1','Cluster 2','Centroids','Location','best')
hold off