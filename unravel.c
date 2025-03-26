/* ========================================================
* unravel.c
* Decodes a variable length coded bit sequence (a vector of
* 16-bit integers) using a binary sort from the MSB to the LSB
* (across word boundaries) based on a transition table.a
*
* See Digital Image Processing with MATLAB, 3rd edition, page 538
*
* =========================================================*/
#include <mex.h>
#include <matrix.h>
void unravel(uint16_T *hx, double *link, double *x, double xsz, int hxsz)
{
   int i = 15, j = 0, k = 0, n = 0;
   while (xsz - k) {
      if (*(link + n) > 0) {
         if ((*(hx + j) >> i) & 0x0001)
            n = *(link + n);
         else n = *(link + n) - 1;
         if (i) i--; else {j++; i = 15;}
         if (j > hxsz)
            mexErrMsgIdAndTxt("DIPUM:TooFewBits","Out of code bits ???");
      }
      else {
          *(x + k++) = - *(link + n);
          n = 0; }
      }
      if (k == xsz - 1)
         *(x + k++) = - *(link + n);
}

void mexFunction( int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
    double *link, *x,  xsz;
    uint16_T  *hx; 
    int hxsz;

    /* Check inputs for reasonableness */
    if (nrhs != 3)
       mexErrMsgIdAndTxt("DIPUM:ThreeInputs","Three inputs required.");
    else if (nlhs > 1)
       mexErrMsgIdAndTxt("TooManyOutputs", "Too many output arguments.");

   /* Is last input argument a scalar? */
   if(!mxIsDouble(prhs[2]) || mxIsComplex(prhs[2]) || mxGetN(prhs[2]) * mxGetM(prhs[2]) != 1)
       mexErrMsgIdAndTxt("DIPUM:NonscalarXSize", "Input XSIZE must be a scalar.");

   /* Create input matrix pointers and get scalar */
   hx = mxGetUint16s(prhs[0]);
   link = mxGetDoubles(prhs[1]);
   xsz = mxGetScalar(prhs[2]); /* returns DOUBLE */

   /* Get the number of elements in hx */
   hxsz = mxGetM(prhs[0]);

   /* Create 'xsz' x 1 output matrix */
   plhs[0] = mxCreateDoubleMatrix(xsz, 1, mxREAL);

   /* Get C pointer to a copy of the output matrix */
   x = mxGetDoubles(plhs[0]);

   /* Call the C subroutine */
   unravel(hx, link, x, xsz, hxsz);
}
