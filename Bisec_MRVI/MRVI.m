function [U, taustaropt, aistaropt] = MRVI(X,A,lambda,R,P,delay,distribution_delay,kmax)
% clear all
% U: the trajectory of the optimal value g(k)
w=zeros(length(X),length(delay),length(A),kmax);
taustar=zeros(length(X),length(delay),length(A),kmax);
aistar=zeros(length(X),length(delay),length(A),kmax);
% A=1:2;
% P(:,:,1) = [0.999 0.001;0.1 0.9];
% P(:,:,2) = [0.6 0.4;0.01 0.99];
% R = [40 60;0 20];
% kmax=80;
h=zeros(length(X),length(delay),length(A),kmax);
k=2;
u=100*ones(length(X),length(delay),length(A));
l=zeros(length(X),length(delay),length(A));
tau=0.5;
while sum((u-l).^2,'all') >= 0.1 && k<=kmax
    [g(k),taustar(1,1,1,k),aistar(1,1,1,k)]=ValueUpdate_MRVI(1,1,1,h(:,:,:,k-1),lambda,R,P,distribution_delay,delay,tau);
        for sindex= 1:length(X)
            for deltaindex=1:length(delay)
                for aindex=1:length(A)                          
                        [w(sindex,deltaindex,aindex,k),taustar(sindex,deltaindex,aindex,k),aistar(sindex,deltaindex,aindex,k)]=ValueUpdate_MRVI(sindex,deltaindex,aindex,h(:,:,:,k-1),lambda,R,P,distribution_delay,delay,tau);                  
                end
            end
        end
    h(:,:,:,k)=(1-tau)*h(:,:,:,k-1)+w(:,:,:,k)-g(k);
    u=h(:,:,:,k);
    l=h(:,:,:,k-1);
    k=k+1
end
U=g(2:k-1); %原因是循环从k=2开始
% U=g(k-1);
taustaropt=taustar(:,:,:,k-1);
aistaropt=aistar(:,:,:,k-1);
end