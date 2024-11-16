function Transition = Transitionfunction(s1,delta1,a1,s,delta,a,taui,ai,P,Pdelay,delay)
P1 = P(:,:,a)^(delay(delta))*(P(:,:,ai))^(taui);
Transition = Pdelay(delta1)*P1(s,s1)*(a1==ai);
end