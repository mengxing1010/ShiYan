I=imread('D:\MatlabFiles\TrainDatas\caomei3.jpg');%读取当前路径下的图片
subplot(1,2,1),imshow(I);
title('原始图像')

grid on;%显示网格线
axis on; %显示坐标系
level=graythresh(I); %确定灰度阈值
BW=im2bw(I,level);
subplot(1,2,2),imshow(BW);
title('Otsu 法阈值分割图像')
%axis([50,250,50,200]);
grid on; %显示网格线
axis on;%显示坐标系

