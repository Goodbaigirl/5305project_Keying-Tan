clc;clear;close all;
%Read all voice files and label them
%% Read angry preprocessing, extract features, and add label 1
maindir='angry\'; %Specify file path
filename=dir(fullfile(maindir,'*.wav'));
m1=40*24;
e=1;
for j=1:length(filename)
    wavepath=fullfile(maindir,filename(j).name);
    [x,fs]=audioread(wavepath); %Read audio file
        a=0.98;
    for i=2:length(x)
        x1(i-1)=x(i)-a*x(i-1);
    end
    [StartPoint,EndPoint]=vad(x,fs); %Endpoint detection
    cc=mfcc(x); %Extract feature parameters
    cc=cc(StartPoint:EndPoint,:);
    ref1(j).StartPoint=StartPoint;
    ref1(j).EndPoint=EndPoint;
    ref1(j).mfcc=cc(1:40,:);
    ref1(j).label=1;
    ref(e,1:m1)=reshape(cc(1:40,:),[1,m1]);
    ref(e,m1+1)=1;
    e=e+1;
end
figure(1);
subplot(221);
subplot(221);
plot(x);grid on;
title('original signal')
subplot(222);
plot(x1);grid on;
title('After pre aggravation')
subplot(223);
plot(x(StartPoint:EndPoint));grid on;
hold on;
title('endpoint detection');
subplot(224);
plot(cc(:,1:4));
grid on;
title('MFCC')
%% Read fear preprocessing, extract features and add labels 2
maindir='fear\'; 
filename=dir(fullfile(maindir,'*.wav'));
for j=1:length(filename)
    wavepath=fullfile(maindir,filename(j).name);
    [x,fs]=audioread(wavepath);
        a=0.98;
    for i=2:length(x)
        x1(i-1)=x(i)-a*x(i-1);
    end
    [StartPoint,EndPoint]=vad(x,fs);
    cc=mfcc(x);
    ref2(j).StartPoint=StartPoint;
    ref2(j).EndPoint=EndPoint;
    ref2(j).mfcc=cc(1:40,:);
    ref2(j).label=2;
    ref(e,1:m1)=reshape(cc(1:40,:),[1,m1]);
    ref(e,m1+1)=2;
    e=e+1;
end

figure(2);
subplot(221);
plot(x);grid on;
title('original signal')
subplot(222);
plot(x1);grid on;
title('After pre aggravation')
subplot(223);
plot(x(StartPoint:EndPoint));grid on;
hold on;
title('endpoint detection');
subplot(224);
plot(cc(:,1:4));
grid on;
title('MFCC')
%% Read happy preprocessing, extract features and add labels 3
maindir='happy\';
filename=dir(fullfile(maindir,'*.wav'));
for j=1:length(filename)
    wavepath=fullfile(maindir,filename(j).name);
    [x,fs]=audioread(wavepath);
        a=0.98;
    for i=2:length(x)
        x1(i-1)=x(i)-a*x(i-1);
    end
    [StartPoint,EndPoint]=vad(x,fs);
    cc=mfcc(x);
    ref3(j).StartPoint=StartPoint;
    ref3(j).EndPoint=EndPoint;
    ref3(j).mfcc=cc(1:40,:);
    ref3(j).label=3;
    ref(e,1:m1)=reshape(cc(1:40,:),[1,m1]);
    ref(e,m1+1)=3;
    e=e+1;
end

figure(3);
subplot(221);
plot(x);grid on;
title('original signal')
subplot(222);
plot(x1);grid on;
title('After pre aggravation')
subplot(223);
plot(x(StartPoint:EndPoint));grid on;
hold on;
title('endpoint detection');
subplot(224);
plot(cc(:,1:4));
grid on;
title('MFCC')
%% Read neutral preprocessing, extract features and add labels 4
maindir='neutral\'; 
filename=dir(fullfile(maindir,'*.wav'));
for j=1:length(filename)
    wavepath=fullfile(maindir,filename(j).name);
    [x,fs]=audioread(wavepath);
        a=0.98;
    for i=2:length(x)
        x1(i-1)=x(i)-a*x(i-1);
    end
    
    [StartPoint,EndPoint]=vad(x,fs);
    cc=mfcc(x);
    cc=cc(StartPoint:EndPoint,:);
    ref4(j).StartPoint=StartPoint;
    ref4(j).EndPoint=EndPoint;
    ref4(j).mfcc=cc(1:40,:);
    ref4(j).label=4;
    ref(e,1:m1)=reshape(cc(1:40,:),[1,m1]);
    ref(e,m1+1)=4;
    e=e+1;
end

figure(4);
subplot(221);
plot(x);grid on;
title('original signal')
subplot(222);
plot(x1);grid on;
title('After pre aggravation')
subplot(223);
plot(x(StartPoint:EndPoint));grid on;
hold on;
title('endpoint detection');
subplot(224);
plot(cc(:,1:4));
grid on;
title('MFCC')
%% Read sad preprocessing, extract features and add labels 5
maindir='sad\'; 
filename=dir(fullfile(maindir,'*.wav'));
for j=1:length(filename)
    wavepath=fullfile(maindir,filename(j).name);
    [x,fs]=audioread(wavepath);
        a=0.98;
    for i=2:length(x)
        x1(i-1)=x(i)-a*x(i-1);
    end
    [StartPoint,EndPoint]=vad(x,fs);
    cc=mfcc(x);
    cc=cc(StartPoint:EndPoint,:);
    ref5(j).StartPoint=StartPoint;
    ref5(j).EndPoint=EndPoint;
    ref5(j).mfcc=cc(1:40,:);
    ref5(j).label=5;
    ref(e,1:m1)=reshape(cc(1:40,:),[1,m1]);
    ref(e,m1+1)=5;
    e=e+1;
