


data = [2215, 222; 2150, 280;1950,264;2185,275];
b = bar(data);

ch = get(b,'children');

set(gca,'XTickLabel',{'ƻ��','����','��ݮ','����'},'fontsize',20)
%set(gca,'XTickLabel',{'shuoguo','zhonglei'})

legend('Fruits-360���ݼ�','�˹����ݼ�');

ylabel('��������(��λ:��)','fontsize',20);
