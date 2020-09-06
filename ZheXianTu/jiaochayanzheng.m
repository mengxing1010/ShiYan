x=0:0.1:1;%x轴上的数据，第一个值代表数据开始，第二个值代表间隔，第三个值代表终止
 a=[0.4,0.68,0.52,0.62,0.73,0.93,0.82,0.85,0.78,0.8,0.77]; %a数据y值
 b=[0.51,0.73,0.67,0.85,0.88,0.92,0.81,0.79,0.8,0.82,0.73]; %b数据y值
 c=[0.33,0.44,0.65,0.56,0.67,0.76,0.71,0.69,0.7,0.68,0.6];
 plot(x,a,'-*b',x,b,'-or',x,c,'-p'); %线性，颜色，标记
axis([0,1,0.2,1.0])  %确定x轴与y轴框图大小
set(gca,'XTick',[0:0.1:1]) %x轴范围1-6，间隔1
set(gca,'YTick',[0.2:0.05:1.0]) %y轴范围0-700，间隔100
legend('1组','2组','3组');   %右上角标注
xlabel('参数权值','fontsize',12)  %x轴坐标描述
ylabel('正确率','fontsize',12) %y轴坐标描述
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
