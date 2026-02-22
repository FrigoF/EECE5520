% back_projection.m -  Back Projection as used in CT Reconstruction
% Marquette University
% Fred J. Frigo, Ph.D.
% 
% Image Processing
% See Digital Image Processing with MATLAB, 3rd edition, example 5.13 
%

im_size = 600;
im = phantom('Modified Shepp-Logan',im_size);
figure();
imshow(im);
title('Modified Shepp Logan Phantom');drawnow;

% Create a set of fan beam projections (views) from the phantom image
D = 1.5*hypot(im_size,im_size)/2;
ct_view = fanbeam(im, D, 'FanSensorGeometry','arc',...
          'FanSensorSpacing',0.1,'FanRotationIncrement',0.4);
view_vs_chan = flipud(ct_view');
figure;
imshow(view_vs_chan, []);
title('Views vs Channels'); drawnow;

% Perform back projection using a Hamming window as a deconvolution kernel
ct_image = ifanbeam(ct_view, D,'FanRotationIncrement', 0.4, ...
    'FanSensorSpacing', 0.1, 'Filter','Hamming');
figure;
imshow(ct_image,[]);
title('CT Image from filtered backprojection'); drawnow;
