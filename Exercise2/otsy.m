I=imread('D:\MatlabFiles\TrainDatas\caomei3.jpg');%��ȡ��ǰ·���µ�ͼƬ
subplot(1,2,1),imshow(I);
title('ԭʼͼ��')

grid on;%��ʾ������
axis on; %��ʾ����ϵ
level=graythresh(I); %ȷ���Ҷ���ֵ
BW=im2bw(I,level);
subplot(1,2,2),imshow(BW);
title('Otsu ����ֵ�ָ�ͼ��')
%axis([50,250,50,200]);
grid on; %��ʾ������
axis on;%��ʾ����ϵ

