% Version 1.000
%
% Code provided by Ruslan Salakhutdinov and Geoff Hinton
%
% Permission is granted for anyone to copy, use, modify, or distribute this
% program and accompanying programs and documents for any purpose, provided
% this copyright notice is retained and prominently displayed, along with
% a note saying that the original programs are available from our
% web page.
% The programs and documents are distributed without any warranty, express or
% implied.  As the programs were written for research purposes only, they have
% not been tested to the degree that would be advisable in any important
% application.  All use of these programs is entirely at the user's own risk.


% This program pretrains a deep autoencoder for MNIST dataset
% You can set the maximum number of epochs for pretraining each layer
% and you can set the architecture of the multilayer net.
tic;
clear all
close all

%������������������
maxepoch=20; %In the Science paper we use maxepoch=50, but it works just fine.
%�趨����������1000,500,250,30���ݽ�
numhid=1000; numpen=500; numpen2=250; numopen=30;

fprintf(1,'Converting Raw files into Matlab format \n');
converter;

fprintf(1,'Pretraining a deep autoencoder. \n');
fprintf(1,'The Science paper used 50 epochs. This uses %3i \n', maxepoch);

makebatches;  %���ѵ�����ݺͲ������ݴ洢�ɹ̶��ĸ�ʽ
[numcases numdims numbatches]=size(batchdata);  %���ѵ�����ݵ�ά��ֵ

fprintf(1,'Pretraining Layer 1 with RBM: %d-%d \n',numdims,numhid);%28*28-1000
restart=1;
rbm;%ͨ����Ԫ������Ԫ�Ϳ��Ӳ���Ԫѵ��RBM
hidrecbiases=hidbiases;  %��һ��RBMѧϰ��������ƫ��
save mnistvh vishid hidrecbiases visbiases;  %�����һ��RBM��Ȩ�ء�����ƫ�á����Ӳ�ƫ��

%pause

fprintf(1,'\nPretraining Layer 2 with RBM: %d-%d \n',numhid,numpen);%1000-500
batchdata=batchposhidprobs;  %��һ������������ݣ���άһ�ν����
numhid=numpen;  %�������ı�Ϊ500
restart=1;
rbm;%ͨ����Ԫ������Ԫ�Ϳ��Ӳ���Ԫѵ��RBM
hidpen=vishid; penrecbiases=hidbiases; hidgenbiases=visbiases;
save mnisthp hidpen penrecbiases hidgenbiases;  %����ڶ���RBM��Ȩ�ء�����ƫ�á����Ӳ�ƫ��

%pause

fprintf(1,'\nPretraining Layer 3 with RBM: %d-%d \n',numpen,numpen2);%500-250
batchdata=batchposhidprobs;  %�ڶ�������������ݣ���ά���ν����
numhid=numpen2;%�������ı�Ϊ250
restart=1;
rbm;%ͨ����Ԫ������Ԫ�Ϳ��Ӳ���Ԫѵ��RBM
hidpen2=vishid; penrecbiases2=hidbiases; hidgenbiases2=visbiases;
save mnisthp2 hidpen2 penrecbiases2 hidgenbiases2;  %���������RBM��Ȩ�ء�����ƫ�á����Ӳ�ƫ��

%pause

fprintf(1,'\nPretraining Layer 4 with RBM: %d-%d \n',numpen2,numopen);%250-30
batchdata=batchposhidprobs; %����������������ݣ���ά���ν����
numhid=numopen;%�������ı�Ϊ30
restart=1;
rbmhidlinear;%ͨ����˹������Ԫ�Ϳ��Ӳ��Ԫ��Ԫѵ��RBM
hidtop=vishid; toprecbiases=hidbiases; topgenbiases=visbiases;
save mnistpo hidtop toprecbiases topgenbiases;

%pause

backprop;   %΢���ﵽ��Ӧ��ϵ��

t=toc;
