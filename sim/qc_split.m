## -*- texinfo -*-
## @deftypefn {octave_qbits} {@var{out} =} qc_split(@var{qbin})
##
## Returns the vector of combinated qbits spliting each qbit one by one
## saving them into out (each row is a qbit and has 2 columns).
##
## Params:
## @itemize
## @item qbin Vector
## @end itemize
##
## Return:
## @itemize
## @item qbout Output  Matrix
## @end itemize
## @end deftypefn

function out=qc_split(qbin)
    qbin = qc_ket(qbin);
    N = ceil(log2(size(qbin,1)));
    out = zeros(N,2);
    qbin_str = dec2bin([0:(size(qbin,1)-1)]');
    for iter = 1:N,
        out(iter,:) = qc_ket([sum(qbin(find(str2num(qbin_str(:,iter)) == 0))), ...
                 sum(qbin(find(str2num(qbin_str(:,iter)) == 1)))])';
    endfor
    out = out ./ max(out);
endfunction;


