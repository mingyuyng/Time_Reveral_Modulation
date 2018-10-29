function [ g1,g2 ] = waveform2( h1,h2,D )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

   l1 = length(h1);
   l2 = length(h2);
   
   down1 = floor((l1-1)/D);
   down2 = floor((l2-1)/D);
   
   e1 = eye(2*l1-1);
   e2 = eye(2*l2-1);
   
   H1 = toeplitz([h1.';zeros(l1-1,1)],[h1(1),zeros(1,l1-1)]);
   H2 = toeplitz([h2.';zeros(l2-1,1)],[h2(1),zeros(1,l2-1)]);
  
   H11 = zeros(l1,l1);
   H22 = zeros(l2,l2);
   
   for k=-down1:down1
        h = e1(l1+k*D,:)*H1;
        H11 = H11 + h'*h;
   end
   
   for k=-down2:down2
        h = e2(l2+k*D,:)*H2;
        H22 = H22 + h'*h;
   end

   H = zeros(l1+l2,l1+l2);
   
   H(1:l1,1:l1) = H(1:l1,1:l1)+H11;
   H(1:l2,1:l2) = H(1:l2,1:l2)+H22;
   H(l2+1:l2+l1,l2+1:l2+l1) = H(l2+1:l2+l1,l2+1:l2+l1)+H11;
   H(l1+1:l2+l1,l1+1:l2+l1) = H(l1+1:l2+l1,l1+1:l2+l1)+H22;
   
   h11 = zeros(l1+l2,1);
   h22 = zeros(l1+l2,1);
   
   h11(1:l1) = (e1(l1,:)*H1).';
   h22(l1+1:l2+l1) = (e2(l2,:)*H2).';
   
   omega = zeros(2,2);
   
   omega(1,1) = (H\conj(h11)).'*h11;
   omega(1,2) = (H\conj(h11)).'*h22;
   omega(2,1) = (H\conj(h22)).'*h11;
   omega(2,2) = (H\conj(h22)).'*h22;
   
   I = ones(2,1);
   
   ab = omega\I;
   
   g = ((ab(1)*h11.'+ab(2)*h22.')/H)';
   
   g1 = g(1:l1);
   g2 = g(l1+1:l1+l2);
   
   
   
end

