clc
close all

g = alexnet;
% returns an AlexNet network trained on the ImageNet data set
% AlexNet is a convolutional neural network that is 8 layers deep. You can load a pretrained version of the network trained on more than a million images from the ImageNet database
% The pretrained network can classify images into 1000 object categories, such as keyboard, mouse, pencil, and many animals. As a result, the network has learned rich feature representations for a wide range of images
% The network has an image input size of 227-by-227

layers=g.Layers;
% returns the untrained AlexNet network architecture. The untrained model does not require the support package

layers(23)=fullyConnectedLayer(2);
% returns a fully connected layer and specifies the OutputSize property, here Outputsize = 2

layers(25)=classificationLayer;
% A classification layer computes the cross-entropy loss for classification and weighted classification tasks with mutually exclusive classes
% The layer infers the number of classes from the output size of the previous layer
% For example, to specify the number of classes K of the network, you can include a fully connected layer with output size K and a softmax layer before the classification layer


allImages=imageDatastore('load_data','IncludeSubfolders',true, 'LabelSource','foldernames');
% imageDatastore creates a datastore allImages from the collection of image data specified by location.
% load_data is the folder which consists of images that is stored after detection
% IncludeSubfolders includes the subfolders of load_data


opts=trainingOptions('sgdm','InitialLearnRate',0.001,'MaxEpochs',20,'MiniBatchSize',64);
% returns training options for the optimizer specified by arguments. To train a network, use the training options as an input argument to the trainNetwork function.
% stochastic gradient descent with momentum (sgdm) is used to train the network. 
% Set the maximum number of epochs for training to 20, and use a mini-batch with 64 observations at each iteration.

myNet=trainNetwork(allImages,layers,opts);
% Trains the neural network specified by layers for image classification and regression tasks using the images and responses specified by allImages and the training options defined by options.

save myNet;
