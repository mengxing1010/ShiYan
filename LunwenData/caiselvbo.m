%彩色图像空间滤波
clc;
clear all;
close all;
disp('彩色图像空间滤波开始.......');
%%
%提取3个分量图像
f=imread('D:\MatlabFiles\TrainDatas\chengzi.jpg');%加载彩色图像
%显示原图像
figure;imshow(f);title('彩色原图像');
fr=f(:,:,1); %提取R通道分量图像
fg=f(:,:,2); %提取G通道分量图像 ? ? ?
fb=f(:,:,3); %提取B通道分量图像
%显示三通道图像
figure;
subplot(2,2,1);imshow(fr);title('R');
subplot(2,2,2);imshow(fg);title('G');
subplot(2,2,3);imshow(fb);title('B');
%%
%分别过滤每个分量图像
w = fspecial('average', 3);
fr_filter=imfilter(fr,w,'replicate');  %平滑红色分量图像;
fg_filter=imfilter(fg,w,'replicate');  %平滑绿色分量图像;
fb_filter=imfilter(fb,w,'replicate');  %平滑蓝色分量图像;
%显示滤波后的三通道图像
figure;
subplot(2,2,1);imshow(fr_filter);title('R滤波后');
subplot(2,2,2);imshow(fg_filter);title('G滤波后');
subplot(2,2,3);imshow(fb_filter);title('B滤波后');

%%
%重建滤波后的RGB图像
ff=cat(3,fr_filter,fg_filter,fb_filter); %构造多维数组，即合并3分量图像为一副彩色图像
%显示重建后的图像
figure;imshow(ff);title('重建后');
%%
%使用与单色图像相同的语法来执行RGB 图像的线性滤波，可以把前三步合并为一步：
gg = imfilter(f, w, 'replicate');
figure;imshow(gg);title('步骤合并的滤波结果');