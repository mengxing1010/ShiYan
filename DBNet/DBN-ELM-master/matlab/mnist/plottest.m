clc;
clear all;
close all;

%�������ʼ���͵�����������׼ȷ�ʱ仯
load mlelmdata
load dbnelmplotresult

index = [2,4,6,8,10];
number = [0,10,20,30,40,50];
% test_accuracy
% train_accuracy
% test_accuracy_num(index,1)
% train_accuracy_num(index,1)

test = [test_accuracy;test_accuracy_num(index,1)]
train = [train_accuracy;train_accuracy_num(index,1)]

plot(number, train, '--r.', number, test, '--b.')
legend('ѵ��׼ȷ������', '����׼ȷ������', 4)
xlabel('The number of iterations')
ylabel('accuracy')
axis([0,50,0.8,1]) % axis([xmin,xmax,ymin,ymax])������������Զ�x��y������������޻��Ʒ�Χһ��������




































































