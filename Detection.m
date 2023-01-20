clc
clear all
close all
warning off;
cam = webcam;
%cam = webcam creates the webcam object cam and connects to the single webcam on your system. If you have multiple cameras and you use the webcam function with no input argument, it creates the object and connects it to the first camera it finds listed in the output of the webcamlist function.
%When the webcam object is created, it connects to the camera, establishes exclusive access, and starts streaming data. You can then preview the data and acquire images using the snapshot function.

faceDetector = vision.CascadeObjectDetector;
%The cascade object detector uses the Viola-Jones algorithm to detect people’s faces, noses, eyes, mouth, or upper body.
%vision.CascadeObjectDetector creates a face detector to detect objects using the Viola-Jones algorithm.

c = 75;
temp = 0;
while true
    e = cam.snapshot;
    %Acquires a single image from the webcam object cam and assigns it to the variable e. The snapshot function returns the current frame. Calling snapshot in a loop returns a new frame each time. The returned image is always an RGB image. snapshot uses the camera’s default resolution or another resolution that you specify using the Resolution property.
    
    bboxes = step(faceDetector,e);
    %Returns the step response of a dynamic system model faceDetector at the times specified in the vector e.
    
    if(sum(sum(bboxes)) ~= 0)
    if(temp >= c)
        break;
    else
    es = imcrop(e, bboxes(1,:));
    %Crops the image es according to the position and dimensions specified in the crop bboxes(1,:). The cropped image includes all pixels in the input image that are completely or partially enclosed by the rectangle.
    %The actual size of the output image does not always correspond exactly with the width and height specified by bboxwe(1,:). For example, suppose rect is [20 20 40 30], using the default spatial coordinate system. The upper left corner of the specified rectangle is the center of the pixel with spatial (x,y) coordinates (20,20). The lower right corner of the rectangle is the center of the pixel with spatial (x,y) coordinates (60,50). The resulting output image has size 31-by-41 pixels, not 30-by-40 pixels.
    
    es = imresize(es, [227 227]);
    %returns image es that has the number of rows and columns specified by the two-element vector [227 227].
    
    filename = strcat(num2str(temp),'.bmp');
    %Horizontally concatenates the text in its input arguments. Each input argument can be a character array, a cell array of character vectors, or a string array.
    %If any input is a string array, then the result is a string array. If any input is a cell array, and none are string arrays, then the result is a cell array of character vectors.
    %If all inputs are character arrays, then the result is a character array.For character array inputs, strcat removes trailing ASCII whitespace characters: space, tab, vertical tab, newline, carriage return, and form feed. For cell array and string array inputs, strcat does not remove trailing white space.
   
    imwrite(es, filename);
    %Writes image data A to the file specified by filename, inferring the file format from the extension. imwrite creates the new file in your current folder. The bit depth of the output image depends on the data type of A and the file format. For most formats:
    %If A is of data type uint8, then imwrite outputs 8-bit values. If A is of data type uint16 and the output file format supports 16-bit data (JPEG, PNG, and TIFF), then imwrite outputs 16-bit values. If the output file format does not support 16-bit data, then imwrite returns an error.
    %If A is a grayscale or RGB color image of data type double or single, then imwrite assumes that the dynamic range is [0, 1] and automatically scales the data by 255 before writing it to the file as 8-bit values. If the data in A is single, convert A to double before writing to a GIF or TIFF file.
    %If A is of data type logical, then imwrite assumes that the data is a binary image and writes it to the file with a bit depth of 1, if the format allows it. BMP, PNG, or TIFF formats accept binary images as input arrays.
    
    temp=temp+1;
    
    imshow(es);
    %Displays the grayscale image es in a figure. imshow uses the default display range for the image data type and optimizes figure, axes, and image object properties for image display.
    
    drawnow;
    %Updates figures and processes any pending callbacks.
    end
    else
        imshow(e);
        drawnow;
    end
end
