clear all;
N=20;  %取展开式的项数为2N+1项
T=1; %周期为1
fs=1/T;
N_sample=128;%为了画波形，设置每个周期的采样点数
dt=1/N_sample;%时间分辨率
t=0:dt:10*T-dt;%取10个周期
n=-N:N;
Fn=sinc(n/2).*exp(-j*n*pi/2);%求傅里叶系数
Fn(N+1)=0;%荡n=0时，代入Fn得Fn=0，
ft=zeros(1,length(t));
for m=-N:N;
    ft=ft+Fn(m+N+1)*exp(j*2*pi*m*fs*t)
end
plot(t,ft);