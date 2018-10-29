function [ eq ] = MMSE_n(D,N,center,h,k0,IsNormal)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    l = length(h);
    
    h2 = conv(h,conj(h(end:-1:1)));
    
    %tanction
    h2 = (h2(l-N:l+N))./D;
    
    rr = toeplitz(h2(N+1:-1:1),h2(N+1:2*N+1));
    
    ri = (h(k0+center:-1:k0+center-N)./D).';
    
    eq = conj(rr\ri).';
    
    
    if(IsNormal)
        hh = conv(eq,h);
        k = hh(center+k0);
        
        eq = eq/k;
    end
    
    
end

