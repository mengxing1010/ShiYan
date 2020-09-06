
% ����1000000���룬���+1/-1
N = 1000000;
for i=1:N
    if rand <.5
        s(i)=-1;
    else
        s(i)=1;
    end
end

% ����������
Variance = 1;
b=randn(1,N); 

% enery per bit to noise spectral density ratio
EbNo=[-3:1:10];

% �������ָ����14�����
for j = 1:14
%���������   
    sigma(j) = power(10,(-EbNo(j)/20))/ sqrt (2);
    for i = 1:N       
        n(i)=sigma(j)*b(i);
        y(i)=s(i)+n(i);
    end
    
% ����
   Nombreerreur(j) = 0;
    for i=1:N
        if y(i) > 0
            Demo(i) = 1;
        else
            Demo(i) = -1;     
        end
        
% ͳ����������������                
        if Demo(i) ~= s(i)
            Nombreerreur(j) = Nombreerreur(j) + 1;
        end
    end     
    Tauxderreur(j) = Nombreerreur(j) / N;
    TauxderreurTheorique(j) = erfc(sqrt(power(10,EbNo(j)/10)))/2;   
end

%�Ƚ�ʵ�������ʺ��������������� 
figure  
semilogy(EbNo,Tauxderreur,EbNo,TauxderreurTheorique);