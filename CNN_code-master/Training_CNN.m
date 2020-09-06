clc;
clear all;
close all;


outputFolder = fullfile('Testing_fruits');
rootFolder = fullfile(outputFolder, 'Training');
 
categories = {''};



imds = imageDatastore(fullfile(rootFolder,categories),'LabelSource','foldernames');
tbl = countEachLabel(imds)
% minSetCount = min(tbl{:,2});
% 
% imds = splitEachLabel(imds, minSetCount, 'randomize');
% 
% labelCount = countEachLabel(imds)
img = readimage(imds,1);
size(img)

[imdsTrain,imdsValidation] = splitEachLabel(imds, 0.3, 'randomize');
 
layers = [
    imageInputLayer([100 100 3])
    
    convolution2dLayer(3,8,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(3,16,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(5,32,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    fullyConnectedLayer(15)
    softmaxLayer
    classificationLayer];

   options = trainingOptions('sgdm', ...
    'InitialLearnRate',0.01, ...
    'MaxEpochs',6, ...
    'Shuffle','every-epoch', ...
    'ValidationFrequency',30, ...
    'Verbose',false, ...
    'Plots','training-progress');

    tic,net = trainNetwork(imdsTrain,layers,options);toc
    
    tic,YPred = classify(net,imdsValidation);
YValidation = imdsValidation.Labels;toc
confMat = confusionmat(YPred,YValidation )
confusionchart(confMat)

% confMat = bsxfun(@rdivide,confMat,sum(confMat,2))
% mean(diag(confMat))
accuracy = sum(YPred == YValidation)/numel(YValidation)

save db;