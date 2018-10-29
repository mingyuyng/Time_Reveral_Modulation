channel_number = 100;
User_number = 5;
D = 5;
Ts = 1;
Es = 1;

Es_N0 = 10:2:50;
es_n0 = 10.^(Es_N0/10);
N0 = Es./es_n0;
B = 1000;
load channel

s = size(channel);
Cha_length = s(1);
Equ_length = 50;
k0 = Equ_length/2;

trial_number = 30;

ISI = zeros(trial_number, User_number);
h = zeros(User_number,Cha_length+Equ_length);

for j = 1:trial_number
    
    c = channel(:,(j-1)*User_number+1:j*User_number).';
    
    for i = 1:User_number
        hh = conv(c(i,:),conj(c(i,end:-1:1)));
        eq = MMSE_n(D,Equ_length,Cha_length,hh,k0,true);
        h(i,:) = conv(c(i,:),eq);
    end
   
    down = floor((Cha_length+k0-1)/D);
    up = floor((Cha_length+Equ_length-1-k0)/D);
       for i = 1:User_number
           for p = 1:User_number
               h1 = conv(h(i,:),c(p,:));
               for q=-down:up
                   if ~(p == i && q == 0)
                       ISI(j,i) = ISI(j,i) + abs(h1(q*D+Cha_length+k0))^2;
                   end
               end
           end
       end
    
end
     

l1 = length(N0);
SINR = zeros(1,l1);
I = mean(ISI);
Pn = N0*B/D;
for i = 1:l1
    for j = 1:User_number
        SINR(i) = SINR(i) + log2(1+Es/(I(j)+Pn(i)));
    end
    
    SINR(i) = SINR(i)/D;
end
plot(Es_N0,SINR,'-ro');hold on

%%
User_number = 10;
D = 1;

ISI = zeros(trial_number, User_number);
h = zeros(User_number,Cha_length+Equ_length);

for j = 1:trial_number
    
    c = channel(:,(j-1)*User_number+1:j*User_number).';
    
    for i = 1:User_number
        hh = conv(c(i,:),conj(c(i,end:-1:1)));
        eq = MMSE_n(D,Equ_length,Cha_length,hh,k0,true);
        h(i,:) = conv(c(i,:),eq);
    end
   
    down = floor((Cha_length+k0-1)/D);
    up = floor((Cha_length+Equ_length-1-k0)/D);
       for i = 1:User_number
           for p = 1:User_number
               h1 = conv(h(i,:),c(p,:));
               for q=-down:up
                   if ~(p == i && q == 0)
                       ISI(j,i) = ISI(j,i) + abs(h1(q*D+Cha_length+k0))^2;
                   end
               end
           end
       end
    
end
     

l1 = length(N0);
SINR = zeros(1,l1);
I = mean(ISI);
Pn = N0*B/D;
for i = 1:l1
    for j = 1:User_number
        SINR(i) = SINR(i) + log2(1+Es/(I(j)+Pn(i)));
    end
    
    SINR(i) = SINR(i)/D;
end
plot(Es_N0,SINR,'-r^');hold on

%%

User_number = 15;
D = 1;

ISI = zeros(trial_number, User_number);
h = zeros(User_number,Cha_length+Equ_length);

for j = 1:trial_number
    
    c = channel(:,(j-1)*User_number+1:j*User_number).';
    
    for i = 1:User_number
        hh = conv(c(i,:),conj(c(i,end:-1:1)));
        eq = MMSE_n(D,Equ_length,Cha_length,hh,k0,true);
        h(i,:) = conv(c(i,:),eq);
    end
   
    down = floor((Cha_length+k0-1)/D);
    up = floor((Cha_length+Equ_length-1-k0)/D);
       for i = 1:User_number
           for p = 1:User_number
               h1 = conv(h(i,:),c(p,:));
               for q=-down:up
                   if ~(p == i && q == 0)
                       ISI(j,i) = ISI(j,i) + abs(h1(q*D+Cha_length+k0))^2;
                   end
               end
           end
       end
    
end
     

l1 = length(N0);
SINR = zeros(1,l1);
I = mean(ISI);
Pn = N0*B/D;
for i = 1:l1
    for j = 1:User_number
        SINR(i) = SINR(i) + log2(1+Es/(I(j)+Pn(i)));
    end
    
    SINR(i) = SINR(i)/D;
end
plot(Es_N0,SINR,'-rd');hold on