%Date: 05/25/2017  
%This program simulates the symbol error rate(SER) for BPSK, QPSK and 16QAM
%Both the simulation and theoretical results are ploted 



%Initialization

InputLength = 1000000;            %Number of input symbol
modType = 'BPSK';                 %modulation scheme
Es = Symbol_Energy(modType);      %Symbol energy

%Configuration of RRC filter

sps = 8;                          %up-sampling rate
beta = 0.25;                      %Rolloff factor 
span = 50;                        %Number of symbols
bt = Pulse_shape_filter('RRC',beta,span,sps);   %Coefficients of RRC FIR filter

%Generate the vector of Es/N0

step = 1;                           %The step of Es/N0(dB)         
number = 15;                        %The number of Es/N0 to be tested
Es_N0d = step:step:number*step;     %Generate the vector of Es/N0(dB)
Es_N0 = 10.^(0.1*Es_N0d);           %Get the Es/N0 in linear scale
N0 = Es./Es_N0;                     %Get the vector of N0


errorRate = zeros(1,number);        %The vector of error rate for different Es/N0

%Loop of different Es/N0
for i = 1:number

    x = input_generation(modType,InputLength);    %Generate input sequences

    s = upfirdn(x, bt, sps);                      %Pass through RRC filter   

    r = Add_AWGN(s,N0(i));                        %Add AWGN to the signal

    y = upfirdn(r, bt, 1, sps);                   %Pass through RRC filter
    
    y = y(span+1:length(y)-span);                 %Take valuable samples
    
    error = decision(modType,x,y);                %Make decision to received symbols

    errorRate(i) = error/InputLength;             %Callculate and record the error rate
    
end



%Drawing pictures
%BPSK

 figure;semilogy(10*log10(Es_N0),errorRate,'-ro');hold on
 error1 = qfunc(sqrt(2*Es_N0));
 semilogy(10*log10(Es_N0),error1);
 xlabel('Es/N0(dB)');
 ylabel('P[error]/symbol');
 title('Symbol Error Rate(BPSK)');
 legend('Test result','Theory');
 hold off

%16QAM

%   figure;semilogy(10*log10(Es_N0),errorRate1,'-ro');hold on
%   error1 = 1-(1-1.5*qfunc(sqrt(0.2*Es_N0))).^2;
%   semilogy(10*log10(Es_N0),error1);
%   xlabel('Es/N0(dB)');
%   ylabel('P[error]/symbol');
%   title('Symbol Error Rate(BPSK)');
%   legend('Test result','Theory');
%   hold off

%QPSK

%  figure;semilogy(10*log10(Es_N0),errorRate2,'-ro');hold on
%  error = 1- (1 - qfunc(sqrt(Es_N0))).^2;
%  semilogy(10*log10(Es_N0),error);
%  xlabel('Es/N0(dB)');
%  ylabel('P[error]/symbol');
%  title('Symbol Error Rate(QPSK)');
%  legend('Test result','Theory');
%  hold off

