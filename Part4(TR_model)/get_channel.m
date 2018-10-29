function [ h ] = get_channel( fs,fc,channel_num,model_num )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    
    num_channels = channel_num;
    cm_num = model_num; 
    
    [Lam,Lmean,lambda_mode,lambda_1,lambda_2,beta,Gam,gamma_0,Kgamma, ... 
 sigma_cluster,nlos,gamma_rise,gamma_1,chi,m0,Km,sigma_m0,sigma_Km, ... 
 sfading_mode,m0_sp,std_shdw,kappa] = uwb_sv_params_15_4a( cm_num ); 

%     fprintf(1,['Model Parameters\n' ...
% ' Lam = %.4f, Lmean = %.4f, lambda_mode(FLAG) = %d\n' ...
% ' lambda_1 = %.4f, lambda_2 = %.4f, beta = %.4f\n' ...
% ' Gam = %.4f, gamma0 = %.4f, Kgamma = %.4f, sigma_cluster = %.4f\n' ...
% ' nlos(FLAG) = %d, gamma_rise = %.4f, gamma_1 = %.4f, chi = %.4f\n' ...
% ' m0 = %.4f, Km = %.4f, sigma_m0 = %.4f, sigma_Km = %.4f\n' ...
% ' sfading_mode(FLAG) = %d, m0_sp = %.4f, std_shdw = %.4f\n' ...
% ' kappa = %.4f, fc = %.4fGHz, fs = %.4fGHz\n'], ... 
%  Lam,Lmean,lambda_mode,lambda_1,lambda_2,beta,Gam,gamma_0,Kgamma, ... 
%  sigma_cluster,nlos,gamma_rise,gamma_1,chi,m0,Km,sigma_m0,sigma_Km,... 
%  sfading_mode,m0_sp,std_shdw,kappa,fc,fs);

  ts = 1/fs; % sampling frequency
  
 [h_ct,t_ct,t0,np] = uwb_sv_model_ct_15_4a(Lam,Lmean,lambda_mode,lambda_1, ... 
  lambda_2,beta,Gam,gamma_0,Kgamma,sigma_cluster,nlos,gamma_rise,gamma_1, ... 
  chi,m0,Km,sigma_m0,sigma_Km,sfading_mode,m0_sp,std_shdw,num_channels,ts);

% change to complex baseband channel
h_ct_len = size(h_ct, 1);

for k = 1:num_channels
    phi = rand(h_ct_len, 1).*(2*pi);
    h_ct(:,k) = h_ct(:,k) .* exp(phi .* 1i);
end

% now reduce continuous-time result to a discrete-time result
[hN,N] = uwb_sv_cnvrt_ct_15_4a( h_ct, t_ct, np, num_channels, ts );

if N > 1,
    h = resample(hN, 1, N); % decimate the columns of hN by factor N
else
    h = hN;
end
% add the frequency dependency

[h]= uwb_sv_freq_depend_ct_15_4a(h,fc,fs,num_channels,kappa);

end

