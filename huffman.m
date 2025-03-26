function CODE = huffman(p)
%HUFFMAN Builds a variable-length Huffman code for a symbol source.
% CODE = HUFFMAN(P) returns a Huffman code as binary strings in cell
% array CODE for input symbol probability vector P. Each word in CODE
% corresponds to a symbol whose probability i s at the corresponding
% index of P.
% Based on huffmanS by Sean Danaher, University of Northumbria,
% Newcastle UK. Available at the MATLAB Central File Exchange:
% Category General DSP in Signal Processing and Communications.
% Check the input arguments for reasonableness.
%
% See Digital Image Processing with MATLAB, 3rd edition, page 526

narginchk(1,1);
if (~ismatrix(p)) || (min(size(p)) > 1) || ~ isreal(p ) ...
        || ~isnumeric(p)
    error('P must be a real numeric vector. ' ) ;
end
% The CODE variable is shared with the CODE variable in the nested
% function makecode. See Chapter 3 of DIPUM3E for a discussion of nested
% functions.
CODE = cell(length(p),1);  % Init the global cell array
if length(p) > 1
   p = p/sum(p);
   s = reduce(p);
   makecode(s,[]);
else
   CODE = {'1'};
end

%......................................................................................................................... .......................%
function makecode(sc,codeword)
% Scan the nodes of a Huffman source reduction tr e e recursively to
% generate the indicated variable length code words.
if isa( sc, 'cell' )
   makecode(sc{1},[codeword 0]);
   makecode(sc{2},[codeword 1]);
else
   CODE{sc} = char('0' + codeword); % create a char code string
end
end
end

%...................................................................................................................................................
function s = reduce(p)
% Create a Huffman source reduction tree in a MATLAB cell structure
% by performing source symbol reductions until there are only two
% reduced symbols remaining
s = cell( length(p), 1 );
% Generate a starting tree with symbol nodes 1, 1, 3, . . . to
% reference the symbol probabilities ,
for i = 1:length(p)
   s {i} = i;
end
while numel(s) > 2
  [p, i ] = sort(p);    % Sort the symbol probabilities
   p(2) = p (1) + p(2); % Merge the 2 lowest probabilities
   p(1) = [];           % and prune the lowest one

   s = s(i);            % Reorder tr e e for new probabilities
   s{2} = {s{1}, s{2}}; % and merge & prune its nodes
   s(1) = [] ;          % to match the probabilities
end
end