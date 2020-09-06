I=imread('Lena.jpg');%读入图像


figure;%打开新窗口
[M,N]=size(I);%计算图像大小
[counts,x]=imhist(I,32);%计算有32个小区间的灰度直方图
counts=counts/M/N;%计算归一化灰度直方图各区间的值
stem(x,counts);%绘制归一化直方图