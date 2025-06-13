## -*- texinfo -*-
## @deftypefn {octave_qbits} @qcode{@var{out} =} qc_second_block_noCNOT (@var{qbin}, @var{M})
##
## Intermediate block of the teleport circuit without CNOT blocks. This block
## is used to obtain results representing how will be the output if we removed
## CNOT blocks.
## 
## @ifnottex
## @example
##		         M2    M1
##		          |    |
##		     -----X----Z-----
##		                    
##		     -----X----Z-----
##		          |    |
##		         M4    M3
## @end example
## @end ifnottex
##
## Params:
## 
## @itemize
## @item @var{qbin}
## @item @var{M}
## @end itemize
## 
## Return:
## 
## @itemize
## @item @var{out}
## @end itemize
##
## @seealso{qc_defs_generator}
## @end deftypefn

function out=qc_second_block_noCNOT(qbin,M)
if (nargin < 2 || length(M) < 4),
        print_usage();
    endif
    reshape(M,4,1);
    
    if ~exist('qc_defs_loaded'),
        load qc_defs.mat;
    endif    

    M1=M(1);M2=M(2);M3=M(3);M4=M(4);
    op = kron((Z^M1) * (X^M2),(Z^M3) * (X^M4));
    out = qc_ket(op*qbin);
endfunction;
