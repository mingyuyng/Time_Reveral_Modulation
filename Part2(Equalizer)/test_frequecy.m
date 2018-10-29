%Date: 05/25/2017
%Description: This program plots the channel transfer response
%and frequency response of channel transfer response, FIR coefficients and
%channel impulse response

sps = 8;           
beta = 0.25;                                      %Rolloff factor 
span = 100;                                       %Number of symbols
bt = Pulse_shape_filter('RRC',beta,span,sps);     %Coefficients of RRC FIR filter


c = [0.2,0.5,0.15,0.05];     
h = upfirdn(filter(c,1,upfirdn(1, bt, sps)),bt,1,sps);
h = conv(h,[1,0.95]);


%Generate equalizers
N = 50;
N0 = 10^(-3);
eq = MMSE(N,span+1,h,N0,0,false);
eq1 = MMSE(N,span+1,h,N0,0,true);
eq2 = ZFE(N,span+1,h,N/2);
eq3 = MMSE(N,span+1,h,1,0,true);


%Time domain impulse response of MMSE equalizer(No compensation)
figure;stem(abs(conv(eq,h)));
xlabel('samples');
ylabel('amplitude');
title('overall impulse response using MMSE(No compensation)(High SNR)');

%Time domain impulse response of MMSE equalizer(With compensation)
figure;stem(abs(conv(eq1,h)));
xlabel('samples');
ylabel('amplitude');
title('overall impulse response using MMSE(With compensation)(High SNR)');

%Time domain impulse response of ZF equalizer
figure;stem(abs(conv(eq2,h)));
xlabel('samples');
ylabel('amplitude');
title('overall impulse response using ZF');

%Time domain impulse response of MMSE equalizer(No compensation)
figure;stem(abs(conv(eq3,h)));
xlabel('samples');
ylabel('amplitude');
title('overall impulse response using MMSE(Low SNR)');

%Frequency domain impulse response of MMSE equalizer
hov = conv(eq,h);
f = 0:1000/(N+1):5000-1000/(N+1);
p = 10*log10([abs(fft(eq)),abs(fft(eq)),abs(fft(eq)),abs(fft(eq)),abs(fft(eq))]);
figure;plot(f,p); hold on

f = 0:1000/length(h):5000-1000/length(h);
p = 10*log10([abs(fft(h)),abs(fft(h)),abs(fft(h)),abs(fft(h)),abs(fft(h))]);
plot(f,p); hold on

f = 0:1000/length(hov):5000-1000/length(hov);
p = 10*log10([abs(fft(hov)),abs(fft(hov)),abs(fft(hov)),abs(fft(hov)),abs(fft(hov))]);
plot(f,p); hold off

axis([0 5000 -30 30])

xlabel('f/MHz');
ylabel('amplitude(dB)');
title('Frequency response of MMSE');
legend('MMSE equalizer','Channel Transfer Response','Overall Channel Transfer Response');


%Frequency domain impulse response of ZF equalizer
hov = conv(eq2,h);
f = 0:1000/(N+1):5000-1000/(N+1);
p = 10*log10([abs(fft(eq2)),abs(fft(eq2)),abs(fft(eq2)),abs(fft(eq2)),abs(fft(eq2))]);
figure;plot(f,p); hold on

f = 0:1000/length(h):5000-1000/length(h);
p = 10*log10([abs(fft(h)),abs(fft(h)),abs(fft(h)),abs(fft(h)),abs(fft(h))]);
plot(f,p); hold on

f = 0:1000/length(hov):5000-1000/length(hov);
p = 10*log10([abs(fft(hov)),abs(fft(hov)),abs(fft(hov)),abs(fft(hov)),abs(fft(hov))]);
plot(f,p); hold off

axis([0 5000 -30 30])

xlabel('f/MHz');
ylabel('amplitude(dB)');
title('Frequency response of ZF');
legend('ZF equalizer','Channel Transfer Response','Overall Channel Transfer Response');


%Frequency domain impulse response of MMSE equalizer(Low SNR)
hov = conv(eq3,h);
f = 0:1000/(N+1):5000-1000/(N+1);
p = 10*log10([abs(fft(eq3)),abs(fft(eq3)),abs(fft(eq3)),abs(fft(eq3)),abs(fft(eq3))]);
figure;plot(f,p); hold on

f = 0:1000/length(h):5000-1000/length(h);
p = 10*log10([abs(fft(h)),abs(fft(h)),abs(fft(h)),abs(fft(h)),abs(fft(h))]);
plot(f,p); hold on

f = 0:1000/length(hov):5000-1000/length(hov);
p = 10*log10([abs(fft(hov)),abs(fft(hov)),abs(fft(hov)),abs(fft(hov)),abs(fft(hov))]);
plot(f,p); hold off

axis([0 5000 -30 30])

xlabel('f/MHz');
ylabel('amplitude(dB)');
title('Frequency response of MMSE(Low SNR)');
legend('MMSE equalizer','Channel Transfer Response','Overall Channel Transfer Response');