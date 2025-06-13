## -*- texinfo -*-
## @deftypefn {octave_qbits} {@var{qb2_comp} =} qc_bell2comp(@var{qb2_bell})
##
## Conversion from Computational base to Bell base.
## 
## Parameters:
## @itemize
## @item @var{qb2_bell} Vector in bell base. 
## @end itemize
##
## Return:
## @itemize
## @item @var{qb2_comp} Vector in computational base.
## @end itemize
## 
## @ifnottex
## @example
## 
## Implemented circuit.
##
## |BELL> --o--H-- |COMP>
##          |          
## |BELL> --X--I-- |COMP>
## 
## @end example
## @end ifnottex
## @end deftypefn

function qb2_comp=qc_bell2comp(qb2_bell)
    if nargin < 1 || ~ismatrix(qb2_bell),
        print_usage();
    endif
    if !exist('qc_defs_loaded'),
        load qc_defs.mat;
    endif
    qb2_bell = reshape(qb2_bell,length(qb2_bell),1);
    qb2_comp=kron(H,I)*CNOT*qb2_bell;
endfunction

%!demo
%! qc_bell2comp((1/sqrt(2))*[1 0 0 1]')

%!test
%! assert (qc_bell2comp((1/sqrt(2))*[1 0 0 1]') == [1 0 0 0]')
%!test
%! assert (qc_bell2comp((1/sqrt(2))*[0 1 1 0]') == [0 1.0 0 0]')
%!test
%! assert (qc_bell2comp((1/sqrt(2))*[1 0 0 -1]') == [0 0 1.0 0]')
%!test
%! assert (qc_bell2comp((1/sqrt(2))*[0 1 -1 0]') == [0 0 0 1.0]')
