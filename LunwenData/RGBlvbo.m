
fb = imread('apple.jpg');
subplot(121),imshow(fb),title('ԭʼͼ��')
lapmask = [1 1 1;1 -8 1;1 1 1];    %������˹ģ��
fb = tofloat(fb);             %�����ɸ�����
fen = fb - imfilter(fb,lapmask,'replicate');    %���˲�
subplot(122),imshow(fen),title('�񻯺�ͼ��')

