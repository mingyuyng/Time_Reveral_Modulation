function [ Es ] = Symbol_Energy(ModulationType)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    if strcmp(ModulationType,'BPSK')
        Es = 1;
    elseif strcmp(ModulationType,'QPSK')
        Es = 1;
    elseif strcmp(ModulationType,'16QAM')
        Es = 10;
    else
        error('No such modulation...');
    end

end

