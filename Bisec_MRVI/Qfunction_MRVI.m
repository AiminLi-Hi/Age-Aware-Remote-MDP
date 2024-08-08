function qvalue = Qfunction_MRVI(s,delta,a,taui,ai,v,lambda,R,P,distribution_delay,delay,tau)
P1=P(:,:,a)^delay(delta);
part1sum=0;
for yi=1:length(delay)
    if taui+delay(yi) == 0
        part1sum = part1sum+R(s,ai)*distribution_delay(yi);
    else
        for k=1:(taui+delay(yi))
            part1sum=part1sum+P1(s,:)*(P(:,:,ai))^(k-1)*R(:,ai)*distribution_delay(yi);
        end
    end
end
part2=lambda*(taui+delay*distribution_delay');%假设1,1,1为参考变量
part3=P1(s,:)*(P(:,:,ai))^(taui)*v(:,:,ai)*distribution_delay';
qvalue=part1sum-part2+tau*part3;
end

