function [ w ] = good_waveform( h, D, N, t1, t2)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    l = length(h);
    center = round((N+2*l-1)/2);
    H = toeplitz([h.';zeros(N+l-1,1)],[h(1),zeros(1,N+l-1)]);
    
    down = floor((center-1)/D);
    up = floor((N+2*l-1-center)/D);
    A = zeros(l+N,l+N);

    for k=-down:0
        h1 = H(center+k*D,:);
        A = A + h1'*h1; 
    end
    
    %b = [zeros(l,l);H(l-1:2*l-1,:)];
    a = H'*H;
    A = A + t1*eye(l+N,l+N) + t2*a;
    E0 = H(center,:);
    weight = (E0/A)*E0';
    w = (E0/A)'/weight;
end

