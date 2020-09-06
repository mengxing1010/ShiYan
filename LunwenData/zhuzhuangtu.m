


data = [2215, 222; 2150, 280;1950,264;2185,275];
b = bar(data);

ch = get(b,'children');

set(gca,'XTickLabel',{'苹果','柠檬','草莓','橘子'},'fontsize',20)
%set(gca,'XTickLabel',{'shuoguo','zhonglei'})

legend('Fruits-360数据集','人工数据集');

ylabel('样本容量(单位:张)','fontsize',20);
