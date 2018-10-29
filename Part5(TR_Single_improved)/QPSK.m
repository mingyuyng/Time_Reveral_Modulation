function [ X ] = QPSK( length )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

   data = randi([0 3], length, 1);
   
   X = pskmod(data,4,pi/4);

end

