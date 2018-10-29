function [ error ] = decision( modulation,x,y)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here 
    error = zeros(1,1);
    if(strcmp(modulation,'BPSK'))
        for i = 1:length(y)
            if ((x(i) < 0 && real(y(i)) > 0 ) || (x(i) > 0 && real(y(i)) < 0) )
                error = error + 1;
            end
        end
    elseif(strcmp(modulation,'QPSK'))
        for i = 1:length(y)
            if (is_same_domain(x(i),y(i))==0)
                error = error + 1;
            end
        end
    else
        for i = 1:length(y)
             if(is_same_domain(x(i),y(i))==0)
                 error = error + 1;
             else
                if(real(x(i)) >= 0 && imag(x(i)) >= 0)
                    if(is_same_domain(x(i)+(-2-2*1j),y(i)+(-2-2*1j))==0)
                        error = error + 1;  %Not in 1 quadrant 
                    end    
                elseif(real(x(i)) <= 0 && imag(x(i)) >= 0)
                    if(is_same_domain(x(i)+(2-2*1j),y(i)+(2-2*1j))==0)
                        error = error + 1;  %Not in 2 quadrant
                    end    
                elseif(real(x(i)) <= 0 && imag(x(i)) <= 0)
                    if(is_same_domain(x(i)+(2+2*1j),y(i)+(2+2*1j))==0)
                        error = error + 1;  %Not in 3 quadrant
                    end    
                else
                    if(is_same_domain(x(i)+(-2+2*1j),y(i)+(-2+2*1j))==0)
                        error = error + 1;  %Not in 4 quadrant
                    end 
                end
            end
       end
    
    end

end

