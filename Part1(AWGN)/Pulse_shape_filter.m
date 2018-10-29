function [ b ] = Pulse_shape_filter( varargin )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    if(strcmp(varargin{1},'RRC'))
        if(nargin > 4)
            error('Too many inputs..');
        elseif(nargin < 4)
            error('Not enough inputs..');
        else
            if(varargin{2} < 0 || varargin{2} > 1)
                error('The value rollback factor should be 0 to 1..');
            elseif(varargin{3} <= 0)
                error('The vnumber of symbols should be positive..');
            elseif(varargin{4} <= 0)
                error('The upsampling rate should be positive..');
            else
                b = rcosdesign(varargin{2}, varargin{3}, varargin{4});
            end
        end
        
    elseif(strcmp(varargin{1},'TR'))
        if(nargin > 2)
            error('Too many inputs..');
        elseif(nargin < 2)
            error('No enough inputs..');
        else
            l = length(varargin{2});
            b = conj(varargin{2}(l:-1:1));
        end
    else
        error('No such filter!');
    end

end

