%��ɫͼ��ռ��˲�
clc;
clear all;
close all;
disp('��ɫͼ��ռ��˲���ʼ.......');
%%
%��ȡ3������ͼ��
f=imread('D:\MatlabFiles\TrainDatas\chengzi.jpg');%���ز�ɫͼ��
%��ʾԭͼ��
figure;imshow(f);title('��ɫԭͼ��');
fr=f(:,:,1); %��ȡRͨ������ͼ��
fg=f(:,:,2); %��ȡGͨ������ͼ�� ? ? ?
fb=f(:,:,3); %��ȡBͨ������ͼ��
%��ʾ��ͨ��ͼ��
figure;
subplot(2,2,1);imshow(fr);title('R');
subplot(2,2,2);imshow(fg);title('G');
subplot(2,2,3);imshow(fb);title('B');
%%
%�ֱ����ÿ������ͼ��
w = fspecial('average', 3);
fr_filter=imfilter(fr,w,'replicate');  %ƽ����ɫ����ͼ��;
fg_filter=imfilter(fg,w,'replicate');  %ƽ����ɫ����ͼ��;
fb_filter=imfilter(fb,w,'replicate');  %ƽ����ɫ����ͼ��;
%��ʾ�˲������ͨ��ͼ��
figure;
subplot(2,2,1);imshow(fr_filter);title('R�˲���');
subplot(2,2,2);imshow(fg_filter);title('G�˲���');
subplot(2,2,3);imshow(fb_filter);title('B�˲���');

%%
%�ؽ��˲����RGBͼ��
ff=cat(3,fr_filter,fg_filter,fb_filter); %�����ά���飬���ϲ�3����ͼ��Ϊһ����ɫͼ��
%��ʾ�ؽ����ͼ��
figure;imshow(ff);title('�ؽ���');
%%
%ʹ���뵥ɫͼ����ͬ���﷨��ִ��RGB ͼ��������˲������԰�ǰ�����ϲ�Ϊһ����
gg = imfilter(f, w, 'replicate');
figure;imshow(gg);title('����ϲ����˲����');