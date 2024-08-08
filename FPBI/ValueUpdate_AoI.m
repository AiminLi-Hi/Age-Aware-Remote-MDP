function [V,aistar] = ValueUpdate_AoI(s,delta,a,v,hopt,R,P,Pdelay,delay)
A=1:2;
r=zeros(1,length(A));
% tau = floor(max(0,AoI_threshold(delay, Pdelay(1,:))-delta)); %可能不是最优
truevalue = max(0,ceil(AoI_threshold(delay, Pdelay(1,:))-0.5)-delay(delta));
for ai=1:length(A)
    %     r(ai)=Qfunction(s,delta,a,upper,ai,v,hopt,R,P,Pdelay,delay);
    r(ai)=Qfunction(s,delta,a,truevalue,ai,v,hopt,R,P,Pdelay,delay);
end
[V, linearInd] = min(r);
aistar = ind2sub(size(r), linearInd);
end

