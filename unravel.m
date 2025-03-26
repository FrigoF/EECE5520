%UNRAVEL Decodes a variable-length bit stream.
% X = UNRAVEL(Y,LINK,XLEN) decodes UINT16 input vector Y based on
% transition and output table LINK. The elements of Y are considered
% to be a contiguous stream of encoded bits--i.e., the MSB of one
% element follows the LSB of the previous element. Input XLEN is the
% number code words in Y, and thus the size of output vector X (class
% DOUBLE). Input LINK is a transition and output table (that drives a
% series of binary searches):
%
% 1. LINK(0) is the entry point for decoding, i.e., state n = 0.
% 2. If LINK(n) < 0, the decoded output is |LINK(n)|; set n = 0.
% 3. If LINK(n) > 0, get the next encoded bit and transition to
% state [LINK(n) - 1] if the bit is 0, else LINK(n).
%
% 'unravel.c' must be compiled as a Matlab Executable (mex) file.
% Note:  MATLAB required C compiler must be installed for mex
%        See:  https://www.mathworks.com/support/compilers
% To compile the C file from the MATLAB command line:
%   >> mex -R2018a unravel.c