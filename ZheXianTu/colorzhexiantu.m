x=1:10:200;%x���ϵ����ݣ���һ��ֵ�������ݿ�ʼ���ڶ���ֵ���������������ֵ������ֹ
 a=[0.75,0.81,0.79,0.77,0.818,0.784,0.802,0.813,0.78,0.82,0.77,0.77,0.79,0.78,0.82,0.797,0.803,0.82,0.779,0.782]; %a����yֵ
 b=[0.86,0.853,0.847,0.865,0.852,0.86,0.872,0.859,0.847,0.852,0.865,0.871,0.864,0.83,0.86,0.845,0.85,0.86,0.87,0.88]; %b����yֵ
 c=[0.93,0.924,0.937,0.946,0.942,0.95,0.942,0.951,0.945,0.948,0.953,0.947,0.936,0.95,0.946,0.956,0.96,0.942,0.953,0.94]
 d=[0.9,0.89,0.89,0.917,0.89,0.91,0.902,0.925,0.91,0.896,0.894,0.906,0.91,0.9,0.911,0.893,0.896,0.912,0.892,0.919]
 e=[0.82,0.805,0.81,0.809,0.823,0.83,0.82,0.828,0.819,0.803,0.826,0.842,0.83,0.845,0.832,0.83,0.843,0.85,0.84,0.837]
 plot(x,a,'-*b',x,b,'-or',x,c,'-d',x,d,'-p',x,e,'-+'); %���ԣ���ɫ�����
axis([0,220,0.6,1.0])  %ȷ��x����y���ͼ��С
set(gca,'XTick',[0:10:220]) %x�᷶Χ1-6�����1
set(gca,'YTick',[0.6:0.05:1.0]) %y�᷶Χ0-700�����100
legend('2��','3��','4��','5��','6��');   %���ϽǱ�ע
xlabel('��ɫ��ȡDBN�����������','fontsize',12)  %x����������
ylabel('׼ȷ��','fontsize',12) %y����������
box off  
% box off
% ax2 = axes('Position',get(gca,'Position'),...
%            'XAxisLocation','top',...
%            'YAxisLocation','right',...
%            'Color','none',...
%            'XColor','k','YColor','k');
% set(ax2,'YTick', []);
% set(ax2,'XTick', []);
box on