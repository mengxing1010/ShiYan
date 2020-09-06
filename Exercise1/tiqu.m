clear all;clc;

ImagePath='F:\matlabfile\project';
Images = dir([ImagePath, '4.bmp']);
PictureNums = length(Images);
FitureNums = 8;
gray_comatrix=zeros(PictureNums,FitureNums);
label_features=zeros(PictureNums,FitureNums+1);

for i=1:PictureNums
    i
    name = Images(i).name;
    I=imread([ImagePath,name]);
    
    B=rgb2gray(I);
    
    H=graycomatrix(B,'GrayLimits',[],'NumLevels', FitureNums,'Offset',[0 1;-1 1;0 -1;-1 -1]);%得到灰度共生矩阵
    stats=new_graycoprops(H,'all');
    
    Energy = [];
    Energy= [Energy,stats.Energy];
    Energy=mean(Energy);
    
    Contrast=[];
    Contrast=[Contrast,stats.Contrast];
    Contrast=mean(Contrast);
    
    Correlation=[];
    Correlation=[Correlation,stats.Correlation];
    Correlation=mean(Correlation);
    
    Dissimilarity=[];
    Dissimilarity=[Dissimilarity,stats.Dissimilarity];
    Dissimilarity=mean(Dissimilarity);
    
    Entropy=[];
    Entropy=[Entropy,stats.Entropy];
    Entropy=mean(Entropy);
    
    Homogeneity=[];
    Homogeneity=[Homogeneity,stats.Homogeneity];
    Homogeneity=mean(Homogeneity);
    
    Mean=[];
    Mean=[Mean,stats.Mean];
    Mean=mean(Mean);
    
    Variance=[];
    Variance=[Variance,stats.Variance];
    Variance=mean(Variance);
    
    %     gray_comatrix(i,1)=Energy;
    %     gray_comatrix(i,2)=Contrast;
    %     gray_comatrix(i,3)=Correlation;
    %     gray_comatrix(i,4)=Dissimilarity;
    %     gray_comatrix(i,5)=Entropy;
    %     gray_comatrix(i,6)=Homogeneity;
    %     gray_comatrix(i,7)=Mean;
    %     gray_comatrix(i,8)=Variance;
    
    %类别标签
    if(name(1)=='C')
        label = 1;
    else
        label = 0;
    end
    label_features(i,1) = label;
    label_features(i,2) = Energy;
    label_features(i,3) = Contrast;
    label_features(i,4) = Correlation;
    label_features(i,5) = Dissimilarity;
    label_features(i,6) = Entropy;
    label_features(i,7) = Homogeneity;
    label_features(i,8) = Mean;
    label_features(i,9) = Variance;
end

% save('mat文件名', '变量名') 
save('label_features', 'label_features');