
% 传输1000000个码，随机+1/-1
N = 1000000;
for i=1:N
    if rand <.5
        s(i)=-1;
    else
        s(i)=1;
    end
end

% 产生白噪声
Variance = 1;
b=randn(1,N); 

% enery per bit to noise spectral density ratio
EbNo=[-3:1:10];

% 针对上条指令有14种情况
for j = 1:14
%加入白噪声   
    sigma(j) = power(10,(-EbNo(j)/20))/ sqrt (2);
    for i = 1:N       
        n(i)=sigma(j)*b(i);
        y(i)=s(i)+n(i);
    end
    
% 解码
   Nombreerreur(j) = 0;
    for i=1:N
        if y(i) > 0
            Demo(i) = 1;
        else
            Demo(i) = -1;     
        end
        
% 统计误码数和误码率                
        if Demo(i) ~= s(i)
            Nombreerreur(j) = Nombreerreur(j) + 1;
        end
    end     
    Tauxderreur(j) = Nombreerreur(j) / N;
    TauxderreurTheorique(j) = erfc(sqrt(power(10,EbNo(j)/10)))/2;   
end

%比较实际误码率和理论误码率曲线 
figure  
semilogy(EbNo,Tauxderreur,EbNo,TauxderreurTheorique);