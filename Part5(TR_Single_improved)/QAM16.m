function [ data ] = QAM16( length )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
     q = 2*randi([0 3], length, 1) - 3;
     p = 2*randi([0 3], length, 1) - 3;
     data = q + 1j*p;
end

