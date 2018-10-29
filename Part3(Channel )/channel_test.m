%Date: 05/25/2017
%Description: This program plots the channel impulse reponse of both simple
%channel model and 802.15.4a channel.


%Simple channel model

%rms delay: 50ns, time resolution: 1ns, Bandwidth: 1GHz, length: 100

rms = 50; Ts = 1; 

[pdp,c] = channel_estimation(rms,Ts);  %Generate the channel impulse response

t = Ts:Ts:length(pdp)*Ts;             
stem(t,pdp);

xlabel('t/ns')
ylabel('E[|h(t)|^2]')
title('Power Delay Profile')

figure;stem(t,abs(c));

xlabel('t/ns')
ylabel('|h(t)|')
title('Channel Impulse Response')
%%
%Manually made 802.15.4a channel model(Without frequency dependency)
%Time resolution: 1ns, Bandwidth: 1GHz

[pdp,c] = channel(0,1);

l = length(c);
Ts = 1;

t = Ts:Ts:l*Ts;
figure;stem(t,pdp);

xlabel('t/ns')
ylabel('E[|h(t)|^2]')
title('Power Delay Profile')

figure;stem(t,abs(c));

xlabel('t/ns')
ylabel('|h(t)|')
title('Channel Impulse Response')

%%

%IEEE 802.15.4a channel model(Without frequency dependency)
%Bandwidth: 2GHz, Carrier frequency: 6GHz

%Channel 1: Residential LOS
%Channel 2: Residential NLOS
%Channel 3: Office LOS
%Channel 4: Office NLOS
%Channel 5: Outdoor LOS
%Channel 6: Outdoor NLOS
%Channel 7: Industrial LOS
%Channel 8: Industrial NLOS
%Channel 9: Open Outdoor Environment NLOS

channelnumber = 1;
fs = 1.6;
fc = 6;

h = get_channel(fs,fc,1,channelnumber);
l = length(h);
Ts = 1/fs;
t = Ts:Ts:l*Ts;
stem(t,abs(h));
xlabel('t/ns')
ylabel('|h(t)|')
title('Channel Impulse Response')