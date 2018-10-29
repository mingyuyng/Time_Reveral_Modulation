%Date: 05/25/2017
%Description: This program plots the scatter plots of AWGN channel
%             BPSK, QPSK and 16QAM are tested


%Configuration of RRC filter

sps = 8;                          %up-sampling rate
beta = 0.25;                      %Rolloff factor 
span = 50;                        %Number of symbols
bt = Pulse_shape_filter('RRC',beta,span,sps);   %Coefficients of RRC FIR filter

modType = {'BPSK','QPSK','16QAM'};              %modulation schemes
InputLength = 100000;                           %Number of input symbol

for i = 1:3

    Es = Symbol_Energy(modType(i));      %Symbol energy

    Es_N0d = 20;                           %Generate the value of Es/N0(dB)
    Es_N0 = 10^(0.1*Es_N0d);               %Get the Es/N0 in linear scale
    N0 = Es/Es_N0;                         %Get the value of N0

    x = input_generation(modType(i),InputLength);    %Generate input sequences
    s = upfirdn(x, bt, sps);                      %Pass through RRC filter   
    r = Add_AWGN(s,N0);                           %Add AWGN to the signal
    y = upfirdn(r, bt, 1, sps);                   %Pass through RRC filter
    y = y(span+1:length(y)-span);                 %Take valuable samples
 
    %Draw pictures 

    if(strcmp(modType(i),'BPSK'))
        hScatter = scatterplot(y(1:1000),1,0,'mo');hold on
        scatterplot([-1,1],1,0,'yx',hScatter);
        grid on
        title('Scatter plot(BPSK)')
        legend('Received Symbol','Transmitted Symbol')
        axis([-2 2 -2 2]) % Set axis ranges
        hold off
    elseif(strcmp(modType(i),'QPSK'))
        hScatter = scatterplot(y(1:1000),1,0,'mo');hold on
        scatterplot([0.707+0.707*1j,0.707-0.707*1j,-0.707+0.707*1j,-0.707-0.707*1j],1,0,'yx',hScatter);
        grid on
        title('Scatter plot(QPSK)')
        legend('Received Symbol','Transmitted Symbol')
        axis([-2 2 -2 2]) % Set axis ranges
        hold off
    else
        a = [1,1,-1,-1];
        b = [1,-1,1,-1];
        hScatter = scatterplot(y(1:1000),1,0,'mo');hold on
        scatterplot([a+1j*b,a+1j*3*b, 3*a + 1j*b, 3*a + 3*b*1j],1,0,'yx',hScatter);
        grid on
        title('Scatter plot(16QAM)')
        legend('Received Symbol','Transmitted Symbol')
        axis([-4 4 -4 4]) % Set axis ranges
        hold off
    end
end



