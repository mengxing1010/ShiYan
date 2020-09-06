%
% Implementation of a simple algorithm proposed by X. Lin and S. Chen 
% (http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.28.1325&rep=rep1&type=pdf, 4.6.1)
% Method is used by robot vehicles. It's a pixel based segmentation using histogram tresholding.
% The output will be an image split in two regions - road and non-road.
%

clear all;
close all;
clc;

inputImg=input('Enter path to an image file: ','s');  % '.\images\filename'
img = im2double(imread(inputImg));
figure, imshow(img);

% Conversion to HSI color space
r=img(:,:,1);
g=img(:,:,2);
b=img(:,:,3);

I=(r+g+b)/3;
H=acos((0.5*((r-g)+(r-b)))./((sqrt((r-g).^2+(r-b).*(g-b)))+eps)); % used eps to prevent divisions by zero
H(b>g)=2*pi-H(b>g);
H=H/(2*pi);
S=1-3.*(min(min(r,g),b))./(r+g+b+eps);
hsi=cat(3,H,S,I);
figure, imshow(hsi);

% All histograms are bimodal, with two peaks, one for road and one for background
figure, imhist(S);
figure, imhist(I);
figure, imhist(H);

nrows = size(hsi,1); % image height
ncols = size(hsi,2); % image width

newimg = zeros(nrows,ncols,5);
newimg(:, :, 1:3) = hsi(:,:,:);

Smean = mean2(hsi(:,:,2));
Imean = mean2(hsi(:,:,3));

R=r./(r+g+b+eps);
G=g./(r+g+b+eps);
B=b./(r+g+b+eps);

% Compute V values of modified HSI space
for k = 1:nrows
    for j = 1:ncols
        s = newimg(k,j,2);
        i = newimg(k,j,3);
        v1 = (s-Smean)-(i-Imean); % first method - more stable
        v2 = double( 2*R(k,j)-G(k,j)-B(k,j) )./(double( G(k,j)-B(k,j) )+eps); % second method, should work for roads with shadowed areas
        newimg(k,j,4) = v1; 
        newimg(k,j,5) = v2;
    end
end
% The resulted image contains V values for both methods;

% Used histogram tresholding with singke treshold to separate the two
% segments
V1 = newimg(:,:,4); % new component
figure, imhist(V1);
level1 = multithresh(V1); % single treshold
seg1 = imquantize(V1,level1);
RGB1 = label2rgb(seg1)
figure, imshow(RGB1,[]);

V2 = newimg(:,:,5); % new component
figure, imhist(V2);
level2 = multithresh(V2); % single treshold
seg2 = imquantize(V2,level2);
RGB2 = label2rgb(seg2)
figure, imshow(RGB2,[]) % The method doesn't work properly