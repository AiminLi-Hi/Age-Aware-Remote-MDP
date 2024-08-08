function [h_opt, taustar, aistar] = hstar(s,delta,a,v,R,P,Pdelay,delay) %Equation (17)
P1=P(:,:,a)^delay(delta);
taui=1:30;
ai=1:2;
g=zeros(length(taui),length(ai));
for i=1:length(taui)
    for j=1:length(ai)
        %计算第一部分
        part1sum=0;
        for yi=1:length(delay)
            for k=1:(i-1+delay(yi))
                part1sum=part1sum+P1(s,:)*(P(:,:,j))^(k-1)*R(:,j)*Pdelay(delta,yi);
            end
        end
        part2sum=P1(s,:)*(P(:,:,j))^(i-1)*v(:,:,j)*Pdelay(delta,:)';
        part3 = i-1+delay*Pdelay(delta,:)';
        g(i,j)=(part1sum+part2sum)/part3;
    end
end
[h_opt, linearInd] = min(g(:));
[taustar, aistar] = ind2sub(size(g), linearInd);
end

