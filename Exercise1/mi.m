clear all;
N=20;  %ȡչ��ʽ������Ϊ2N+1��
T=1; %����Ϊ1
fs=1/T;
N_sample=128;%Ϊ�˻����Σ�����ÿ�����ڵĲ�������
dt=1/N_sample;%ʱ��ֱ���
t=0:dt:10*T-dt;%ȡ10������
n=-N:N;
Fn=sinc(n/2).*exp(-j*n*pi/2);%����Ҷϵ��
Fn(N+1)=0;%��n=0ʱ������Fn��Fn=0��
ft=zeros(1,length(t));
for m=-N:N;
    ft=ft+Fn(m+N+1)*exp(j*2*pi*m*fs*t)
end
plot(t,ft);