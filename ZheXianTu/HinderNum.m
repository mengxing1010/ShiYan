x=1:10:200;%x���ϵ����ݣ���һ��ֵ�������ݿ�ʼ���ڶ���ֵ���������������ֵ������ֹ
 a=[0.75,0.78,0.81,0.72,0.74,0.77,0.80,0.82,0.794,0.832,0.77,0.79,0.82,0.75,0.73,0.76,0.80,0.82,0.79,0.84]; %a����yֵ
 b=[0.835,0.824,0.865,0.848,0.839,0.847,0.821,0.79,0.82,0.842,0.857,0.87,0.83,0.86,0.8,0.84,0.85,0.86,0.88,0.873]; %b����yֵ
 c=[0.943,0.934,0.955,0.946,0.967,0.956,0.962,0.958,0.945,0.978,0.943,0.957,0.962,0.968,0.96,0.956,0.966,0.952,0.973,0.954]
 d=[0.839,0.816,0.858,0.867,0.88,0.875,0.902,0.895,0.884,0.866,0.864,0.87,0.86,0.904,0.876,0.883,0.896,0.883,0.862,0.879]
 e=[0.708,0.822,0.814,0.799,0.813,0.82,0.84,0.852,0.839,0.813,0.836,0.852,0.873,0.854,0.832,0.829,0.803,0.837,0.828,0.855	]
 plot(x,a,'-d',x,b,'-or',x,c,'-s',x,d,'-o',x,e,'-*'); %���ԣ���ɫ�����
axis([0,220,0.6,1.0])  %ȷ��x����y���ͼ��С
set(gca,'XTick',[0:10:220]) %x�᷶Χ1-6�����1
set(gca,'YTick',[0.6:0.05:1.0]) %y�᷶Χ0-700�����100
legend('2��','3��','4��','5��','6��');   %���ϽǱ�ע
xlabel('��ɫ��ȡDBN�����������','fontsize',12)  %x����������
ylabel('׼ȷ��','fontsize',12) %y����������