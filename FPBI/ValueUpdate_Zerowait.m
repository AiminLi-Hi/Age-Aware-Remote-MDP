function [V,aistar] = ValueUpdate_Zerowait(s,delta,a,v,hopt,R,P,Pdelay,delay)
A=1:2;
r=zeros(1,length(A));
for ai=1:length(A)
    r(ai)=Qfunction(s,delta,a,0,ai,v,hopt,R,P,Pdelay,delay);
end
[V, linearInd] = min(r);
aistar = ind2sub(size(r), linearInd);
end

