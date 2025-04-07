% example11_11.m -  Region Growing 
% Marquette University
% Fred J. Frigo, Ph.D.
% 
% Image Processing
%
% See Digital Image Processing, 4th edition - Example 11.11
%
f = imread('breast-implant.tif');  % This is a grayscale image
figure; imagesc(f); colormap('gray'); drawnow;

% The point 300, 300 is located interior to the implant
% Good for Left 2/3 of image (near coil elements)
threshold = 80;
bw_grayconnect1 = grayconnected(f, 300, 300, threshold); 
figure; imshow(bw_grayconnect1); drawnow;

% Good for Right 1/3 of image (far from coil elements)
threshold = 120;
bw_grayconnect2 = grayconnected(f, 300, 300, threshold);
figure; imshow(bw_grayconnect2); drawnow;

% Merge left and right side masks
[rows,cols] = size(f);
implant_mask = zeros(size(f));
implant_index = round(rows*0.64);

% Hyperintensity near breast coil elements causes nonuniformity in image
% Combine mask on left (near coils) with mask on right (away from coils)
implant_mask(:,1:implant_index)   = bw_grayconnect1(:,1:implant_index);
implant_mask(:,implant_index:end) = bw_grayconnect2(:,implant_index:end);
figure; imshow(implant_mask); drawnow;

% Fill in the holes
final_mask = imfill(implant_mask, "holes");
figure; imshow(final_mask); title('Implant Mask');drawnow;

% Draw Boundary line for implant region
gradient = bwperim(final_mask);
gradient = imdilate( gradient, ones(5)); % increase line width of bwperim()   
figure; imshow(gradient); title('Gradient'); drawnow;

% Overlay boundary onto original image
final_image = f;
index = find(gradient > 0);
final_image(index) = 255; drawnow;
figure; imshow(final_image); title("Final Image"); drawnow;