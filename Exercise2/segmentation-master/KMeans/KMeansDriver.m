
%% Selecting distinct colours from an image
% Car
imrgb = imread('D:\MatlabFiles\Projects\Exercise2\2.jpg');

% Plane
% imrgb = imread('~/Desktop/BSR/BSDS500/data/images/test/3063.jpg');

% Tiger
%imrgb = imread('~/Desktop/BSR/BSDS500/data/images/test/108004.jpg');



%% Test weights for spatial Lab segmentation
k=3;
[I,M] = kmeansSegHSVSpatial( imrgb, k,0.0015);

%% Func
k=2;
I = funcKMeans(imrgb,k);
%% SegLab
k=3;


[I,M] = kmeansSegLabSpatial( imrgb, k);

%% Plot em
for i=1:k
    subplot(1,3,i),imshow(I{i});
end


%% Test kmeans

imrgbV=double(reshape(imrgb,size(imrgb,1) * size(imrgb,2), 3 ));
tic
[idx1, km1] = kmeans( imrgbV,8);
toc
tic
[idx2, km2] = kmeans_d( imrgbV,8);
toc
%%
srgb2lab=makecform('srgb2lab');
seedsrgb=[228 218 208;88 121 175; 47 67 55];
seedsrgb = double(seedsrgb ./ 255);
seedslab=applycform(seedsrgb,srgb2lab);
seedsab = double(seedslab(:,2:3));

k=3;
[I,M] = kmeansSegLabSeeds(imrgb,k,seedsab);

%%
% Manual seeding
[w,h,c] = size(imrgb);
sz = w*h;
srgb2lab=makecform('srgb2lab');
lab2srgb=makecform('lab2srgb');

imrgb = imrgb ./ 255;
rgbvec=double(reshape(imrgb,sz,3));
imlab=applycform(imrgb,srgb2lab);
labvec=reshape(imlab,sz,3);
abvec = double(labvec(:,2:3));

seedsrgb=[228 218 208;88 121 175; 47 67 55];
seedsrgb = double(seedsrgb ./ 255);
seedslab=applycform(seedsrgb,srgb2lab);
seedsab = double(seedslab(:,2:3));

%% Do it
[idx,c] = kmeans(rgbvec, 3, 'emptyaction','singleton','start',seedsrgb);
outColours = uint8(round(255*c));
outImage = zeros(sz,3);

for i=1:3
    ix = find(idx==i);
    outImage(ix,1) = outColours(i,1);
    outImage(ix,2) = outColours(i,2);
    outImage(ix,3) = outColours(i,3);
end

outImage = reshape(outImage,size(imrgb));
imshow(outImage);

%% Do it
[idx,c] = kmeans(abvec, 3, 'emptyaction','singleton','start',seedsab);
%% Segment RGB
k = 3;
[I,M] = kmeansSegRGB( imrgb, k );

%% Plot output
for i=1:k
    subplot(2,3,i), imshow(I{i});
end



