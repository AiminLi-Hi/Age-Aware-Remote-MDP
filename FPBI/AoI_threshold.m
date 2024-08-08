function root = AoI_threshold(delay, delay_distribution)
% AoI optimal waiting time
tol = 0.001;
max_iter = 100;
iter = 0;
b=  50;%�Ͻ�
a = 0;%�½�
while (b - a) > tol && iter < max_iter
    % ���µ�������
    iter = iter + 1;
    % �����е�
    c = (a + b) / 2;
    % ����е�ĺ���ֵ
%     fc = (delay+max(c-delay,0))*delay_distribution'-((delay+max(c-delay,0)).^2*delay_distribution')/(2*c);
    Z2=(delay+max(ceil(c-0.5-delay),0)).^2*delay_distribution';
    Z3=(delay+max(ceil(c-0.5-delay),0))*delay_distribution';
    fc = Z3-Z2/(2*c);
    if fc == 0  % �ҵ��˾�ȷ��
        break;
    elseif fc < 0  % ���������
        a = c;
    else  % �����Ұ���
        b = c;
    end
end
root=c;
% ���ؽ��Ƹ�,���Ƹ�������ֵbeta���ȴ��ӳ�Z(y)=max(beta-y,0)
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



