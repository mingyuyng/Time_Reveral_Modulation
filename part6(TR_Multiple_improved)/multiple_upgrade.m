
Es = 1;
start = 60;
step = 4;
number = 40;

Es_N0 = start:step:(number-1)*step + start;
es_n0 = 10.^(Es_N0/10);
N0 = Es./es_n0;


load channel

s = size(channel);
Cha_length = s(1);
Trial_number = 5;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
User_number = 5;
D = 5;
Ts = 1;
B = 10^9/(D*Ts);
ISI = zeros(Trial_number,User_number);
l = 0;
mu1 = 0;
mu2 = 0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

center = round((l+2*Cha_length-1)/2);

for j = 1:Trial_number
    
    c = channel(:,(j-1)*User_number+1:j*User_number).';
    g = good_waveform_multiple_simplified(D,c,l,mu1,mu2);

    down = floor((center-1)/D);
    up = floor((l+2*Cha_length-1-center)/D);
       for i = 1:User_number
           for p = 1:User_number
               h = conv(c(i,:),g(p,:));
               for q=-down:up
                   if ~(p == i && q == 0)
                       ISI(j,i) = ISI(j,i) + abs(h(q*D+center))^2;
                   end
               end
           end
       end
    
end
     

ASR = zeros(1,number);
I = mean(ISI);
Pn = N0*B;
for i = 1:number
    for j = 1:User_number
        ASR(i) = ASR(i) + log2(1+Es/(I(j)+Pn(i)));
    end
    ASR(i) = ASR(i)/D;
end
plot(Es_N0,ASR,'-ro');hold on

%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
User_number = 5;
D = 5;
Ts = 1;
B = 10^9/(D*Ts);
ISI = zeros(Trial_number,User_number);
l = 0;
mu1 = 0;
mu2 = 0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
center = round((l+2*Cha_length-1)/2);

for j = 1:Trial_number
    
    c = channel(:,(j-1)*User_number+1:j*User_number).';
    g = good_waveform_multiple_simplified(D,c,l,mu1,mu2);

    down = floor((center-1)/D);
    up = floor((l+2*Cha_length-1-center)/D);
       for i = 1:User_number
           for p = 1:User_number
               h = conv(c(i,:),g(p,:));
               for q=-down:up
                   if ~(p == i && q == 0)
                       ISI(j,i) = ISI(j,i) + abs(h(q*D+center))^2;
                   end
               end
           end
       end
    
end
     

ASR = zeros(1,number);
I = mean(ISI);
Pn = N0*B;
for i = 1:number
    for j = 1:User_number
        ASR(i) = ASR(i) + log2(1+Es/(I(j)+Pn(i)));
    end
    ASR(i) = ASR(i)/D;
end
plot(Es_N0,ASR,'-r^');hold on
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
User_number = 7;
D = 5;
Ts = 1;
B = 10^9/(D*Ts);
ISI = zeros(Trial_number,User_number);
l = 0;
mu1 = 0;
mu2 = 0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
center = round((l+2*Cha_length-1)/2);

for j = 1:Trial_number
    
    c = channel(:,(j-1)*User_number+1:j*User_number).';
    g = good_waveform_multiple_simplified(D,c,l,mu1,mu2);

    down = floor((center-1)/D);
    up = floor((l+2*Cha_length-1-center)/D);
       for i = 1:User_number
           for p = 1:User_number
               h = conv(c(i,:),g(p,:));
               for q=-down:up
                   if ~(p == i && q == 0)
                       ISI(j,i) = ISI(j,i) + abs(h(q*D+center))^2;
                   end
               end
           end
       end
    
end
     

ASR = zeros(1,number);
I = mean(ISI);
Pn = N0*B;
for i = 1:number
    for j = 1:User_number
        ASR(i) = ASR(i) + log2(1+Es/(I(j)+Pn(i)));
    end
    ASR(i) = ASR(i)/D;
end
plot(Es_N0,ASR,'-rd');hold on



%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
User_number = 3;
D = 5;
Ts = 1;
B = 10^9/(D*Ts);
ISI = zeros(Trial_number,User_number);
l = 100;
mu1 = 0.01;
mu2 = 0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
center = round((l+2*Cha_length-1)/2);

for j = 1:Trial_number
    
    c = channel(:,(j-1)*User_number+1:j*User_number).';
    g = good_waveform_multiple_simplified(D,c,l,mu1,mu2);

    down = floor((center-1)/D);
    up = floor((l+2*Cha_length-1-center)/D);
       for i = 1:User_number
           for p = 1:User_number
               h = conv(c(i,:),g(p,:));
               for q=-down:up
                   if ~(p == i && q == 0)
                       ISI(j,i) = ISI(j,i) + abs(h(q*D+center))^2;
                   end
               end
           end
       end
    
end
     

ASR = zeros(1,number);
I = mean(ISI);
Pn = N0*B;
for i = 1:number
    for j = 1:User_number
        ASR(i) = ASR(i) + log2(1+Es/(I(j)+Pn(i)));
    end
    ASR(i) = ASR(i)/D;
end
plot(Es_N0,ASR,'-go');hold on

%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
User_number = 5;
D = 5;
Ts = 1;
B = 10^9/(D*Ts);
ISI = zeros(Trial_number,User_number);
l = 100;
mu1 = 0.01;
mu2 = 0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
center = round((l+2*Cha_length-1)/2);

