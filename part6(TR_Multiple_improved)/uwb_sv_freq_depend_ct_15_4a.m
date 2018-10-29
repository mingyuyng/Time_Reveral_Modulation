function [h]= uwb_sv_freq_depend_ct_15_4a(h,fc,fs,num_channels,kappa) % This function is used to include the frequency dependency

f0 = 5; % GHz
h_len = length(h(:,1));
f = [fc-fs/2 : fs/h_len/2 : fc+fs/2]./f0;
f = f.^(-2*(kappa));
f = [f(h_len : 2*h_len), f(1 : h_len-1)]';
i = (-1)^(1/2); % complex i
for c = 1:num_channels
% add the frequency dependency
    h2 = zeros(2*h_len, 1);
    h2(1 : h_len) = h(:,c); % zero padding
    fh2 = fft(h2);
    fh2 = fh2 .* f;
    h2 = ifft(fh2);
    h(:,c) = h2(1:h_len);
    % Normalize the channel energy to 1
    h(:,c) = h(:,c)/sqrt(h(:,c)' * h(:,c) );
end
return