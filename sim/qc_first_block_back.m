## -*- texinfo -*-
## @deftypefn {octave_qbits} {@var{out} =} qc_first_block ()
##
## This block generates the 4 combinated qbits state with each of the four 
## qbits as |0>. The combination returns a 4x1 column vector with a normalized
## state.
## 
## @ifnottex
## @example
##			|0> ---H-----o-----I----- | 
##			             |            |
##			|0> ---I-----X-----o----- |
##			                   |      |==> out
##			|0> ---I-----X-----X----- |
##			             |            |
##			|0> ---H-----o-----I----- |
## @end ifnottex
## @end example
##
## Params:
## @itemize
## @item @qcode{@var{out}} qbit state in question.
## @end itemsize
## @seealso{qc_second_block,qc_second_block_noCNOT}
## @end deftypefn
function out = qc_first_block()
    if ~exist('qc_defs_loaded'),
        load qc_defs.mat;
    endif
    qb0 = [1;0];
    qc0 = kron(qb0, kron(qb0, kron(qb0,qb0)));
    CNOTi = [1 0 0 0; 
            0 0 0 1; 
            0 0 1 0; 
            0 1 0 0];
    op1 = kron(kron(H,I),kron(I,H));
    op2 = kron(CNOT, CNOTi);
    op3 = kron(I, kron(CNOT, I));

    out = op3 * op2 * op1 * qc0;
    out = out ./ max(out);
endfunction;

%!demo
%! "Salida sin normalizar:"
%! qc_first_block()
%! "Salida normalizada:"
%! qc_ket(qc_first_block())
%! "Qbits separados:"
%! qc_split(qc_first_block())
%! "Qbits separados sin normalizar:"
%! k = qc_split(qc_first_block());
%! k ./ max(k)
