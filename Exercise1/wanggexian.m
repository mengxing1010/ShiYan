mean = imread('wanggexian.png');
%figure,subplot(1,2,1),imshow(uint8(mean));title('����ͼ��');
%subplot(1,2,2),
figure
imshow(uint8(mean));
%title('����ͼ��');
hold on;
[xt, yt] = meshgrid(round(linspace(1, size(mean, 1), 9)), ...
round(linspace(1, size(mean, 2), 16)));%�������ݵ����
mesh(yt, xt, zeros(size(xt)), 'FaceColor', ...
'None', 'LineWidth', 1, ...
'EdgeColor', 'r');%������ά����ͼ
axis on
set(gca,'XTick',yt(:,1))
set(gca,'YTick',xt(1,:))
xlabel('Y')
ylabel('X')
%text(1,1,'ԭ��')
