%����txt excel�ȴ���x y z���ݣ�����ά����ͼ
%% ��������
clear all;clc;close all;
load demo.mat;%����ĵ�����Ӧ��ȥ��NaNֵ
load XRow.mat
load yCol.mat
load z.mat
%% ��ؼ���
[a,~]=size(XRow);%x�������ܹ�********�У�
xmax=max(XRow);%x���������ֵΪ**********
xmin=min(XRow);%x��������СֵΪ********
%���������ǲ����õģ��������ü��ֵ
%delta_x=xmax-xmin;%x�᷶Χ���ֵΪ*****
%delta_x/a;%z������ԼΪ1.4796e-04����������Ϊ0.01,�����Ҫ��Ϊ��ȷ����������Ϊ0.001��0.0001
[b,~]=size(yCol);%y������Ϊ******
ymax=max(yCol);%y���������ֵΪ******
ymin=min(yCol);%y��������СֵΪ********
%���������ǲ����õģ��������ü��ֵ
%delta_y=ymax-ymin;%�᷶Χ���ֵΪΪ******
%delta_y/b;%y������ԼΪ9.9876e-05����������Ϊ0.01�������Ҫ��Ϊ��ȷ����������Ϊ0.001��0.0001
%% �ع���ά���ݣ���ͼ
%���Ϊ 0.05��ʱ��X Y����Ϊ *****��****��  ����һ��ģ����������
%���Ϊ    1��ʱ��X Y����Ϊ ***��***��    ����  �õģ��������С
[X,Y]=meshgrid(xmin:1:xmax,ymin:1:ymax);%��x��y�����񻯣��ع����ڻ�ͼx��y������
Z=griddata(XRow,yCol,z,X,Y);%��ֵ���ع����ڻ�ͼ��Z������
clear a b xmax xmin ymin ymax xRow yCol z;
mesh(X,Y,Z)




