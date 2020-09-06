%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% All rights reserved by Krishna Pillai, http://www.dsplog.com
% The file may not be re-distributed without explicit authorization
% from Krishna Pillai.
% Checked for proper operation with Octave Version 3.0.0
% Author        : Krishna Pillai
% Email         : krishna@dsplog.com
% Version       : 1.0
% Date          : 8 August 2008
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Script for computing the BER for BPSK modulation in a
% Rayleigh fading channel

clear
N = 10^6 % number of bits or symbols

% Transmitter
ip = rand(1,N)>0.5; % generating 0,1 with equal probability
s = 2*ip-1; % BPSK modulation 0 -> -1; 1 -> 0 

 
Eb_N0_dB = [-3:35]; % multiple Eb/N0 values

for ii = 1:length(Eb_N0_dB)
   
   n = 1/sqrt(2)*[randn(1,N) + j*randn(1,N)]; % white gaussian noise, 0dB variance 
   h = 1/sqrt(2)*[randn(1,N) + j*randn(1,N)]; % Rayleigh channel
   %所用信噪比计算公式（10log（S/N））
   
   % Channel and noise Noise addition
   y = h.*s + 10^(-Eb_N0_dB(ii)/20)*n; 
%根据信噪比加入噪声，缩放过程在电压上完成，所以除20
   % equalization
   yHat = y./h;

   % receiver - hard decision decoding
   ipHat = real(yHat)>0;
    nexts = 2*ipHat-1; % BPSK modulation 0 -> -1; 1 -> 0 

   % counting the errors
   %nErr(ii) = size(find([ip- ipHat]),2);
   %find(X)函数，如果X是一个行向量，则ind是一个行向量；否则，ind是一个列向量。 
   %size()函数，size(A,n)
    %n=1,2,3...
%  size将返回矩阵的行数或列数。
%  r=size(A,1)该语句返回的是矩阵A的行数，
%  c=size(A,2)该语句返回的是矩阵A的列数。
  nextn = 1/sqrt(2)*[randn(1,N) + j*randn(1,N)]; % white gaussian noise, 0dB variance 
   nexth = 1/sqrt(2)*[randn(1,N) + j*randn(1,N)]; % Rayleigh channel
    nexty = nexth.*nexts+ 10^(-Eb_N0_dB(ii)/20)*nextn; 
    nextyHat = nexty./nexth;
    nextipHat = real(nextyHat)>0;
     nErr(ii) = size(find([ip- nextipHat]),2);


end

simBer = nErr/N
theoryBerAWGN = 0.5*erfc(sqrt(10.^(Eb_N0_dB/10))); % theoretical ber
EbN0Lin = 10.^(Eb_N0_dB/10);
theoryBer = 0.5.*(1-sqrt(EbN0Lin./(EbN0Lin+1)));%Error probability理论值
testBer = 2*theoryBer.*(1 -theoryBer)
% plot
close all
figure
%semilogy(Eb_N0_dB,theoryBerAWGN,'cd-','LineWidth',2);
hold on
semilogy(Eb_N0_dB,testBer,'bp-','LineWidth',2);
semilogy(Eb_N0_dB,simBer,'mx-','LineWidth',2);
axis([-3 35 10^-5 0.5])
grid on
%legend('AWGN-Theory','Rayleigh-Theory', 'Rayleigh-Simulation');
xlabel('Eb/No, dB');
ylabel('Bit Error Rate');
title('BER for BPSK modulation in Rayleigh channel');

