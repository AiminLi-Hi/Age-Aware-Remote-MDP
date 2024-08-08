function [V,taustar,aistar] = ValueUpdate(s,delta,a,v,hopt,R,P,Pdelay,delay)
A=1:2;
maxtau=30;
r=zeros(maxtau,length(A));
for taui=1:maxtau
    for ai=1:length(A)
        r(taui,ai)=Qfunction(s,delta,a,taui-1,ai,v,hopt,R,P,Pdelay,delay);
    end
end
[V, linearInd] = min(r(:));
[taustar, aistar] = ind2sub(size(r), linearInd);
taustar=taustar-1;
end