end

figure(5);
subplot(221);
plot(x);grid on;
title('original signal')
subplot(222);
plot(x1);grid on;
title('After pre aggravation')
subplot(223);
plot(x(StartPoint:EndPoint));grid on;
hold on;
title('endpoint detection');
subplot(224);
plot(cc(:,1:4));
grid on;
title('MFCC')
%% Read surprise preprocessing, extract features and add labels 6
maindir='surprise\'; 
filename=dir(fullfile(maindir,'*.wav'));
for j=1:length(filename)
    wavepath=fullfile(maindir,filename(j).name);
    [x,fs]=audioread(wavepath);
        a=0.98;
    for i=2:length(x)
        x1(i-1)=x(i)-a*x(i-1);
    end
    [StartPoint,EndPoint]=vad(x,fs);
    cc=mfcc(x);
    ref6(j).StartPoint=StartPoint;
    ref6(j).EndPoint=EndPoint;
    ref6(j).mfcc=cc(1:40,:);
    ref6(j).label=6;
    ref(e,1:m1)=reshape(cc(1:40,:),[1,m1]);
    ref(e,m1+1)=6;
    e=e+1;
end

figure(6);
subplot(221);
plot(x);grid on;
title('original signal')
subplot(222);
plot(x1);grid on;
title('After pre aggravation')
subplot(223);
plot(x(StartPoint:EndPoint));grid on;
hold on;
title('endpoint detection');
subplot(224);
plot(cc(:,1:4));
grid on;
title('MFCC')

feature=ref(:,1:m1)';
label=ref(:,end)';
[xnorm,xopt]=mapminmax(feature,0,1);
[ynorm,yopt]=mapminmax(label,0,1);
input_train =xnorm; 
output_train=ynorm;
input_test =xnorm;
output_test=ynorm;
%% 
rng('default');
inputSize =m1;
numEpochs = 200;
batchSize = 16;
nTraining = length (label)
layers =[...
sequenceInputLayer(inputSize)
convolution1dLayer(5, 100,'Padding',2,'stride',1) % Convolutional layer 1
batchNormalizationLayer;
reluLayer(); % ReLU layer 1
convolution1dLayer(5, 70,'Padding',2,'stride' , 1)% Convolutional layer 2
batchNormalizationLayer;
maxPooling1dLayer(1,'Stride',1);% Max Pooling Pooling Layer 1
convolution1dLayer(3,50,'Padding',1,'Stride',1);% Convolutional layer 3
reluLayer(); % ReLU layer 3
maxPooling1dLayer(1,'Stride', 1) ;
convolution1dLayer(3, 40,'Padding', 1, 'Stride',1);% Convolutional layer 4
reluLayer();% ReLU layer 2
maxPooling1dLayer(1,'Stride',1);% Max Pooling Pooling Layer 1
fullyConnectedLayer(1, 'Name','fcl')
regressionLayer];
options=trainingOptions('adam',...
'InitialLearnRate',1e-3,...
'MiniBatchSize', batchSize,...
'MaxEpochs' , numEpochs);
[net,info1]= trainNetwork(input_train, output_train, layers, options)

fLaver = 'fcl';
trainingFeatures=activations(net,input_train,fLaver,...
'MiniBatchSize', 16,'OutputAs','channels');

trainingFeatures=cell2mat(trainingFeatures) ;
for i=1:length (trainingFeatures)
    TF{i}=double (trainingFeatures (:, i)) ;
end
%%Build attention-LSTM model
inputSize = 1;
numHiddenUnits =100;
layers=[...
sequenceInputLayer(inputSize) 
bilstmLayer(numHiddenUnits, 'OutputMode','last')
bilstmLayer(numHiddenUnits-30)
bilstmLayer(numHiddenUnits-60) 
fullyConnectedLayer(1) 
regressionLayer];
options = trainingOptions('adam',...
'InitialLearnRate',1e-3,...
'MiniBatchSize',8,...
'MaxEpochs',50,...
'Plots','training-progress');
[net1, info1] = trainNetwork(TF, output_train', layers, options);

testingFeatures = activations(net,input_test,fLaver,...
'MiniBatchSize',8,'OutputAs','channels');
testingFeatures=cell2mat(testingFeatures)
for i=1:length(testingFeatures)
    TFT{i}=double(testingFeatures (:,i));
end
YPred=predict(net1,TFT)
YPred=mapminmax('reverse',YPred, yopt) 
figure 
plot(YPred,'b--','LineWidth',1);
hold on;
plot (label,'r','LineWidth',1);
xlabel('sample')
ylabel ('classification')
legend('Forecast results','true value')
grid on
RMSE=sqrt(mse(label,YPred)) ;
error=abs(label'-double (YPred)) 
figure 
bar(error)

