?clc;
clear;
close all;

fuse_matrix=rand(4)%��������

imagesc(fuse_matrix)
set(gca,'xtick',1:5)
set(gca,'xticklabel',{'Apple ','Orange','Lemon','Strawberry'},'XTickLabelRotation',12)%���ú���ͺ����ǩ��С
set(gca,'ytick',1:5)
set(gca,'yticklabel',{'Apple ','Orange','Lemon','Strawberry'})%��������
set(gca,'FontSize',14,'Fontname', 'Times New Roman');%��������ϵ�����ִ�С
colorbar%����colorbar