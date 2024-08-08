function qvalue = Qfunction(s,delta,a,taui,ai,v,hopt,R,P,Pdelay,delay)
P1=P(:,:,a)^(delay(delta));
part1sum=0;
for yi=1:length(delay) % Y_i Expectation
    for k=1:(taui+delay(yi)) % Sum in Equation 
        part1sum=part1sum+P1(s,:)*(P(:,:,ai))^(k-1)*R(:,ai)*Pdelay(delta,yi);
    end
end
part2=hopt*(taui+delay*Pdelay(delta,:)');%假设1,1,1为参考变量
part3=P1(s,:)*(P(:,:,ai))^(taui)*v(:,:,ai)*Pdelay(delta,:)';
qvalue=part1sum-part2+part3; 
end

