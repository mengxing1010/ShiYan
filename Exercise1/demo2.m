A=imread('apple.jpg');
B=rgb2gray(A);
figure(1);
subplot(3,4,1);
imshow(A);title('原始图片')
H=imnoise(B,'gaussian',0.02);
subplot(3,4,2);
imshow(H);title('高斯图片')
Q=imnoise(B,'salt & pepper',0.02);
subplot(3,4,3);
imshow(Q);title('椒盐噪声')
%%%采用邻域平均法和中值滤波法%%%
M=fspecial('average',3);
E=imfilter(H,M);F=imfilter(Q,M);
subplot(3,4,5);
imshow(E);title('对高斯均值滤波')
subplot(3,4,6);
imshow(F);title('对椒盐均值滤波')
G=medfilt2(H,[3,3]);J=medfilt2(Q,[3,3]);
subplot(3,4,7);imshow(G);title('对高斯中值滤波')
subplot(3,4,8);imshow(J);title('对椒盐中值滤波')

