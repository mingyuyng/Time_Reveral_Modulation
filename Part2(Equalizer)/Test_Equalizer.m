%Date: 05/25/2017
%Description: This program plots the scatter plot of 16QAM with multipath
%channel and two linear equalizers(ZFE and MMSE-LE). The results MMSE-LE
%with and without compensation are all shown.


InputLength = 100000;                  %Number of input symbol
modType = '16QAM';                     %modulation scheme
Es = Symbol_Energy(modType);           %Symbol energy


sps = 8;                               %up-sampling rate
beta = 0.25;                           %Rolloff factor 
span = 50;                             %Number of symbols
bt = Pulse_shape_filter('RRC',beta,span,sps);   %Coefficients of RRC FIR filter


Es_N0d = 30;                           %Generate the vector of Es/N0(dB)
Es_N0 = 10^(0.1*Es_N0d);               %Get the Es/N0 in linear scale
N0 = Es/Es_N0;                         %Get the vector of N0


%Initialization of Equalizers
N = 50;                                %Length of FIR equalizers
k01 = 0;                               %Delay factor of ZFE
k02 = N/2;                             %Delay factor of MMSE-LE


%Generate channel impulse response
c = [-0.0807 + 0.0953i  -0.0849 - 0.1336i  -0.0338 + 0.0911i   0.0026 + 0.1349i   0.0164 - 0.1144i];
h = upfirdn(filter(c,1,upfirdn(1, bt, sps)),bt,1,sps);     


eq_mc = MMSE(N,span+1,h,N0,k01,true);         %MMSE-LE FIR coefficients with compensation
eq_mn = MMSE(N,span+1,h,N0,k01,false);        %MMSE-LE FIR coefficients without compensation
eq_z = ZFE(N,span+1,h,k02);                   %ZFE FIR coefficients


x = input_generation(modType,InputLength);    %Generate input sequences

s = upfirdn(x, bt, sps);                      %Pass through RRC filter
  
s1 = filter(c,1,s);                           %Pass through the channel

r = Add_AWGN(s1,N0);                          %Add AWGN to the signal

y = upfirdn(r, bt, 1, sps);                   %Pass through RRC filter


%%Pass through different equalizers

y1 = y(span+1:length(y)-span);                %Take valuable samples(No equalizer)

y2 = conv(eq_mn,y1);                          %Pass through MMSE equalizer(No compensation)
    
y2 = y2(k01+1: length(y2) - N + k01);         %Take samples

y3 = conv(eq_mc,y1);                          %Pass through MMSE equalizer(With compensation)
    
y3 = y3(k01+1: length(y3) - N + k01);         %Take samples
    
y4 = conv(eq_z,y1);                           %Pass through ZF equalizer

y4 = y4(k02+1: length(y4) - N + k02);         %Take samples

%%

a = [1,1,-1,-1];
b = [1,-1,1,-1];

hScatter = scatterplot(y3(1:3000),1,0,'ko');hold on
scatterplot(y4(1:3000),1,0,'yo',hScatter);
scatterplot([a+1j*b,a+1j*3*b, 3*a + 1j*b, 3*a + 3*b*1j],1,0,'rx',hScatter);
grid on
legend('MMSE(with compensation)','ZFE','Transmitted symbols')
axis([-4 4 -4 4]) % Set axis ranges
hold off
%%

hScatter = scatterplot(y2(1:3000),1,0,'ko');hold on
scatterplot(y4(1:3000),1,0,'yo',hScatter);
scatterplot([a+1j*b,a+1j*3*b, 3*a + 1j*b, 3*a + 3*b*1j],1,0,'rx',hScatter);
grid on
legend('MMSE(without compensation)','ZFE','Transmitted symbols')
axis([-4 4 -4 4]) % Set axis ranges
hold off

