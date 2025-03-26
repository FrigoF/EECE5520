function x = lpc2mat(y,pf)
%LPC2MAT Decompresses a 1-D lossless predictive encoded matrix.
% X = LPC2MAT(Y,PF) decodes input matrix Y based on linear prediction
% coefficients in PF and the assumption of 1-D lossless predictive
% coding. If PF is omitted, filter PF = 1 (for previous pixel coding)
% is assumed.
%
% See also MAT2LPC
% See Digital Image Processing with MATLAB, 3rd edition, page 547

narginchk(1,2);  % Check input arguments
if nargin < 2
   pf = 1;       % Set default filter if omitted
end

pf = pf(end:-1:1);      % Reverse the filter coefficients
[m,n] = size(y);        % Get dimensions of output matri
order = length(pf);     % Get order of linear predictor
pf = repmat(pf,m,1);    % Duplicate filter for vectorizing
x = zeros(m,n + order); % Pad for 1st 'order' column decodes

% Decode the output one column at a time. Compute a prediction based on
% the 'order' previous elements and add it to the prediction error. The
% result is appended to the output matrix being built,
for j = 1:n
   jj = j + order;
   x(:,jj) = y(:,j) + round(sum(pf(:,order:-1:1).* ...
              x(:,(jj- 1):-1:(jj - order)),2));
end
x = x(:,order + 1:end); % Remove left padding