clc;
clear;
RGB=imread('D:\MatlabFiles\TrainDatas\chengzi.jpg');
R=RGB(:,:,1);
G=RGB(:,:,2);
B=RGB(:,:,3);

subplot(4,2,1),imshow(RGB);title("ԭʼ��ɫͼ��");
subplot(4,2,3),imshow(R);title("ԭʼ��ɫͼ���ɫ����");
subplot(4,2,4),imhist(R);title("ԭʼ��ɫͼ���ɫ����ֱ��ͼ");
subplot(4,2,5),imshow(G);title("ԭʼ��ɫͼ����ɫ����");
subplot(4,2,6),imhist(R);title("ԭʼ��ɫͼ����ɫ����ֱ��ͼ");
subplot(4,2,7),imshow(B);title("ԭʼ��ɫͼ����ɫ����");
subplot(4,2,8),imhist(B);title("ԭʼ��ɫͼ����ɫ����ֱ��ͼ");
%%%�Ը�����ֱ��ͼ���⻯���õ��������ľ��⻯ͼ��

r=histeq(R);
g=histeq(G);
b=histeq(B);
figure,
subplot(3,2,1),imshow(r);title("��ɫ���⻯");
subplot(3,2,2),imhist(r);title("��ɫ���⻯ֱ��ͼ");

subplot(3,2,3),imshow(g);title("��ɫ���⻯");
subplot(3,2,4),imhist(g);title("��ɫ���⻯ֱ��ͼ");

subplot(3,2,5),imshow(b);title("��ɫ���⻯");
subplot(3,2,6),imhist(b);title("��ɫ���⻯ֱ��ͼ");
figure,
newimg=cat(3,r,g,b);
imshow(newimg,[]);
title("���⻯�����ͼ��ԭ")



