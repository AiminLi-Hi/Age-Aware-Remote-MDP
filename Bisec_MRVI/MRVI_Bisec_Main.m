%% Parametersetup
clear all
X=1:2; % State
p=0.5; % Transition probability
delay = [1 10]; % Delay
distribution_delay=[p 1-p]; % Delay Distribution
A=1:2;
P(:,:,1) = [0.9 0.1;0.1 0.9];
P(:,:,2) = [0.6 0.4;0.01 0.99];
R = [40 60;0 20];
kmax=100;
h=zeros(length(X),length(delay),length(A),kmax);
h_opt=zeros(1,kmax);
tol = 0.001;
max_iter = 100;
iter = 0;
g=[];
distancenew=[];
ltr_k = zeros(1,length(A));
for k=1:length(A)
    inter = P(:,:,k)^100*R(:,k);
    ltr_k(k) = inter(1);
end
b = min(ltr_k);% Upper Bound
a = min(min(R));% Lower Bound
%% Bisec-MRVI
while (b - a) > tol && iter < max_iter
    iter = iter + 1;
    c = (a + b) / 2;
    [UC,taustar,aistar] = MRVI(X,A,c,R,P,delay,distribution_delay,kmax); % Calculate U(c) by running MRVI;
    % Record the value iteration process
    lambda(length(g)+1:length(g)+length(UC)) = c; 
    g = [g UC];
    fc = UC(end); % fc records the output U(c)
    UA = MRVI(X,A,a,R,P,delay,distribution_delay,kmax); % UA records the output U(a)
    if fc == 0  % The root of U(lambda) is found
        break;
    elseif UA(end) * fc < 0  % The root is on the left-hand side (a,c)
        b = c;
    else  % The root is on the left-hand side (b,c)
        a = c;
    end
end
% Reture the root
root = c;
% [zero,taustar,aistar]=RVI(X,A,root,R,P,distribution_delay,kmax);
% plot(lambda);



