xlabel('Top n');
ylabel('avrIoU');
legend(legend_names, 'Location', 'SouthEast');



%��߿̶ȣ����ÿ̶��Լ���ʾ
set(gca, 'XTick', [1,3,5,10,20]);
set(gca,'XTickLabel',{'1','3','5','10','All'});
set(gca,'yminortick','on')     %y����ʾС�̶�



%�ұ߿̶�

%���õڶ��׿̶�λ�ã������ҵĴ���=��=ûϸ�о�

ax1=gca ;
ax2=axes('position',get(ax1,'position'),'yaxislocation','right','color','none');
axis([0 20 40 90]) %���õڶ��׿̶ȵķ�Χ��X����һ�׿̶�һ��
set(gca, 'XTick', [1,3,5,10,20]);
set(gca,'XTickLabel',{'1','3','5','10','All'});
set(gca,'yminortick','on') 