A=imread('apple.jpg');
B=rgb2gray(A);
figure(1);
subplot(3,4,1);
imshow(A);title('ԭʼͼƬ')
H=imnoise(B,'gaussian',0.02);
subplot(3,4,2);
imshow(H);title('��˹ͼƬ')
Q=imnoise(B,'salt & pepper',0.02);
subplot(3,4,3);
imshow(Q);title('��������')
%%%��������ƽ��������ֵ�˲���%%%
M=fspecial('average',3);
E=imfilter(H,M);F=imfilter(Q,M);
subplot(3,4,5);
imshow(E);title('�Ը�˹��ֵ�˲�')
subplot(3,4,6);
imshow(F);title('�Խ��ξ�ֵ�˲�')
G=medfilt2(H,[3,3]);J=medfilt2(Q,[3,3]);
subplot(3,4,7);imshow(G);title('�Ը�˹��ֵ�˲�')
subplot(3,4,8);imshow(J);title('�Խ�����ֵ�˲�')

