function [ g ] = good_waveform_multiple(D,h)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    s = size(h);
    N = s(1);
    l = s(2);
    down = floor((l-1)/D);
    H = zeros(N*l,N*l);
    hh = zeros(N,N*l);
    
    for i = 1:N
        Ht = toeplitz([h(i,:).';zeros(l-1,1)],[h(i,1),zeros(1,l-1)]);
        hh(i,:) = [zeros(1,(i-1)*l),Ht(l,:),zeros(1,(N-i)*l)];
        HH = zeros(l,l);
        
        for k=-down:down
            h1 = Ht(l+k*D,:);
            HH = HH + h1'*h1;
        end
        
        for j = 1:N
            H(((j-1)*l+1):j*l,((j-1)*l+1):j*l) = H(((j-1)*l+1):j*l,((j-1)*l+1):j*l) + HH;
        end
    end
   
    omega = zeros(N,N);
    for i = 1:N
        for j = 1:N
            omega(i,j) = (hh(i,:)/H)*hh(j,:)';
        end
    end
    
    I = ones(N,1);
   
    lambda = omega\I;
    
    beta = zeros(1,N*l);
    
    for i = 1:N
        beta = beta + lambda(i)*hh(i,:);
    end
    
    gg = (beta/H)';
    g = zeros(N,l);
    
    for i = 1:N
        g(i,:) = gg((i-1)*l+1:i*l).';
    end
    
end

