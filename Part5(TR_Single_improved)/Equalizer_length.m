N = 100;
D = 1;
number = 500;
channel = get_channel(1,6,number,1);
s = size(channel);
length = s(1);

ISI = zeros(N+1,number);

for k = 0:N
    for i = 1:number
        c = channel(:,i);
        h = conv(c,conj(c(end:-1:1)));
        eq = MMSE_n(D,N,length,h.',k,true);
        %eq = ZFE(N,length,h.',k);
        hov = conv(eq,h);
        
        center = length + k;
        down = floor((length+k-1)/D);
        up = floor((length+N-2-k)/D);
        
        for j=-down:up
            if j ~= 0
                ISI(k+1,i) = ISI(k+1,i) + abs(hov(j*D+center))^2;
            end
        end    
    end
end

ISI = mean(ISI,2);
plot(0:N,ISI); hold on 

%%
n = 100;
D = 1;
number = 100;
channel = get_channel(1,6,number,1);
s = size(channel);
length = s(1);
ISI = zeros(n,number);

for p = 1:n
    N = 2*p;
    k = p;
    for i = 1:number
        c = channel(:,i);
        h = conv(c,conj(c(end:-1:1)));
        eq = MMSE_n(D,N,length,h.',k,true);
        %eq = ZFE(N,length,h.',k);
        hov = conv(eq,h);
        
        center = length + k;
        down = floor((length+k-1)/D);
        up = floor((length+N-2-k)/D);
        
        for j=-down:up
            if j ~= 0
                ISI(p,i) = ISI(p,i) + abs(hov(j*D+center))^2;
            end
        end    
    end
end

ISI = mean(ISI,2);
plot(2*(1:p),ISI); hold on

