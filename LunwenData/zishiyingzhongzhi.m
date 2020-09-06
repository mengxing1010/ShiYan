clc;
clear;
f=imread('lemon1.jpg');
image_gray=rgb2gray(f);%�õ��Ҷ�ͼ��
ff =image_gray;

ff(:) = 0;
alreadyProcessed = false(size(image_gray));%�����߼��ǵľ���
% ����.
Smax=7;
for k = 3:2:Smax
   zmin = ordfilt2(image_gray, 1, ones(k, k), 'symmetric');
   zmax = ordfilt2(image_gray, k * k, ones(k, k), 'symmetric');
   zmed = medfilt2(image_gray, [k k], 'symmetric');
   
   processUsingLevelB = (zmed > zmin) & (zmax > zmed) & ...
       ~alreadyProcessed; 
   zB = (image_gray > zmin) & (zmax > image_gray);
   outputZxy  = processUsingLevelB & zB;
   outputZmed = processUsingLevelB & ~zB;
   ff(outputZxy) = image_gray(outputZxy);
   ff(outputZmed) = zmed(outputZmed);
   
   alreadyProcessed = alreadyProcessed | processUsingLevelB;
   if all(alreadyProcessed(:))
      break;
   end
end
ff(~alreadyProcessed) = zmed(~alreadyProcessed);
f1=imnoise(image_gray,'salt & pepper',0.3);%��ӽ����������ͼ��
f2=medfilt2(f1,[3,3]);%��ֵ�˲����ͼ��
subplot(2,2,1);
imshow(image_gray);
title('ԭͼ');
subplot(2,2,2);
imshow(f1);
title('����������Ⱦ���ͼ��');
subplot(2,2,3);
imshow(f2);
title('��ֵ�˲�');
subplot(2,2,4);
imshow(ff);
title('����Ӧ��ֵ�˲�');
