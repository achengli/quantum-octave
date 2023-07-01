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
function qbits = qc_reversekron(qbin)
    if (nargin < 1 || !ismatrix(qbin))
        print_usage();
    endif
    
    qbin = qc_ket(qbin);
    valued_indexes = dec2bin(find(qbin != 0),size(log2(size(qbin,1)),1));
    qbits = [];
    for idx = 1:size(valued_indexes,2)
        valued_indexes(:,idx)
        spin_0 = find(strcmp(valued_indexes(:,idx),'0'));
        spin_1 = find(strcmp(valued_indexes(:,idx),'1'));
        spin_0 = sum(qbin(spin_0));
        spin_1 = sum(qbin(spin_1));
        qbits = [qbits; qc_ket([spin_0, spin_1])];
    endfor
endfunction
