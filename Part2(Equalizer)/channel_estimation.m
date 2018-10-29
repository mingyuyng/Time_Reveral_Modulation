function [ c ] = channel_estimation( N, rms, Ts)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    length = 2*round(rms/Ts);
    c = zeros(N,length);
    
    for i = 1:length
        c(:,i) = sqrt(exp(-i*Ts/rms)/2)*randn(N,1) + 1j*sqrt(exp(-i*Ts/rms)/2)*randn(N,1);
    end

end

