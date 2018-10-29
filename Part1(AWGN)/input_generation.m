function [ X ] = input_generation(ModulationType, length )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    
    if strcmp(ModulationType,'BPSK')
        [X] = BPSK(length);
    elseif strcmp(ModulationType,'QPSK')
        [X] = QPSK(length);
    elseif strcmp(ModulationType,'16QAM')
        [X] = QAM16(length);
    end

end

