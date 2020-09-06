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
 
I1=cat(3,R,G,B);  % �Բ�ɫͼ��R,G��B����ͨ���ֱ����3��3ģ�����ֵ�˲� cat�������������������������
 
R=filter2(fspecial('average',3),R)/255;
G=filter2(fspecial('average',3),G)/255;
B=filter2(fspecial('average',3),B)/255;
I2= cat(3,R,G,B);  %�Բ�ɫͼ��R,G��B����ͨ���ֱ����3��3ģ��ľ�ֵ�˲�
subplot(1,3,1);imshow(I);
title('ԭͼ')
 
subplot(1,3,2);
imshow(I1);
title('��ֵ�˲�')
 
subplot(1,3,3);imshow(I2);
title('��ֵ�˲�')