## -*- texinfo -*-
## @deftypefn @qcode{@var{out} =} qc_second_block (@var{qbin}, @var{M})
##
## Intermediate block of the teleport circuit. This block is after the first_block and before
## the bell predictor.
## 
## @ifnottex
## @example
##		         M2    M1
##		          |    |
##		----o-----X----Z-----o-----
##		    |                |
##		----X-----X----Z-----X-----
##		          |    |
##		         M4    M3
## @end example
## @end ifnottex
##
## Params:
## @itemize
## @item @var{qbin} input qbit state
## @item @var{M} circuit coefficients 
## @end itemize
##
## Return:
## @itemize
## @item @var{out} result after the circuit
## @end itemize
## 
## @seealso{qc_second_block_noCNOT}
## @end deftypefn

function out = qc_second_block(qb_in,M)
    if (nargin < 2 || length(M) < 4),
        print_usage();
    endif
    reshape(M,4,1);

    if ~exist('qc_defs_loaded'),
        load qc_defs.mat;
    endif    

    M1=M(1);M2=M(2);M3=M(3);M4=M(4);
    op = CNOT*kron((Z^M1) * (X^M2),(Z^M3) * (X^M4))*CNOT;
    out = qc_ket(op*qb_in);
endfunction;
