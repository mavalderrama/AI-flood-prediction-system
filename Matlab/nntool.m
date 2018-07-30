load('BatonRougeTrainingDataset.mat')
load('BatonRougeTrainingDatasetTargets.mat')
BatonRougeTrainingDataset = BatonRougeTrainingDataset';
BatonRougeTrainingDatasetTargets = BatonRougeTrainingDatasetTargets';
net = feedforwardnet(3,'trainlm');
net.layers{2}.transferFcn = 'tansig';
BatonRougeTrainingDataset(1,:) = BatonRougeTrainingDataset(1,:)/max(BatonRougeTrainingDataset(1,:));
BatonRougeTrainingDataset(2,:) = BatonRougeTrainingDataset(2,:)/max(BatonRougeTrainingDataset(2,:));
BatonRougeTrainingDataset(3,:) = BatonRougeTrainingDataset(3,:)/max(BatonRougeTrainingDataset(3,:));
net = configure(net,BatonRougeTrainingDataset,BatonRougeTargets);
net.trainParam.epochs = 100000; %Maximum number of epochs to train
net = init(net);
net3 = train(net, BatonRougeTrainingDataset, BatonRougeTargets);
%view(net)

%% 
w = 32; %32bit
f = 28; %28bits to decimal part

fi_net = net3;

IW=fi(net3.IW{1,1},1,w,f);
LW=fi(net3.LW{2,1},1,w,f);
b_1=fi(net3.b{1},1,w,f);
b_2=fi(net3.b{2},1,w,f);

fi_net.IW{1,1}=IW.data;
fi_net.LW{2,1}=LW.data;
fi_net.b{1}=b_1.data;
fi_net.b{2}=b_2.data;

%% Save to a file the network evaluation
[w,l]=size(BatonRougeTrainingDataset);
fileID = fopen('resultsFixedNetwork.txt','w');
for i=1:l
    fprintf(fileID,'%f,%f\n',BatonRougeTargets(i),sim(fi_net,BatonRougeTrainingDataset(:,i)));
end

