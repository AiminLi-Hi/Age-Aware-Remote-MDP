function [V,taustar,aistar] = ValueUpdate_MRVI(s,delta,a,v,lambda,R,P,distribution_delay,delay,tau)
A=1:2;
maxtau=30;
r=zeros(maxtau,length(A));
for taui=1:maxtau
    for ai=1:length(A)
        r(taui,ai)=Qfunction_MRVI(s,delta,a,taui-1,ai,v,lambda,R,P,distribution_delay,delay,tau);
    end
end
[V, linearInd] = min(r(:));
[taustar, aistar] = ind2sub(size(r), linearInd);
end

