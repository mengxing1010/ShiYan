clear;
clc;

load predict_label.mat;
load num_in_each_class.mat;
load classes.mat;
grayimage = 1;   %gray==1, gray image, else color image.

confusion_matrix=compute_confusion_matrix(predict_label,...
    num_in_each_class,classes,grayimage);