tic;
clc;
clear all
close all

load batchskintraindata
load batchskintestdata
% maxepoch=50;
maxepoch=20;
% maxepoch=1;
% numhid=500; numpen=500; numpen2=500;
numhid=200; numpen=200; numpen2=300;
% numhid=500; numpen=500; numpen2=300;
fprintf(1,'Converting Raw files into Matlab format \n');
% converter;

fprintf(1,'Pretraining a deep autoencoder. \n');
fprintf(1,'The Science paper used 50 epochs. This uses %3i \n', maxepoch);

% makebatches;
[numcases numdims numbatches]=size(batchdata);

fprintf(1,'Pretraining Layer 1 with RBM: %d-%d \n',numdims,numhid);%784-500
restart=1;
rbm;
hidrecbiases=hidbiases;
save mnistvhclassify vishid hidrecbiases visbiases;

%% ===========��һ��ml_multiclass_logistic Ԥ��=====================
% Options:
%    - addBias: adds a bias variable (default: 1)
%    - standardize: standardize the data (default: 0)
%    - lambdaL2: strength of L2-regularization parameter (default: 0)
load skintraindata
load skintestdata
load mnistvhclassify

options.addBias = 1;
options.standardize = 0;
options.lambdaL2 = 0;

digittargets = traintargets;
digittargetstest = testtargets;
digitdata = traindata;
digitdatatest = testdata;

N1 = length(digittargets);
N2 = length(digittargetstest);
w1=[vishid; hidrecbiases]; %(784+1*500)

digitdata1 = [digitdata ones(N1,1)];
w1probs = 1./(1 + exp(-digitdata1*w1));
model = ml_multiclass_logistic(w1probs, digittargets, options);
yhatTrain1 = model.predict(model, w1probs);
trainAccuracy1 = sum(digittargets==yhatTrain1)/length(digittargets);

digitdatatest1 = [digitdatatest ones(N2,1)];
w1probs = 1./(1 + exp(-digitdatatest1*w1));
yhatTest1 = model.predict(model, w1probs);
testAccuracy1 = sum(digittargetstest==yhatTest1)/length(digittargetstest);

save dbnelmclonelayer yhatTrain1 yhatTest1

fprintf('Averaged misclassification train Accuracy and test Accuracy %.3f is: %.3f\n',...
        trainAccuracy1, testAccuracy1);

% ===========��һ��ml_multiclass_logistic Ԥ��=====================
fprintf(1,'\nPretraining Layer 2 with RBM: %d-%d \n',numhid,numpen);%500-500
batchdata=batchposhidprobs;
numhid=numpen;
restart=1;
rbm;
hidpen=vishid; penrecbiases=hidbiases; hidgenbiases=visbiases;
save mnisthpclassify hidpen penrecbiases hidgenbiases;

%% ===========�ڶ���ml_multiclass_logistic Ԥ��=====================
% Options:
%    - addBias: adds a bias variable (default: 1)
%    - standardize: standardize the data (default: 0)
%    - lambdaL2: strength of L2-regularization parameter (default: 0)
load skintraindata
load skintestdata
load mnistvhclassify

options.addBias = 1;
options.standardize = 0;
options.lambdaL2 = 0;

digittargets = traintargets;
digittargetstest = testtargets;
digitdata = traindata;
digitdatatest = testdata;

N1 = length(digittargets);
N2 = length(digittargetstest);
w1=[vishid; hidrecbiases]; %(784+1*500)
w2=[hidpen; penrecbiases]; %(500+1*500)

digitdata1 = [digitdata ones(N1,1)];
w1probs = 1./(1 + exp(-digitdata1*w1)); w1probs = [w1probs  ones(N1,1)];
w2probs = 1./(1 + exp(-w1probs*w2)); 
model = ml_multiclass_logistic(w2probs, digittargets, options);
yhatTrain2 = model.predict(model, w2probs);
trainAccuracy2 = sum(digittargets==yhatTrain2)/length(digittargets);

digitdatatest1 = [digitdatatest ones(N2,1)];
w1probs = 1./(1 + exp(-digitdatatest1*w1)); w1probs = [w1probs  ones(N2,1)];
w2probs = 1./(1 + exp(-w1probs*w2)); 
yhatTest2 = model.predict(model, w2probs);
testAccuracy2 = sum(digittargetstest==yhatTest2)/length(digittargetstest);

