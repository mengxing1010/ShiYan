I=imread('Lena.jpg');%����ͼ��


figure;%���´���
[M,N]=size(I);%����ͼ���С
[counts,x]=imhist(I,32);%������32��С����ĻҶ�ֱ��ͼ
counts=counts/M/N;%�����һ���Ҷ�ֱ��ͼ�������ֵ
stem(x,counts);%���ƹ�һ��ֱ��ͼ