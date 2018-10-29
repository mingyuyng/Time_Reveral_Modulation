
function [pdp,h] = channel(option, channel_number)

if option == 0
    Lmean = 3;
    lamda = 0.047;
    lamda1 = 1.54;
    lamda2 = 0.15;
    beta = 0.095;
    TT = 22.61;
    gamma0 = 12.53;
    m0 = 0.67;
    m1 = 0.28;
    T_start = 0;
elseif option == 1
    Lmean = 3.5;
    lamda = 0.12;
    lamda1 = 1.77;
    lamda2 = 0.15;
    beta = 0.045;
    TT = 26.27;
    gamma0 = 17.50;
    m0 = 0.69;
    m1 = 0.32;
    T_start = -log(rand)/lamda;
else
    error('No such option...');
end

h = [];
%generate the number of clusters
for channel = 1:channel_number
    L = max(1, poissrnd(Lmean));

    %generate the cluster arriving time

    %X = [0, -log(rand(1,L))/lamda];

    T_gap = [T_start, exprnd(1/lamda,1,L)];

    TC = zeros(1,L);

    for i = 1:L
        TC(i) = sum(T_gap(1:i));
    end

%generate the ray arriving time for different cluster

    TR = [];
    T_val = [];
    Tr_length = 10*gamma0;
    for i = 1:L
    
        Tr = 0;
        path_index = 1;
        while (Tr < Tr_length)
            t_val = TC(i)+Tr;
            random = rand;
            T_val(i,path_index) = Tr;
            TR(i,path_index) = t_val;
        
            Tr = Tr -beta*log(random)/lamda1 - (1-beta)*log(random)/lamda2;
        
            path_index = path_index + 1;
        end
    end


    %generate the mean cluster energy

    Mcluster = 2.75*randn(1,L);
    Pcluster = 10*log10(exp(-1*TC/TT))+Mcluster; % total cluster power
    Omega = 10.^(0.1*Pcluster);

    s = size(T_val);
    %delay profile

    PDP = zeros(L,s(2));

    for i = 1:L
    
        PDP(i,:) = Omega(i)*exp(-T_val(i,:)/gamma0);
   
    end

    PDP = PDP/(gamma0*((1-beta)*lamda1+beta*lamda2+1));

    TR = round(TR);

    l = max(max(TR));
    
    amp = zeros(s(1),s(2));


    %small-scale amplitude
    
    m = lognrnd(m0, m1,L,s(2));
    for i = 1:L             
        
        for j = 1:s(2)
            amp(i,j) = (gamrnd(m(i,j), PDP(i,j)/m(i,j))).^(1/2);
        end
    end


    

    CIR = zeros(1,l+1);
    pdp = zeros(1,l+1);
    temp = -1;
    for i = 1:L
        for j = 1:s(2)
            if((TR(i,j) ~= 0) || j==1)
                if(TR(i,j)==temp)
                    CIR(TR(i,j)+1) = (CIR(TR(i,j)+1) + amp(i,j))/2;
                    pdp(TR(i,j)+1) = (pdp(TR(i,j)+1) + PDP(i,j))/2;
                else
                    CIR(TR(i,j)+1) = CIR(TR(i,j)+1) + amp(i,j);
                    pdp(TR(i,j)+1) = pdp(TR(i,j)+1) + PDP(i,j);
                end
                temp = TR(i,j);
            end
        end
    
    
    end

%figure;stem(CIR)

    h_ct_len = length(CIR);

    phi = rand(1,h_ct_len).*(2*pi);
    
    CIR = CIR .* exp(phi .* 1i);

    for k = 1:l+1
        h(channel,k) = CIR(k);
    end
    
    
end

end


