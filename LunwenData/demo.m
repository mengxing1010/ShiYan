%利用txt excel等大量x y z数据，化三维立体图
%% 导入数据
clear all;clc;close all;
load demo.mat;%导入的的数据应当去除NaN值
load XRow.mat
load yCol.mat
load z.mat
%% 相关计算
[a,~]=size(XRow);%x轴数据总共********行；
xmax=max(XRow);%x轴数据最大值为**********
xmin=min(XRow);%x轴数据最小值为********
%下面两行是测试用的，便于设置间隔值
%delta_x=xmax-xmin;%x轴范围宽度值为*****
%delta_x/a;%z轴间隔大约为1.4796e-04，可以设置为0.01,如果想要更为精确，可以设置为0.001、0.0001
[b,~]=size(yCol);%y轴数据为******
ymax=max(yCol);%y轴数据最大值为******
ymin=min(yCol);%y轴数据最小值为********
%下面两行是测试用的，便于设置间隔值
%delta_y=ymax-ymin;%轴范围宽度值为为******
%delta_y/b;%y轴间隔大约为9.9876e-05，可以设置为0.01，如果想要根为精确，可以设置为0.001、0.0001
%% 重构三维数据，画图
%间隔为 0.05的时候，X Y数据为 *****×****，  电脑一般的，将间隔调大
%间隔为    1的时候，X Y数据为 ***×***，    电脑  好的，将间隔调小
[X,Y]=meshgrid(xmin:1:xmax,ymin:1:ymax);%将x、y轴网格化，重构用于画图x、y轴数据
Z=griddata(XRow,yCol,z,X,Y);%插值，重构用于画图的Z轴数据
clear a b xmax xmin ymin ymax xRow yCol z;
mesh(X,Y,Z)




