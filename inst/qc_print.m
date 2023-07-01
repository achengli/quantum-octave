function [void] = qc_print(qbin, gui)
##    Prints the qbit result in a beautiful way and can be expressed in 
##    a GUI format.
    if (nargin < 2 && type(qbin) == 'matrix')
        gui = false;
    elseif (nargin < 1)
        print_usage();
    endif

    if (type(gui) != 'scalar' || type(qbin) != 'matrix')
        print_usage();
    endif

    if (!gui)
        if (!exist('qc_defs_loaded')
            load qc_defs.mat;
        endif
        fig = figure;
    else
        qbincomp = qc_ket(qbin); N = length(qbincomp);
        str = [];
        for n = 0:N-1
            str = strvcat(str, strcat([' |' dec2bin(n,log2(N)) '>']));
        endfor
        strcat(num2str(qbincomp), str);
endfunction
