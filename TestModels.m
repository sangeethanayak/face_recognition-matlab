clc;
close;
clear
cam=webcam;
load myNet;
% load myNet from TrainModels.m

faceDetector=vision.CascadeObjectDetector;

while true
    e=cam.snapshot;
    bboxes =step(faceDetector,e);

    if(sum(sum(bboxes))~=0)
    
    es=imcrop(e,bboxes(1,:));
% imcrop creates an interactive Crop Image tool associated with the grayscale, truecolor, or binary image displayed in the current figure 
% imcrop returns the cropped image, es
    
    es=imresize(es,[227 227]);
% returns image es that has the number of rows and columns specified by the two-element vector [numrows numcols]
    
    label=classify(myNet,es);
% Predicts the class labels of the specified images using the trained network net

    image(e);
    title(char(label));
    drawnow;

    else
     image(e);
     title('No Face Detected');
   end
end
