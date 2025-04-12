% pca_image.m -  Principal Component Analysis for color image
%
% Marquette University
% Fred J. Frigo, Ph.D.
% 
% Image Processing
%
% This script uses the MATLAB demo image: peppers.png
%      It can be found in the followign directory:
%      >>  which peppers.png -all

I = imread('peppers.png');
figure, imagesc(I); title('Original Image'); drawnow;

X = reshape(double(I),size(I,1)*size(I,2),3);

coeff = pca(X);
Itransformed = X*coeff;

Ipc1 = reshape(Itransformed(:,1),size(I,1),size(I,2));
Ipc2 = reshape(Itransformed(:,2),size(I,1),size(I,2));
Ipc3 = reshape(Itransformed(:,3),size(I,1),size(I,2));

drawnow;
figure, imshow(Ipc1,[]); title('PCA image 1'); drawnow;
figure, imshow(Ipc2,[]); title('PCA image 2'); drawnow;
figure, imshow(Ipc3,[]); title('PCA image 3'); drawnow;

% Re-assemble PCA component images as psuedo color image
% Create psuedo red, green and blue component images
R = im_scale(Ipc1);
G = im_scale(Ipc2);
B = im_scale(Ipc3);

% Recombine PCA component images into a color image
psuedo_color = cat( 3, R, G, B);
figure();
imshow( psuedo_color);
title('Psuedo Color Image formed from PCA');  drawnow;


% Function to scale PCA images to 8 bit
function scaled_image = im_scale(input_image)
  
   input_min=min(min(input_image));
   if input_min < 0
      input_image = input_image + abs(input_min);
   else
      input_image = input_image - input_min;
   end
   input_max = max(max(input_image)); 
   if input_max == 0.0
      input_max = 1.0;
   end
   scale_factor = 255.0/input_max;
   scaled_image = uint8(input_image*scale_factor);
end