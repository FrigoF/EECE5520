% example11_11.m -  Region Growing 
% Marquette University
% Fred J. Frigo, Ph.D.
% 
% Image Processing
%
% See Digital Image Processing, 4th edition - Example 11.11
%
f = imread('breast-implant.tif');  % This is a grayscale image
figure; imagesc(f); colormap('gray'); title('Original Image');drawnow;
[rows, cols] = size(f);

% Create a magnitude ramp to compensate for brighter pixels near coils
% Intensity correction values from left to right determined empirically
intensity_correct = zeros(rows, cols);
intensity_correct_row = linspace(0.75, 12.0, cols); % from 0.75 to 12.0
for i=1:rows
  intensity_correct(i,:) = intensity_correct_row;
end
figure; imshow(intensity_correct, []); title('Intensity Correction');drawnow;

f1 = double(f).*intensity_correct;
figure; imshow(f1, []); title('Intensity Corrected');drawnow;

% Gaussian low pass filter
im_scale = 255.0/(max(max(f1)));
f2 = uint8(round((f1*im_scale)));
lpf_gray = imgaussfilt(f2,8); % 8 is determined empirically
figure; imshow(lpf_gray); title('Gaussian filtered image');drawnow;

% The point 300, 300 is located interior to the implant
threshold = 60; % 60 is determined empirically
xcoord = 300; ycoord = 300;
bw_implant = grayconnected(lpf_gray, xcoord, ycoord, threshold); 
figure; imshow(bw_implant); title('Implant Mask'); drawnow;

% Draw Boundary line for implant region
gradient = bwperim(bw_implant);
gradient = imdilate( gradient, ones(5)); % increase line width of bwperim()   
figure; imshow(gradient); title('Gradient'); drawnow;

% Overlay boundary onto original image
final_image = f;
index = find(gradient > 0);
final_image(index) = 255; drawnow;
figure; imshow(final_image); title("Final Image"); drawnow;