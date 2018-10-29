trial = 100;

Es = 1;
Es_N0 = 10:2:50;
es_n0 = 10.^(Es_N0/10);
N0 = Es./es_n0;
B = 1000;

N = 5;
D = 5;
Ts = 1;   

ISI = zeros(trial,N);   
for j = 1:trial
    
    c = get_channel(1,6,N,2).';
    s = size(c);
    L = s(2);
    
    down = floor((L-1)/D);
    for i = 1:N
        weight = sum(abs(c(i,:).^2));
        for p = 1:N
            h = conv(c(i,:),conj(c(p,end:-1:1)))/weight;
            for q=-down:down
                if ~(p == i && q == 0)
                    ISI(j,i) = ISI(j,i) + abs(h(q*D+L))^2;
                end
            end
        end
    end    
end
     
l1 = length(N0);
SINR = zeros(1,l1);
I = mean(ISI);
Pn = N0*B/D;
for i = 1:l1
    for j = 1:N
        SINR(i) = SINR(i) + log2(1+Es/(I(j)+Pn(i)));
    end
    
    SINR(i) = SINR(i)/D;
end
plot(Es_N0,SINR,':bo');hold on

%%
N = 10;
D = 5;

ISI = zeros(trial,N);    
for j = 1:100
    
     c = get_channel(1,6,N,2).';
     s = size(c);
     L = s(2);
    
     down = floor((L-1)/D);
     for i = 1:N
         weight = sum(abs(c(i,:).^2));
         for p = 1:N
             h = conv(c(i,:),conj(c(p,end:-1:1)))/weight;
             for q=-down:down
                 if ~(p == i && q == 0)
                     ISI(j,i) = ISI(j,i) + abs(h(q*D+L))^2;
                 end
             end
         end
     end  
end

l1 = length(N0);
SINR = zeros(1,l1);
I = mean(ISI);
Pn = N0*B/D;
for i = 1:l1
    for j = 1:N
        SINR(i) = SINR(i) + log2(1+Es/(I(j)+Pn(i)));
    end
    
    SINR(i) = SINR(i)/D;
end

plot(Es_N0,SINR,':b^');hold on
%%
N = 15;
D = 5;

ISI = zeros(trial,N);  
for j = 1:100
    
     c = get_channel(1,6,N,2).';
     s = size(c);
     L = s(2);
    
     down = floor((L-1)/D);
     for i = 1:N
         weight = sum(abs(c(i,:).^2));
         for p = 1:N
             h = conv(c(i,:),conj(c(p,end:-1:1)))/weight;
             for q=-down:down
                 if ~(p == i && q == 0)
                     ISI(j,i) = ISI(j,i) + abs(h(q*D+L))^2;
                 end
             end
         end
     end  
end

l1 = length(N0);
SINR = zeros(1,l1);
I = mean(ISI);
Pn = N0*B/D;
for i = 1:l1
    for j = 1:N
        SINR(i) = SINR(i) + log2(1+Es/(I(j)+Pn(i)));
    end
    
    SINR(i) = SINR(i)/D;
end

plot(Es_N0,SINR,':bd');hold on

%%

N = 5;
D = 1;


ISI = zeros(trial,N);   
for j = 1:trial
    
    c = get_channel(1,6,N,2).';
    s = size(c);
    L = s(2);
    
    down = floor((L-1)/D);
    for i = 1:N
        weight = sum(abs(c(i,:).^2));
        for p = 1:N
            h = conv(c(i,:),conj(c(p,end:-1:1)))/weight;
            for q=-down:down
                if ~(p == i && q == 0)
                    ISI(j,i) = ISI(j,i) + abs(h(q*D+L))^2;
                end
            end
        end
    end    
end
     
l1 = length(N0);
SINR = zeros(1,l1);
I = mean(ISI);
Pn = N0*B/D;
for i = 1:l1
    for j = 1:N
        SINR(i) = SINR(i) + log2(1+Es/(I(j)+Pn(i)));
    end
    
    SINR(i) = SINR(i)/D;
end
plot(Es_N0,SINR,':ro');hold on


%%

N = 10;
D = 1;
  

ISI = zeros(trial,N);   
for j = 1:trial
    
    c = get_channel(1,6,N,2).';
    s = size(c);
    L = s(2);
    
    down = floor((L-1)/D);
    for i = 1:N
        weight = sum(abs(c(i,:).^2));
        for p = 1:N
            h = conv(c(i,:),conj(c(p,end:-1:1)))/weight;
            for q=-down:down
                if ~(p == i && q == 0)
                    ISI(j,i) = ISI(j,i) + abs(h(q*D+L))^2;
                end
            end
        end
    end    
end
     
l1 = length(N0);
SINR = zeros(1,l1);
I = mean(ISI);
Pn = N0*B/D;
for i = 1:l1
    for j = 1:N
        SINR(i) = SINR(i) + log2(1+Es/(I(j)+Pn(i)));
    end
    
    SINR(i) = SINR(i)/D;
end
plot(Es_N0,SINR,':r^');hold on

%%

N = 15;
D = 1;
Ts = 1;   

ISI = zeros(trial,N);   
for j = 1:trial
    
    c = get_channel(1,6,N,2).';
    s = size(c);
    L = s(2);
    
    down = floor((L-1)/D);
    for i = 1:N
        weight = sum(abs(c(i,:).^2));
        for p = 1:N
            h = conv(c(i,:),conj(c(p,end:-1:1)))/weight;
            for q=-down:down
                if ~(p == i && q == 0)
                    ISI(j,i) = ISI(j,i) + abs(h(q*D+L))^2;
                end
            end
        end
    end    
end
     
l1 = length(N0);
SINR = zeros(1,l1);
I = mean(ISI);
Pn = N0*B/D;
for i = 1:l1
    for j = 1:N
        SINR(i) = SINR(i) + log2(1+Es/(I(j)+Pn(i)));
    end
    
    SINR(i) = SINR(i)/D;
end
plot(Es_N0,SINR,':rd');hold on
%%

xlabel('Es/N0(dB)');
ylabel('Average Achievable Sum Rate(bps/Hz)');
legend('802.15.4a, Ts = 1ns, D = 1, N = 5','802.15.4a, Ts = 1ns, D = 1, N = 10','802.15.4a, Ts = 1ns, D = 1, N = 15')