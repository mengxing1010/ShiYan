data = [78.41,73.66 ,77.25,81.02;...
    79.41,83.82,82.85,80.25;...
    82.36,84.45,82.28,81.25;...
    80.17,83.86,81.83,85.28;...
    91.50,90.40,92.80,88.70];
b = bar(data);

ch = get(b,'children');

set(gca,'XTickLabel',{'SVM','BP','LeNet-5','单路DBN','双路DBN'},'Fontsize',16)

legend('Apple','Strawberry','Lemon','Orange','FontName','Times New Roman');

ylabel('识别准确率(%)');
%xlabel('不同算法')