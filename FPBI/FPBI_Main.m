clear all
X=1:2;
% distribution_delay=1/length(delay)*ones(1,length(delay)); %可手动调整
% distribution_delay=[1 zeros(1,9)];14.5754
% distribution_delay=[0 1 zeros(1,8)];
% distribution_delay=[0 0 1 zeros(1,7)];
% distribution_delay=[0.025 0.025 0.1 0.25 0.6];
% delay=1:length(distribution_delay);
A=1:2;
P(:,:,1) = [0.9 0.1;0.1 0.9];
P(:,:,2) = [0.6 0.4;0.01 0.99];
R = [40 60;0 20];
kmax=140;
delay=[1 10];
% delay=[1 3 5 10];
h=zeros(length(X),length(delay),length(A),kmax);
w=zeros(length(X),length(delay),length(A),kmax);
taustar=zeros(length(X),length(delay),length(A));
aistar=zeros(length(X),length(delay),length(A));
h_opt=zeros(1,kmax);
h_zero=zeros(length(X),length(delay),length(A),kmax);
w_zero=zeros(length(X),length(delay),length(A),kmax);
aistar_zero=zeros(length(X),length(delay),length(A));
h_opt_zero=zeros(1,kmax);
h_AoI=zeros(length(X),length(delay),length(A),kmax);
w_AoI=zeros(length(X),length(delay),length(A),kmax);
aistar_AoI=zeros(length(X),length(delay),length(A));
h_opt_AoI=zeros(1,kmax);
% p=0.05:0.05:1;%延迟系数
p=0.5;%延迟系数
% p = 0;
h_opt_p=zeros(1,length(p));
h_opt_AoI_p=zeros(1,length(p));
age_opt=zeros(1,length(p));
h_opt_zero_p=zeros(1,length(p));
age_zero=zeros(1,length(p));
age_hoptvalue=zeros(1,length(p));
for i = 1:length(p)
% for i = 9
%     delay=[1 i+1];
    delay=[1 10];
%     Pdelay=[p(i) 1-p(i);1-p(i) p(i)];%延迟为马尔科夫链
distribution=[p(i)  1-p(i)];
% distribution=[p  1-p];
c=ceil(AoI_threshold(delay, distribution)-0.5);
age_opt(i) = ((delay+max(c-delay,0)).^2*distribution')/(2*(delay+max(c-delay,0))*distribution')+(delay)*distribution'-0.5;
age_zero(i) = delay.^2*distribution'/(2*(delay)*distribution')+(delay)*distribution'-0.5;
Pdelay=[distribution;distribution];
    for k=2:kmax
        [h_opt_zero(k),aistar_zero(1,1,1)] = hstar_Zerowait(1,1,1,h_zero(:,:,:,k-1),R,P,Pdelay,delay);
        [h_opt(k),taustar(1,1,1),aistar(1,1,1)] = hstar(1,1,1,h(:,:,:,k-1),R,P,Pdelay,delay);
        [h_opt_AoI(k),aistar_AoI(1,1,1)] = hstar_AoI(1,1,1,h_AoI(:,:,:,k-1),R,P,Pdelay,delay);
        for sindex= 1:length(X)
            for deltaindex=1:length(delay)
                for aindex=1:length(A)
                    if sindex ==1 && deltaindex==1 && aindex==1
                        w(sindex,deltaindex,aindex,k)=0;
                        w_zero(sindex,deltaindex,aindex,k)=0;
                        w_AoI(sindex,deltaindex,aindex,k)=0;
                    else
                        [w(sindex,deltaindex,aindex,k),taustar(sindex,deltaindex,aindex),aistar(sindex,deltaindex,aindex)]=ValueUpdate(sindex,deltaindex,aindex,h(:,:,:,k-1),h_opt(k),R,P,Pdelay,delay);
                        [w_zero(sindex,deltaindex,aindex,k),aistar_zero(sindex,deltaindex,aindex)]=ValueUpdate_Zerowait(sindex,deltaindex,aindex,h_zero(:,:,:,k-1),h_opt_zero(k),R,P,Pdelay,delay);
                        [w_AoI(sindex,deltaindex,aindex,k),aistar_AoI(sindex,deltaindex,aindex)]=ValueUpdate_AoI(sindex,deltaindex,aindex,h_AoI(:,:,:,k-1),h_opt_AoI(k),R,P,Pdelay,delay);
                    end
                end
            end
        end
        h(:,:,:,k)=w(:,:,:,k);
        h_zero(:,:,:,k)=w_zero(:,:,:,k);
        h_AoI(:,:,:,k)=w_AoI(:,:,:,k);
    end
    h_opt_p(i)=h_opt(kmax);
    h_opt_zero_p(i)=h_opt_zero(kmax);
    h_opt_AoI_p(i)=h_opt_AoI(kmax);
    age_hoptvalue(i) =  age_hopt(P,delay,distribution,X,A,aistar,taustar);
end
% for i = 1:length(p)
% distribution=[p(i)  1-p(i)];
% delaymean(i)=delay*distribution';
% variance(i)=(delay-delaymean(i)).^2*distribution';
% end
%% 可视化
% plot(p,h_opt_p)
% hold on
% plot(p,h_opt_zero_p)
% plot(p,h_opt_AoI_p)
% plot(h_opt_p)
% hold on
% plot(h_opt_zero_p)
% plot(h_opt_AoI_p)
% legend("opt","zero","aoi")
% plot(h_opt)
plot(p,age_opt)
hold on
plot(p,age_hoptvalue)
plot(p,age_zero)
legend("aoi","opt","zero")
%% 后处理
% 求解最优的采样频率
for s = 1:length(X)
    for delta = 1:length(delay)
        for a = 1:length(A)
            for s1 = 1:length(X)
                for delta1 = 1:length(delay)
                    for a1 = 1:length(A)
                        T(s, delta, a, s1, delta1, a1) = Transitionfunction(s1, delta1, a1, s, delta, a, taustar(s,delta,a), aistar(s,delta,a), P, distribution, delay);
                    end
                end
            end
        end
    end
end
Transition = reshape(T,[length(X)*length(delay)*length(A),length(X)*length(delay)*length(A)]);
stationary_opt = [zeros(1,length(X)*length(delay)*length(A)-1),1]*Transition^100;
taustar_vec = reshape(taustar,[],1);
frequencycost = taustar_vec+delay*distribution';
expectation_frequency = stationary_opt*frequencycost%这个值就是阈值
h_opt_p(end)
% 求解零等待的采样频率
expectation_frequency_zero = 1/(delay*distribution');
% 求解age-opt的采样频率
for delta = 1:length(delay)
    truevalue(delta)= max(0,AoI_threshold(delay, Pdelay(1,:))-delay(delta));
end
expectation_frequency_age = 1/((truevalue+delay)*distribution');