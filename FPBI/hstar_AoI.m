function [h_opt, taustar, aistar] = hstar_AoI(s,delta,a,v,R,P,Pdelay,delay)
P1=P(:,:,a)^delay(delta);
ai=1:2;
g=zeros(1,length(ai));
truevalue = max(0,ceil(AoI_threshold(delay, Pdelay(1,:))-0.5)-delay(delta));
taui = truevalue;
for j=1:length(ai)
    %�����һ����
    part1sum=0;
    for yi=1:length(delay)
        for k=1:(taui+delay(yi))
            part1sum=part1sum+P1(s,:)*(P(:,:,j))^(k-1)*R(:,j)*Pdelay(delta,yi);
        end
    end
    part2sum=P1(s,:)*(P(:,:,j))^(taui)*v(:,:,j)*Pdelay(delta,:)';
    part3 = taui+delay*Pdelay(delta,:)';
    g(j)=(part1sum+part2sum)/part3;
end
[h_opt, linearInd] = min(g);
[taustar, aistar] = ind2sub(size(g), linearInd);
end

