?clc;
clear;
close all;

fuse_matrix=rand(4)%产生矩阵

imagesc(fuse_matrix)
set(gca,'xtick',1:5)
set(gca,'xticklabel',{'Apple ','Orange','Lemon','Strawberry'},'XTickLabelRotation',12)%设置横轴和横轴标签大小
set(gca,'ytick',1:5)
set(gca,'yticklabel',{'Apple ','Orange','Lemon','Strawberry'})%设置纵轴
set(gca,'FontSize',14,'Fontname', 'Times New Roman');%设置坐标系的数字大小
colorbar%产生colorbar