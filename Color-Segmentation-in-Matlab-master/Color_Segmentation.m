clc;
clear all;
close all;
[fname path] = uigetfile('*.*', 'Enter an Image');
fname = strcat(path,fname);
image = imread(fname);
subplot(2,2,1);
imshow(image,'Border','tight');
title('Original Image');

R = image;
R(:,:,2:3) = 0;
subplot(2,2,2);
imshow(R,'Border','tight');
title('Red Component');

G = image;
G(:,:,[1 3]) = 0;
subplot(2,2,3);
imshow(G,'Border','tight');
title('Green Component');

B = image;
B(:,:,1:2) = 0;
subplot(2,2,4);
imshow(B,'Border','tight');
title('Blue Component');
ScrSize = get(0,'ScreenSize');
set(gcf,'Units','pixels','Position',ScrSize,'Toolbar','none','Menubar','none');

r = 0; g = 0; b = 0;
for m = 1:size(image,1)
    for n = 1:size(image,2)
        r = r + double(image(m,n,1));
        g = g + double(image(m,n,2));
        b = b + double(image(m,n,3));
    end
end

totalRGB  = r + g + b;
RGB(1) = (r / totalRGB) * 100;
RGB(2) = (g / totalRGB) * 100;
RGB(3) = (b / totalRGB) * 100;

labels = {'RED Component','GREEN Component','BLUE Component'};
figure;
h = pie(RGB);
hText = findobj(h,'Type','text'); % text object handles
percentValues = get(hText,'String'); % percent values
legend(labels,'Location','eastoutside','Orientation','vertical');
ScrSize = get(0,'ScreenSize');
set(gcf,'Units','pixels','Position',ScrSize,'Toolbar','none','Menubar','none');
colormap([1 0 0; 0 1 0; 0 0 1]);





