function output = Add_AWGN( input, N0 )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    l = length(input);
    n = sqrt(N0/2).*randn(l,1) + 1j*sqrt(N0/2).*randn(l,1);  
    output = input + n;
end

