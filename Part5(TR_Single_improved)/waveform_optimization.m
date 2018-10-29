D = 1;

[pdp,h] = channel_estimation(50,1);

weight = sum(abs(h).^2);

g = conj(h(end:-1:1))/weight;

hov = conv(h,g);

plot(abs(hov)); 
xlabel('time/ns')


%%
D = 1;
L = 100;
t1 = 0.01;
t2 = 0.01;
load h
w = good_waveform( h, D, L, t1, t2);
l = length(h);
center = round((2*l+L-1)/2);
hov = conv(h,w);
figure;plot(abs(hov));
xlabel('taps')
ylabel('amplitude')
figure;plot(abs(w));
xlabel('taps')
ylabel('amplitude')

power = sum(abs(hov(center+D:D:end)).^2) + sum(abs(hov(center-D:-D:1)).^2)
power1 = sum(abs(w).^2)
power2 = sum(abs(hov).^2)
%%
D = 1;

x = input_generation('BPSK',20);

c = get_channel(1,6,1,1).';

w = good_waveform(c, D);

hov = conv(c,w);

hov1 = conv(c,conj(c(end:-1:1)));

l = length(c);

down = floor((l-1)/D);

a = hov(l+D:D:l+down*D);

plot(abs(hov));

v = filter(1,[1;a],x);

power = sum(abs(hov).^2)



