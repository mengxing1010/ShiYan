% Method adapted from MathWorks
close all;
clc;
%run using matlab /r "img=imagename;n_col=number;clustering"
img = imread('.\images\lemon1.jpg');
imshow(img);title('ԭͼ');
cform = makecform('srgb2lab');
lab_img = applycform(img,cform);
figure, imshow(lab_img);title('Lab�ռ�');
%using kmeans algorithm for clustering annd the 'a' and 'b' channels from
%Lab image
ab = double(lab_img(:,:,2:3)); %matrix of all pixels in the image with values for a and b onlyͼ�����������صľ��󣬽�����a��b��ֵ
nrows = size(ab,1); %image height
ncols = size(ab,2); %image width
ab = reshape(ab,nrows*ncols,2); %matrix of pixels; if image has size m*n, then nrows = m*n and ncol = 2 (chanels a and b)
n_col = 3; %number of colors is equal to the number of centroids for kmenas; depends of image��ɫ��������k��ֵ������������ ȡ����ͼ��

rep = 5;
%repeat the clustering 'rep' times to avoid local minima�ظ����ࡰ rep��ʱ���Ա���ֲ���Сֵ
[cluster_idx, cluster_center] = kmeans(ab,n_col,'distance','sqEuclidean','Replicates',rep);
%labeling the pixels by clustersͨ������������
pixel_labels = reshape(cluster_idx,nrows,ncols);
figure, imshow(pixel_labels,[]), title('image labeled by cluster index, repetitions = '+rep);

%separate image segments (by color)�ֿ���ͼ��Σ�����ɫ��
segmented_images = cell(1,n_col); % returns a cell array of empty matrices to be filled with image segments
rgb_label = repmat(pixel_labels,[1 1 n_col]);

for k = 1:n_col
    color = img;
    color(rgb_label ~= k) = 0;
    segmented_images{k} = color;
end

for k = 1:size(segmented_images,2)
    figure, imshow(segmented_images{k}), title('objects in cluster '+k);
end
mean_cluster_value = mean(cluster_center,2);

im1 = mean2(segmented_images{1});
im2 = mean2(segmented_images{2});
im3 = mean2(segmented_images{3});

% im = cat(3,im1,im2,im3);
% figure, imshow(im);
%detect light and dark shades of the same color using 'L' channel
L = lab_img(:,:,1); %intensity layer
%figure, imshow(L,[]);

h=imhist(L);
level1 = multithresh(L,n_col-1);
seg1 = imquantize(L,level1);
RGB1 = label2rgb(seg1)
figure, imshow(RGB1,[]);title('RGB')
