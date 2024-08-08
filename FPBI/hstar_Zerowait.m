function [h_opt, aistar] = hstar_Zerowait(s,delta,a,v,R,P,Pdelay,delay)
P1=P(:,:,a)^delay(delta);
ai=1:2;
g=zeros(1,length(ai));
for j=1:length(ai)
    %计算第一部分
    part1sum=0;
    for yi=1:length(delay)
        for k=1:delay(yi)
            part1sum=part1sum+P1(s,:)*(P(:,:,j))^(k-1)*R(:,j)*Pdelay(delta,yi);
        end
    end
    part2sum=P1(s,:)*(P(:,:,j))^0*v(:,:,j)*Pdelay(delta,:)';
    part3 = delay*Pdelay(delta,:)';
    g(j)=(part1sum+part2sum)/part3;
end
[h_opt, linearInd] = min(g);
[aistar] = ind2sub(size(g), linearInd);
end

