mean = imread('wanggexian.png');
%figure,subplot(1,2,1),imshow(uint8(mean));title('背景图像');
%subplot(1,2,2),
figure
imshow(uint8(mean));
%title('背景图像');
hold on;
[xt, yt] = meshgrid(round(linspace(1, size(mean, 1), 9)), ...
round(linspace(1, size(mean, 2), 16)));%生成数据点矩阵
mesh(yt, xt, zeros(size(xt)), 'FaceColor', ...
'None', 'LineWidth', 1, ...
'EdgeColor', 'r');%绘制三维网格图
axis on
set(gca,'XTick',yt(:,1))
set(gca,'YTick',xt(1,:))
xlabel('Y')
ylabel('X')
%text(1,1,'原点')
