clear;
clf;
t=0:pi/10:40*pi;
Carrier=sin(t);
Mod_Sig=sin(t/20);
Dsb_am=Carrier.*(1+Mod_Sig);
plot(t,Carrier,t,Mod_Sig,t,Dsb_am);
title('Plot of carrier modulated by sinewave (dsb-am)');
xlabel('time');
ylabel('voltage');
grid on;
legend('carrier','baseband','modulated signal')