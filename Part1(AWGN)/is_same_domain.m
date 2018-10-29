function [ out ] = is_same_domain( x,y )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

    if((real(x)>0 && imag(x) > 0 && real(y)>0 && imag(y) > 0) || ...
            (real(x)<0 && imag(x) > 0 && real(y)<0 && imag(y) > 0) || ...
            (real(x)>0 && imag(x) < 0 && real(y)>0 && imag(y) < 0) || ...
            (real(x)<0 && imag(x) < 0 && real(y)<0 && imag(y) < 0) )
        out = 1;
    else
        out = 0;
    end
end

