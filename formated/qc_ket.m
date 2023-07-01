## -*- texinfo -*-
## @deftypefn {octave_qbits} {@var{qb} =} qc_ket (@var{qb})
##
## Checks if it is a column key and if it is then returns the vector normalized, 
## if not then returns the transpose normalized
## 
## Params:
## @itemize
## @item @qcode{@var{qb}} qbit state.
## @end itemize
## 
## Return:
## @itemize
## @item @qcode{@var{qb}} qbit state as a column row normalized.
## @end itemize
## 
## @end deftypefn

function qb = qc_ket(qb) 
    if nargin < 1 && ~isvector(qb),
        print_usage();
    endif
    if (norm(qb) != 0)
        qb = qb ./norm(qb);
    endif
    if (size(qb,1) != length(qb)),
        qb = reshape(qb,length(qb),1);       % create column vector.
    endif
endfunction;
