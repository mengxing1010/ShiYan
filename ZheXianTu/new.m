xlabel('Top n');
ylabel('avrIoU');
legend(legend_names, 'Location', 'SouthEast');



%左边刻度，设置刻度以及显示
set(gca, 'XTick', [1,3,5,10,20]);
set(gca,'XTickLabel',{'1','3','5','10','All'});
set(gca,'yminortick','on')     %y轴显示小刻度



%右边刻度

%设置第二套刻度位置，网上找的代码=。=没细研究

ax1=gca ;
ax2=axes('position',get(ax1,'position'),'yaxislocation','right','color','none');
axis([0 20 40 90]) %设置第二套刻度的范围，X与上一套刻度一样
set(gca, 'XTick', [1,3,5,10,20]);
set(gca,'XTickLabel',{'1','3','5','10','All'});
set(gca,'yminortick','on') 