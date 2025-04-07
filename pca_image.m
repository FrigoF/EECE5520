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
figure, imagesc(I); drawnow;

X = reshape(double(I),size(I,1)*size(I,2),3);

coeff = pca(X);
Itransformed = X*coeff;

Ipc1 = reshape(Itransformed(:,1),size(I,1),size(I,2));
Ipc2 = reshape(Itransformed(:,2),size(I,1),size(I,2));
Ipc3 = reshape(Itransformed(:,3),size(I,1),size(I,2));

figure, imshow(Ipc1,[]);drawnow;
figure, imshow(Ipc2,[]);drawnow;
figure, imshow(Ipc3,[]);drawnow;