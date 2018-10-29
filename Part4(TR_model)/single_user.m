channel_number = 100;
B = 1000;

Es = 1;
Es_N0 = 20:2:60;
es_n0 = 10.^(Es_N0/10);
N0 = Es./es_n0;

c = get_channel(1,6,channel_number,1);
ISI = zeros(channel_number,1);




D = 8;
Ts = 1;
for j = 1:channel_number
    
        h = downsample(c(:,j),Ts);
        L = length(h);
        weight = sum(abs(h.^2));
        hov = conv(h,conj(h(end:-1:1)))/weight;
    
        down = floor((L-1)/D);
    
        for k=-down:down
            if k ~= 0
                ISI(j) = ISI(j) + abs(hov(k*D+L))^2;
            end
        end
    
end

I = mean(ISI);

Pn = N0*B/D;

SINR = Es./(I+Pn);

plot(Es_N0,10*log10(SINR),'-ro');hold on



%%

D = 4;
Ts = 1;
for j = 1:channel_number
    
        h = downsample(c(:,j),Ts);
        L = length(h);
        weight = sum(abs(h.^2));
        hov = conv(h,conj(h(end:-1:1)))/weight;
    
        down = floor((L-1)/D);
    
        for k=-down:down
            if k ~= 0
                ISI(j) = ISI(j) + abs(hov(k*D+L))^2;
            end
        end
    
end

I = mean(ISI);

Pn = N0*B/D;

SINR = Es./(I+Pn);

plot(Es_N0,10*log10(SINR),'-bo');hold on

%%
D = 1;
Ts = 1;
for j = 1:channel_number
    
        h = downsample(c(:,j),Ts);
        L = length(h);
        weight = sum(abs(h.^2));
        hov = conv(h,conj(h(end:-1:1)))/weight;
    
        down = floor((L-1)/D);
    
        for k=-down:down
            if k ~= 0
                ISI(j) = ISI(j) + abs(hov(k*D+L))^2;
            end
        end
    
end

I = mean(ISI);

Pn = N0*B/D;

SINR = Es./(I+Pn);

plot(Es_N0,10*log10(SINR),'-go');hold on
xlabel('Es/N0(dB)');
ylabel('SINR(dB)');

legend('exponential D=8,Ts=1ns','exponential D=4,Ts=1ns','exponential D=2,Ts=1ns')