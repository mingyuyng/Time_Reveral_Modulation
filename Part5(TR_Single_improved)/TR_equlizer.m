InputLength = 40000;                        %Number of input symbol
modType = 'BPSK';                           %modulation scheme
Es = 1;
D = 1;                                      %Up sampling rate(roll-off delay)
rms = 50;
Ts = 1;

%%%%%%%%%%%%%%%%%%%%%
number = 10;
step = 2;
Es_N0 = 1:step:(1+(number-1)*step);
es_n0 = 10.^(0.1*Es_N0);

N0 = Es./es_n0;                     

trial = 50;
errorRate = zeros(trial,number);       %The vector of error rate for different Es/N0

%%%%%%%%%%%%%%%%%%%%%

h = get_channel(1,6,trial,1);

for j = 1:trial 
    c = h(:,j);
    weight = sum(abs(c.^2));
    bt = Pulse_shape_filter('TR',c)/weight;             %Coefficients of TR filter
        
    for i = 1:number
        x = input_generation(modType,InputLength);      %generate input
        s = upfirdn(x, bt, D);                          %Upsamle the input
        s1 = conv(s,c);                                 %Pass the channel
        r = Add_AWGN(s1,N0(i));                         %Add noise 
        y = r(length(c):length(r)-length(c)+1);     
        y1 = upfirdn(y, 1, 1,D);                        %Downsample the received signal  
        error = decision(modType,x,y1);
        errorRate(j,i) = error/InputLength;
    end
end


 e = mean(errorRate);
 figure;semilogy(Es_N0,e,'-o');hold on
 
 
 
%%

for j = 1:trial 
    c = h(:,j);
    bt = good_waveform(c.',D);            
    for i = 1:number
        x = input_generation(modType,InputLength);  %generate input
        s = upfirdn(x, bt, D);                      %Upsamle the input
        s1 = conv(s,c);                             %Pass the channel
        r = Add_AWGN(s1,N0(i));                     
        y = r(length(c):length(r)-length(c)+1);     
        y1 = upfirdn(y,1,1,D);                      %Downsample the received signal  
        error = decision(modType,x,y1);
        errorRate(j,i) = error/InputLength;
    end
end

 e = mean(errorRate);
 
 semilogy(Es_N0,e,'-o');hold on
 

%%
%%%%%%%%%%%%%%%%%%%%
N = 50;                                       %Number of equalizer coefficients
k0 = N/2;                                     %Delay
%%%%%%%%%%%%%%%%%%%%

for j = 1:trial 
    c = h(:,j);
    weight = sum(abs(c.^2));
    bt = Pulse_shape_filter('TR',c)/weight;             %Coefficients of TR filter
    c1 = conv(c,bt);
    eq = ZFE(N,length(c),c1,k0);
    
    for i = 1:number
        x = input_generation(modType,InputLength);      %generate input
        s = upfirdn(x, bt, D);                     %Upsamle the input
        s1 = conv(eq,s);
        s1 = conv(s1,c);                                %Pass the channel
        r = Add_AWGN(s1,N0(i));    
        r1 = r(k0+1:length(r)- N + k0);
        y = r1(length(c):length(r1)-length(c)+1);     
        y1 = upfirdn(y,1,1,D);                   %Downsample the received signal  
        error = decision(modType,x,y1);
        errorRate(j,i) = error/InputLength;
    end
end

 e = mean(errorRate);
 
 semilogy(Es_N0,e,'-x');hold on
 
 %%
 
%%%%%%%%%%%%%%%%%%%%
N = 50;                                       %Number of equalizer coefficients
k0 = N/2;                                     %Delay
%%%%%%%%%%%%%%%%%%%%

for j = 1:trial 
    c = h(:,j);
    weight = sum(abs(c.^2));
    bt = Pulse_shape_filter('TR',c)/weight;             %Coefficients of TR filter
    c1 = conv(c,bt);
    eq = MMSE_n(D,N,length(c),c1.',k0,true);
    
    for i = 1:number
        x = input_generation(modType,InputLength);      %generate input
        s = upfirdn(x, bt, D);                     %Upsamle the input
        s1 = conv(eq,s);
        s1 = conv(s1,c);                                %Pass the channel
        r = Add_AWGN(s1,N0(i));    
        r1 = r(k0+1:length(r)- N + k0);
        y = r1(length(c):length(r1)-length(c)+1);     
        y1 = upfirdn(y,1,1,D);                   %Downsample the received signal  
        error = decision(modType,x,y1);
        errorRate(j,i) = error/InputLength;
    end
end

 e = mean(errorRate);
 
 semilogy(Es_N0,e,'-x');hold on
 
 xlabel('Es/N0(dB)');
 ylabel('P[error]/symbol');
 legend('Raw TR system','Optimal waveform','TR system with ZFE pre-equalization','TR system with MMSE pre-equalization');
 hold off