for j = 1:Trial_number
    
    c = channel(:,(j-1)*User_number+1:j*User_number).';
    g = good_waveform_multiple_simplified(D,c,l,mu1,mu2);

    down = floor((center-1)/D);
    up = floor((l+2*Cha_length-1-center)/D);
       for i = 1:User_number
           for p = 1:User_number
               h = conv(c(i,:),g(p,:));
               for q=-down:up
                   if ~(p == i && q == 0)
                       ISI(j,i) = ISI(j,i) + abs(h(q*D+center))^2;
                   end
               end
           end
       end
    
end
     

ASR = zeros(1,number);
I = mean(ISI);
Pn = N0*B;
for i = 1:number
    for j = 1:User_number
        ASR(i) = ASR(i) + log2(1+Es/(I(j)+Pn(i)));
    end
    ASR(i) = ASR(i)/D;
end
plot(Es_N0,ASR,'-g^');hold on
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
User_number = 7;
D = 5;
Ts = 1;
B = 10^9/(D*Ts);
ISI = zeros(Trial_number,User_number);
l = 100;
mu1 = 0.01;
mu2 = 0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
center = round((l+2*Cha_length-1)/2);

for j = 1:Trial_number
    
    c = channel(:,(j-1)*User_number+1:j*User_number).';
    g = good_waveform_multiple_simplified(D,c,l,mu1,mu2);

    down = floor((center-1)/D);
    up = floor((l+2*Cha_length-1-center)/D);
       for i = 1:User_number
           for p = 1:User_number
               h = conv(c(i,:),g(p,:));
               for q=-down:up
                   if ~(p == i && q == 0)
                       ISI(j,i) = ISI(j,i) + abs(h(q*D+center))^2;
                   end
               end
           end
       end
    
end
     

ASR = zeros(1,number);
I = mean(ISI);
Pn = N0*B;
for i = 1:number
    for j = 1:User_number
        ASR(i) = ASR(i) + log2(1+Es/(I(j)+Pn(i)));
    end
    ASR(i) = ASR(i)/D;
end
plot(Es_N0,ASR,'-gd');hold on
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
User_number = 3;
D = 5;
Ts = 1;
B = 10^9/(D*Ts);
ISI = zeros(Trial_number,User_number);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

   
for j = 1:Trial_number
    
    c = channel(:,(j-1)*User_number+1:j*User_number).';
  
    down = floor((Cha_length-1)/D);
    
    for i = 1:User_number
        for p = 1:User_number
            weight = sum(abs(c(p,:).^2));
            h = conv(c(i,:),conj(c(p,end:-1:1)))/weight;
            for q=-down:down
                if ~(p == i && q == 0)
                    ISI(j,i) = ISI(j,i) + abs(h(q*D+Cha_length))^2;
                end
            end
        end
    end
    
end
     

ASR = zeros(1,number);
I = mean(ISI);
Pn = N0*B;
for i = 1:number
    for j = 1:User_number
        ASR(i) = ASR(i) + log2(1+Es/(I(j)+Pn(i)));
    end
    ASR(i) = ASR(i)/D;
end

plot(Es_N0,ASR,':bo');hold on

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
User_number = 5;
D = 5;
Ts = 1;
B = 10^9/(D*Ts);
ISI = zeros(Trial_number,User_number);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

   
for j = 1:Trial_number
    
    c = channel(:,(j-1)*User_number+1:j*User_number).';
  
    down = floor((Cha_length-1)/D);
    
    for i = 1:User_number
        for p = 1:User_number
            weight = sum(abs(c(p,:).^2));
            h = conv(c(i,:),conj(c(p,end:-1:1)))/weight;
            for q=-down:down
                if ~(p == i && q == 0)
                    ISI(j,i) = ISI(j,i) + abs(h(q*D+Cha_length))^2;
                end
            end
        end
    end
    
end
     

ASR = zeros(1,number);
I = mean(ISI);
Pn = N0*B;
for i = 1:number
    for j = 1:User_number
        ASR(i) = ASR(i) + log2(1+Es/(I(j)+Pn(i)));
    end
    ASR(i) = ASR(i)/D;
end

plot(Es_N0,ASR,':b^');hold on
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
User_number = 7;
D = 5;
Ts = 1;
B = 10^9/(D*Ts);
ISI = zeros(Trial_number,User_number);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

   
for j = 1:Trial_number
    
    c = channel(:,(j-1)*User_number+1:j*User_number).';
  
    down = floor((Cha_length-1)/D);
    
    for i = 1:User_number
        for p = 1:User_number
            weight = sum(abs(c(p,:).^2));
            h = conv(c(i,:),conj(c(p,end:-1:1)))/weight;
            for q=-down:down
                if ~(p == i && q == 0)
                    ISI(j,i) = ISI(j,i) + abs(h(q*D+Cha_length))^2;
                end
            end
        end
    end
    
end
     

ASR = zeros(1,number);
I = mean(ISI);
Pn = N0*B;
for i = 1:number
    for j = 1:User_number
        ASR(i) = ASR(i) + log2(1+Es/(I(j)+Pn(i)));
    end
    ASR(i) = ASR(i)/D;
end
plot(Es_N0,ASR,':bd');hold on

%%
xlabel('Es/N0(dB)');
ylabel('Average Achievable Sum Rate(bps/Hz)');
legend('Optimal Waveform, D = 5, N = 3', 'Optimal Waveform, D = 5, N = 5','Optimal Waveform, D = 5, N = 7','Optimal Waveform+, D = 5, N = 3', 'Optimal Waveform+, D = 5, N = 5','Optimal Waveform+, D = 5, N = 7','Raw TR system, D = 5, N = 3','Raw TR system, D = 5, N = 5','Raw TR system, D = 5, N = 7')