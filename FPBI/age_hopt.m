function age =  age_hopt(P,delay,distribution,X,A,aistar,taustar)
for i=1:length(X)
    for j=1:length(delay)
        for k=1:length(A)
            for a=1:length(X)
                for b=1:length(delay)
                    for c=1:length(A)
                        P1=P(:,:,k)^delay(j)*P(:,:,aistar(i,j,k))^taustar(i,j,k);
                        P2(i,j,k,a,b,c)=P1(i,a)*(c==aistar(i,j,k))*distribution(b);
                        Chain(k+(j-1)*length(A)+(i-1)*length(A)*length(delay),c+(b-1)*length(A)+(a-1)*length(A)*length(delay))=P2(i,j,k,a,b,c);
                    end
                end
            end
        end
    end
end
% Plimit=Chain^100;
P = Chain;
n = size(P, 1);
B = [P' - eye(n); ones(1, n)];
% 创建右侧向量（全0向量和一个1）
b = [zeros(n, 1); 1];
% 解线性方程组
st = B \ b;
% st=Plimit(1,:);
for i=1:length(X)
    for j=1:length(delay)
        for k=1:length(A)
            P3(i,j,k)=st(k+(j-1)*length(A)+(i-1)*length(A)*length(delay));
        end
    end
end
frac1=0;
frac2=0;
for i=1:length(X)
    for j=1:length(delay)
        for k=1:length(A)
            frac1=frac1+P3(i,j,k)*(delay(j)+taustar(i,j,k))^2;
            frac2=frac2+P3(i,j,k)*(delay(j)+taustar(i,j,k));
        end
    end
end
age=frac1/(2*frac2)+delay*distribution'-0.5;
end