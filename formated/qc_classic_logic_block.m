## -*- texinfo -*-
## @deftypefn {octave_qbits} {@var{Mout} =} qc_classic_logic_block (@var{M})
## 
## @ifnottex
## @example
## @group
##			   M1      M2 
##			   |       |
##			+-------------+
##			|             | ---> M'1
##			|  Classical  | ---> M'2
##			|    Logic    | ---> M'3
##			|             | ---> M'4
##			+-------------+
##			   |       |
##			   M3      M4
## @end group
## @end example
## @end ifnottex
## 
## Converts M coeficients to M" mapping them according to the responses that 
## the second block retrieves without CNOT blocks. 
## 
## Params:
## @itemize
## @item @var{M} Vector of unsigned with original coefficients.
## @end itemize
## 
## Return:
## @itemize
## @item @var{Mout} Vector equivalent coefficients.
## @end itemize

function Mout=qc_classic_logic_block(M)
    if (nargin!=1 || !ismatrix(M) || length(M) != 4),
        print_usage();
    endif
    M = reshape(M,4,1);
    if ~exist('qc_defs_loaded'), 
        load qc_defs.mat;
    endif
    if ~exist('M_coefs_loaded'),
        load M_coefs.mat;
    endif
    index = sum((2.^[3 2 1 0]') .* M)+1;
    Mout=Mp_m(index,:)';
endfunction;

%! assert(qc_classic_logic_block([ 0 0 0 0]') == [0 1 0 1]')
%! assert(qc_classic_logic_block([ 0 0 1 1]') == [1 1 1 0]')
%! assert(qc_classic_logic_block([ 0 1 0 0]') == [0 1 0 1]')
%! assert(qc_classic_logic_block([ 0 0 1 0]') == [1 1 1 1]')
