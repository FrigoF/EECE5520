function rmse = compare(f1,f2,scale)
%COMPARE Computes and displays the error between two matrices.
% RMSE = C0MPARE(F1,F2,SCALE) returns the root-mean-square error
% between inputs FI and F2, displays a histogram of the difference,
% and displays a scaled difference image. When SCALE is omitted, a
% scale factor of 1 is used. When SCALE is 0 or negative, histogram
% and image output is suppressed even if there is a nonzero RMSE.
%
% See Digital Image Processing with MATLAB, 3rd edition, page 520

% Check input arguments and set defaults.
narginchk(2,3)
if nargin < 3
  scale = 1;
end

% Compute the root-mean-square error
e = double (f1) - double(f2);
[m,n] = size(e);
rmse = sqrt(sum(e(:).^2)/(m*n));

% Output error image & histogram if an error (rmse ~= 0) & scale > 0.
if rmse && ( scale > 0)
   % Form error histogram,
   emax = max(abs(e(:)));
   [h,x] = histcounts(e(:),emax);
   if length(h) >= 1
     figure; bar(x(1:end-1),h,'k' );
     % Scale the error image symmetrically and display
     emax = emax / scale;
     e = mat2gray(e, [-emax, emax]);
     figure; imshow(e);
   end
end