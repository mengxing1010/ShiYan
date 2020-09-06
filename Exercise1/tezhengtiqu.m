img=imread('D:\MatlabFiles\TrainDatas\data\0.jpg');
figure;imshow(img);
img=im2bw(img);
img=not(img);
figure;imshow(img);
[B,L]=bwboundaries(img);
figure;imshow(img);
hold on;
for k=1:length(B)
    boundary=B{k};
    plot(boundary(:,2),boundary(:,1),'r','LineWidth',2);
end
[L,N]=bwlabel(img);
img_rgb=label2rgb(L,'hsv',[.5 .5 .5],'shuffle');
figure;imshow(img_rgb);hold on;
for k=1:length(B)
    boundary=B{k};
    plot(boundary(:,2),boundary(:,1),'w','LineWidth',2);
    %text(boundary(1,2)-11,boundary(1,1)+11,num2str(k),'Color','y','Fontsize',14,'FontWeight','bold');
end
stats=regionprops(L,'all');
temp=zeros(1,N);
for k=1:N
    temp(k)=4*pi*stats(k,1).Area / (stats(k,1).Perimeter)^2;
    stats(k,1).ThinnessRatio=temp(k);
    temp(k)=(stats(k,1).BoundingBox(3))/(stats(k,1).BoundingBox(4));
    stats(k,1).AspectRatio=temp(k);
end