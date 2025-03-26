function y = mat2lpc(x,pf)
%MAT2LPC Compresses a matrix using 1-D lossles predictive coding.
% Y = MAT2LPC(XjPF) encodes matrix X using 1-D lossless predictive
% coding. A linear prediction of X is made based on the coefficients
% in PF. If PF is omittedj PF = 1 (for previous pixel coding) is
% assumed. The prediction error is then computed and output as encoded
% matrix Y.
%
% See also LPC2MAT.
% See Digital Image Processing with MATLAB, 3rd edition, page 546

narginchk(1,2);   % Check input arguments
if nargin < 2
   pf = 1;        % Set default filter if omitted
end

x = double(x);
[m,n] = size(x);
p = zeros(m,n);
xs = x; zc = zeros(m,1);

for j = 1:length(pf)          % For each filter coefficient
   xs = [zc xs(:,1:end - 1)]; % Shift and zero pad x
   p = p + pf(j)*xs;          % Form partial prediction sums
end

y = x - round(p);             % Compute prediction error y