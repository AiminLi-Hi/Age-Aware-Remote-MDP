function root = AoI_threshold(delay, delay_distribution)
% AoI optimal waiting time
tol = 0.001;
max_iter = 100;
iter = 0;
b=  50;%上界
a = 0;%下界
while (b - a) > tol && iter < max_iter
    % 更新迭代次数
    iter = iter + 1;
    % 计算中点
    c = (a + b) / 2;
    % 检查中点的函数值
%     fc = (delay+max(c-delay,0))*delay_distribution'-((delay+max(c-delay,0)).^2*delay_distribution')/(2*c);
    Z2=(delay+max(ceil(c-0.5-delay),0)).^2*delay_distribution';
    Z3=(delay+max(ceil(c-0.5-delay),0))*delay_distribution';
    fc = Z3-Z2/(2*c);
    if fc == 0  % 找到了精确根
        break;
    elseif fc < 0  % 根在左半区
        a = c;
    else  % 根在右半区
        b = c;
    end
end
root=c;
% 返回近似根,近似跟就是阈值beta，等待延迟Z(y)=max(beta-y,0)
% f1=((delay+max(floor(c)-delay,0)).^2*delay_distribution')/(2*(delay+max(floor(c)-delay,0))*delay_distribution');
% f2=((delay+max(ceil(c)-delay,0)).^2*delay_distribution')/(2*(delay+max(ceil(c)-delay,0))*delay_distribution');
% if f1 < f2
%     root = floor(c);
% else
%     root =  ceil(c);
% end
end
% cupper = ceil(c);
% clower = floor(c);
% (delay.^2*delay_distribution'+0.236*max(cupper-delay,0).^2*delay_distribution'+(1-0.236)*max(clower-delay,0).^2*delay_distribution'+delay*delay_distribution'*(0.236*max(cupper-delay,0)+(1-0.236)*max(clower-delay,0))*delay_distribution')/(2*(delay+0.236*max(cupper-delay,0)+(1-0.236)*max(clower-delay,0))*delay_distribution')+delay*delay_distribution'



