
fb = imread('apple.jpg');
subplot(121),imshow(fb),title('原始图像')
lapmask = [1 1 1;1 -8 1;1 1 1];    %拉普拉斯模板
fb = tofloat(fb);             %将其变成浮点型
fen = fb - imfilter(fb,lapmask,'replicate');    %锐化滤波
subplot(122),imshow(fen),title('锐化后图像')

