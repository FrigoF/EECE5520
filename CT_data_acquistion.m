% CT_data_acquisition.m -  CT Data Acquisition
% Marquette University
% Fred J. Frigo, Ph.D.
% 
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

