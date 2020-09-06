clear;clc;
I=imread('apple.jpg');
subplot(2,2,1);imshow(I);xlabel('original image');
I1=rgb2hsv(I);scale=0.5;
I2=I1(:,:,1).*I1(:,:,2);
m=I2>max(max(I2))*scale;
for u=1:3
    I(:,:,u)=I(:,:,u).*uint8(m);
end
% T=max(I(:))*scale;I11=double(I);
% I11(:,:,1)=I11(:,:,1).*double(I11(:,:,1)>T);
% I11(:,:,2)=I11(:,:,2).*double(I11(:,:,2)>T);
% I11(:,:,3)=I11(:,:,3).*double(I11(:,:,3)>T);
subplot(2,2,3);imshow(I,[]);xlabel('RGB segmentation');
I3=double(m);
I1(:,:,1)=I1(:,:,1).*I3;
I1(:,:,2)=I1(:,:,2).*I3;
I1(:,:,3)=I1(:,:,3).*I3;
subplot(2,2,4);imshow(I1,[]);xlabel('HSV segmentation');
% figure;imshow(I11,[]);
