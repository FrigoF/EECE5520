% textural_segmentation.m -  Textural Segmentation
% Marquette University
% Fred J. Frigo, Ph.D.
% 
% Image Processing
% See Digital Image Processing, 4th edition, Fig 9.45
%

% Enter name of image file
ifile = "";
if(ifile == "")
    [fname, pname] = uigetfile('*.*', 'Select image file');
    ifile = strcat(pname, fname);
end

% Read image and convert to grayscale if this is a color image
info = imfinfo(ifile);
rows = info.Width; cols = info.Height; % image size
raw_image = imread(ifile);
if (info.ColorType ~= "grayscale")
    input_image = rgb2gray(raw_image);
else
    input_image = raw_image;
end
figure; imagesc(input_image); colormap('gray'); title("input image"); drawnow;

% Determine disk radii of structure elements empirically by image size
disk_radius_small = round(cols/22);  
disk_radius_large = disk_radius_small*2; 
struct_element_small = strel('disk', disk_radius_small, 0);
struct_element_large = strel('disk', disk_radius_large, 0);

% Remove small circles
no_small = imclose( input_image, struct_element_small);drawnow;
figure; imshow(no_small); title('No Small Circles'); drawnow;

% Connect large circles creating region where they exist
large_region = imopen( no_small, struct_element_large); drawnow;
figure; imshow(large_region); title('No Large Circles'); drawnow;

% Manually pick a seed point inside region based on image size
seed1 = round(rows/3); seed2 = round(cols/3);
small_region = grayconnected(large_region, seed1, seed2);
gradient = bwperim(small_region);
gradient = imdilate( gradient, ones(5)); % increase line width of bwperim()   
figure; imshow(gradient); title('Gradient'); drawnow;

% Remove edge boundary on left hand side if present
gradient(:,1:80)=0;
% Remove edge boundaries at top & bottom of image
gradient(1:30,1:round(rows/3))=0;
gradient(cols-30:cols,1:round(rows/3))=0;

% Overlay boundary onto original image
final_image = input_image;
index = find(gradient > 0);
final_image(index) = 255; drawnow;
figure; imshow(final_image); title("Final Image"); drawnow;