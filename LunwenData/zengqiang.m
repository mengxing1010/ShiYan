clc;
clear;
RGB=imread('D:\MatlabFiles\TrainDatas\chengzi.jpg');
R=RGB(:,:,1);
G=RGB(:,:,2);
B=RGB(:,:,3);

subplot(4,2,1),imshow(RGB);title("原始彩色图像");
subplot(4,2,3),imshow(R);title("原始彩色图像红色分量");
subplot(4,2,4),imhist(R);title("原始彩色图像红色分量直方图");
subplot(4,2,5),imshow(G);title("原始彩色图像蓝色分量");
subplot(4,2,6),imhist(R);title("原始彩色图像蓝色分量直方图");
subplot(4,2,7),imshow(B);title("原始彩色图像绿色分量");
subplot(4,2,8),imhist(B);title("原始彩色图像绿色分量直方图");
%%%对各分量直方图均衡化，得到个分量的均衡化图像

r=histeq(R);
g=histeq(G);
b=histeq(B);
figure,
subplot(3,2,1),imshow(r);title("红色均衡化");
subplot(3,2,2),imhist(r);title("红色均衡化直方图");

subplot(3,2,3),imshow(g);title("蓝色均衡化");
subplot(3,2,4),imhist(g);title("蓝色均衡化直方图");

subplot(3,2,5),imshow(b);title("绿色均衡化");
subplot(3,2,6),imhist(b);title("绿色均衡化直方图");
figure,
newimg=cat(3,r,g,b);
imshow(newimg,[]);
title("均衡化后分量图像还原")



