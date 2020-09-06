clc;
clear all;
close all;

load db;

[fname, path]=uigetfile('D:\MatlabFiles\Shiyan\CNN_code-master\Testing_fruits/.jpg','provide an Image for testing');
fname=strcat(path, fname);
newImage = imread(fname);

myicon = imread(fname);
imshow(newImage);
imdsValidation = newImage;
YPred = classify(net,imdsValidation);
msgbox(sprintf('The loaded image belongs to %s class', YPred));