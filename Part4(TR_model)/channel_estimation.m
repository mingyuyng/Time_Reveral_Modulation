function [ pdp,c ] = channel_estimation(rms,Ts)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    length = 2*round(rms/Ts);
    c = zeros(1,length);
    for i = 1:length
        c(i) = sqrt(exp(-i*Ts/rms)/2)*randn(1) + 1j*sqrt(exp(-i*Ts/rms)/2)*randn(1);
    end
    
    i = 1:length;
    pdp = exp(-i*Ts/rms);
end

