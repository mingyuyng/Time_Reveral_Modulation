function [ X ] = BPSK(length)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    X = 2*randi([0,1], length, 1) - 1;
end

