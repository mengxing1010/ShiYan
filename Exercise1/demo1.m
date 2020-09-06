figure(1);
l=imread('Lena.tif');
subplot(3,3,1);
imshow(l);
title('原始图像')
B=rgb2gray(l);
subplot(3,3,2);
imshow(B);
title('灰度化')

subplot(3,3,3)
imhist(B);
axis tight
title('直方图')
%%%用imadjust调整灰度值【0，1】%%%
C=imadjust(B,[30/255;200/255],[0,1]);
subplot(3,3,4);
imshow(C);
title('调整之后的图像')
subplot(3,3,5);
imhist(C);
title('调整后的直方图')
%%%对原始图像进行分段线性变换处理%%%
A=histeq(B);
subplot(3,3,7);
imshow(A);
title('均衡化后图像')
subplot(3,3,8);
imhist(A);
axis tight;
title('均衡化后的直方图')