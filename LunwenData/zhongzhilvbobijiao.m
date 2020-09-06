clear all;
clc;
I=imread('lemon.jpg');
OutImg=I;
R=I(:,:,1);
G=I(:,:,2);
B=I(:,:,3);
 
R=medfilt2(R,[3,3]);
G=medfilt2(G,[3,3]);
B=medfilt2(B,[3,3]);
 
I1=cat(3,R,G,B);  % 对彩色图像R,G，B三个通道分别进行3×3模板的中值滤波 cat函数用于连接两个矩阵或数组
 
R=filter2(fspecial('average',3),R)/255;
G=filter2(fspecial('average',3),G)/255;
B=filter2(fspecial('average',3),B)/255;
I2= cat(3,R,G,B);  %对彩色图像R,G，B三个通道分别进行3×3模板的均值滤波
subplot(1,3,1);imshow(I);
title('原图')
 
subplot(1,3,2);
imshow(I1);
title('中值滤波')
 
subplot(1,3,3);imshow(I2);
title('均值滤波')