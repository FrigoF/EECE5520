function ffilter = fermi(xdim, ydim, cutoff, trans_width)
% FERMI creates a 2D Fermi filter.
%   FFILTER = FERMI(XDIM,YDIM,CUTOFF,TRANS_WIDTH) calculates a 2D
%     Fermi filter on a grid with dimensions XDIM * YDIM. 
%    The cutoff frequency is defined by CUTOFF and represents
%     the radius (in pixels) of the circular symmetric function   
%     at which the amplitude drops below 0.5
%    TRANS_WIDTH defines the width of the transition. 
%
%    Author: Wally Block, UW-Madison  02/23/01. 
%            Fred Frigo, @MarquetteU  10/18/20 - support for non circular 
%
%    Call: ffilter = fermi(xdim, cutoff, trans_width);

[X,Y] = meshgrid(-xdim/2:1:(xdim/2 -1),-ydim/2:1:(ydim/2 -1)); 
radius = [X.^2 + Y.^2].^0.5;
ffilter_tmp = 1./(1 + exp((radius -cutoff)/trans_width));

% center fermi filter in square matrix if xdim ~= ydim
if xdim == ydim
    ffilter(:,:) = ffilter_tmp(:,:);
elseif xdim > ydim
    ffilter=zeros(xdim);
    ffilter(1:ydim,:) = ffilter_tmp(:,:);
else % ydim > xdim
    ffilter=zeros(ydim);
    ffilter(:,1:xdim) = ffilter_tmp(:,:);
end

