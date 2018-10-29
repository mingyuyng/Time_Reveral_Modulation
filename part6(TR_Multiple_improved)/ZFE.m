function [ eq ] = ZFE( length, center, h ,k0)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    delta = [zeros(length/2,1);1;zeros(length/2,1)];

    H = toeplitz(h(center-length/2+k0:center+length/2+k0),h(center-length/2+k0:-1:center-length-length/2+k0));

    eq = (H\delta).';
end

