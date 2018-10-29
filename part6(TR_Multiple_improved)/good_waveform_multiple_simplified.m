function [ g ] = good_waveform_multiple_simplified(D,h,M,t1,t2)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    s = size(h);
    N = s(1);
    l = s(2);
    center = round((M+2*l-1)/2);
    
    down = floor((center-1)/D);
    up = floor((M+2*l-1-center)/D);
    
    H = zeros(l+M,l+M);
    hh = zeros(N,l+M);
    H1 = zeros(l+M,l+M);
    for i = 1:N
        
        Ht = toeplitz([h(i,:).';zeros(l+M-1,1)],[h(i,1),zeros(1,M+l-1)]);
        hh(i,:) = Ht(center,:);
        
        %b = [zeros(l,l);Ht(l-1:2*l-1,:)];
        a = Ht'*Ht;
        H1 = H1 + a;
    
        HH = zeros(l+M,l+M);
        for k=-down:up
            h1 = Ht(center+k*D,:);
            HH = HH + h1'*h1;
        end
        H = H + HH;
    end
    
    H = H + t1* eye(l+M,l+M) + t2*H1;
    g = zeros(N,l+M);
    
    for i = 1:N
        H2 = hh(i,:)/H;
        weight = H2*hh(i,:)';
        g(i,:) = conj(H2/weight);
    end
    
end
 

