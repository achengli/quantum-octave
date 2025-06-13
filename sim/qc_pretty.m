## -*- texinfo -*-
## @deftypefn {octave_qbits} qc_pretty(@var{qbincomp})
##
## Represents qbit vector or qbit combination vector with pretty syntax for
## better compresion.
##  
## Params:
## @itemize
## @item @var{qbincomp} qbit state
## @end itemize
## 
## @end deftypefn

function qc_pretty(qbincomp)
    if ~exist('qc_defs_loaded'),
        load qc_defs.mat;
    endif
    if nargin < 1 || ~isvector(qbincomp),
        print_usage();
    endif
    qbincomp = qc_ket(qbincomp); N = length(qbincomp);
    str = [];
    for n = 0:N-1
        str = strvcat(str, strcat([' |' dec2bin(n,log2(N)) '>']));
    endfor
    strcat(num2str(qbincomp),str)
endfunction;
