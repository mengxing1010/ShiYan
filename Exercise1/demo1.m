figure(1);
l=imread('Lena.tif');
subplot(3,3,1);
imshow(l);
title('ԭʼͼ��')
B=rgb2gray(l);
subplot(3,3,2);
imshow(B);
title('�ҶȻ�')

subplot(3,3,3)
imhist(B);
axis tight
title('ֱ��ͼ')
%%%��imadjust�����Ҷ�ֵ��0��1��%%%
C=imadjust(B,[30/255;200/255],[0,1]);
subplot(3,3,4);
imshow(C);
title('����֮���ͼ��')
subplot(3,3,5);
imhist(C);
title('�������ֱ��ͼ')
%%%��ԭʼͼ����зֶ����Ա任����%%%
A=histeq(B);
subplot(3,3,7);
imshow(A);
title('���⻯��ͼ��')
subplot(3,3,8);
imhist(A);
axis tight;
title('���⻯���ֱ��ͼ')