save dbnelmcltwolayer yhatTrain2 yhatTest2

fprintf('Averaged misclassification train Accuracy and test Accuracy %.3f is: %.3f\n',...
        trainAccuracy2, testAccuracy2);

% ===========�ڶ���ml_multiclass_logistic Ԥ��=====================

fprintf(1,'\nPretraining Layer 3 with RBM: %d-%d \n',numpen,numpen2);%500-2000
batchdata=batchposhidprobs;
numhid=numpen2;
restart=1;
rbm;
hidpen2=vishid; penrecbiases2=hidbiases; hidgenbiases2=visbiases;
save mnisthp2classify hidpen2 penrecbiases2 hidgenbiases2;

clear all;
load mnistvhclassify
load mnisthpclassify
load mnisthp2classify
load skintraindata
load skintestdata

digitdata = traindata;
targets = traintargetsbinary;
N1 = length(targets);
%%%% PREINITIALIZE WEIGHTS OF THE DISCRIMINATIVE MODEL%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

w1=[vishid; hidrecbiases]; %(784+1*500)
w2=[hidpen; penrecbiases]; %(500+1*500)
w3=[hidpen2; penrecbiases2];%(500+1*2000)

digitdata = [digitdata ones(N1,1)];

w1probs = 1./(1 + exp(-digitdata*w1)); w1probs = [w1probs  ones(N1,1)];
w2probs = 1./(1 + exp(-w1probs*w2)); w2probs = [w2probs ones(N1,1)];
w3probs = 1./(1 + exp(-w2probs*w3)); 
H = w3probs';  %700       60000
% size(H)
%=======================================================================%
%===========================ѵ������=====================================%
%=======================================================================%
T = targets'; %1 60000

%%%%%%%%%%% Calculate output weights OutputWeight (beta_i)


OutputWeight=pinv(H') * T';                        % implementation without regularization factor //refer to 2006 Neurocomputing paper
save OutputWeight
%%%%%%%%%%% Calculate the training accuracy
Y=(H' * OutputWeight)';                             %   Y: the actual output of the training data
clear H;
[I train_output]=max(Y',[],2);%��������Ԥ���ǩ��λ��
[I1 train_target]=max(T',[],2);%��������Ԥ���ǩ��λ��

%%%%%%%%%% Calculate training classification accuracy
train_accuracy = sum(train_output==train_target) / length(train_target)

%=======================================================================%
%===========================���Թ���=====================================%
%=======================================================================%
load mnistvhclassify
load mnisthpclassify
load mnisthp2classify
load skintraindata
load skintestdata
load OutputWeight

digitdatatest = testdata;
targetstest = testtargetsbinary;
N2 = length(targetstest);

%%%% PREINITIALIZE WEIGHTS OF THE DISCRIMINATIVE MODEL%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

w1=[vishid; hidrecbiases]; %(784+1*500)
w2=[hidpen; penrecbiases]; %(500+1*500)
w3=[hidpen2; penrecbiases2];%(500+1*2000)

digitdatatest = [digitdatatest ones(N2,1)];

w1probs = 1./(1 + exp(-digitdatatest*w1)); w1probs = [w1probs  ones(N2,1)];
w2probs = 1./(1 + exp(-w1probs*w2)); w2probs = [w2probs ones(N2,1)];
w3probs = 1./(1 + exp(-w2probs*w3)); 
H = w3probs';  %700       10000
% size(H)

TV.T = targetstest'; %1 10000

TY=(H' * OutputWeight)';                       %   TY: the actual output of the testing data
[TI test_output]=max(TY',[],2);%��������Ԥ���ǩ��λ��
[TI1 test_target]=max(TV.T',[],2);%��������Ԥ���ǩ��λ��

%%%%%%%%%% Calculate testing classification accuracy
test_accuracy = sum(test_output==test_target) / length(test_target)

t=toc

save dbnelmclthreelayer train_output test_output 

dbnelmclvoit  %����ͶƱ

t=toc

% train_accuracy_end =
% 
%     0.9960
% 
% 
% test_accuracy_end =
% 
%     0.9765
% 
% 
% t =
% 
%   445.8641












