I=imread('A.tif');
rows=size(I,1);
cols=size(I,2);
movx=50;movy=50;
for i =1:rows
for j =1:cols
    Q(i+movx,j+movy)=I(i,j);
end
end
figure(1);
imshow(I);title('原始图像')
figure(2)
imshow(Q);
title('平移后图片')