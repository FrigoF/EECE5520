% mr_image_histogram.m - Display histogram of MR Image
%
% Fred J. Frigo
% Marquette University
% Feb 2025


% Display Histogram of MR image
function mr_image_histogram(dfile)

  if nargin == 0
      [fname, pname] = uigetfile('*.*', 'Select DICOM image File');
      dfile = strcat(pname, fname);
  end
   
  % DICOM read image
  dimage = dicomread( dfile);
  figure;
 
  % Get DICOM info from input image.
  info = dicominfo(dfile);
  msg = sprintf('Window width = %d, Window level = %d', ...
            info.WindowWidth, info.WindowCenter);  
  title(msg);
  imshow( dimage, [0 info.WindowWidth]);  % Display range from 0 to WW
  title(msg);  drawnow;
  
  % Display Histogram
  figure;
  imhist(dimage);
  title("Image Histogram"); drawnow;
end