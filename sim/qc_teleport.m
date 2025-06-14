## -*- texinfo -*-
## @deftypefn {octave_qbits} {@var{qbout} =} qc_teleport(@var{qba},@var{qbb})
##
## @ifnottex
## @example
##                                                             ______              ___________
##	α₀|0> + α₁|1>	-------------------------------------/ BELL |------+     /  ______M2 \M1
##		            +----------------------+    _____\______|-v    |    /  /      \   \
##        		    |                      |---/        +-------------+/  /        \   \
##		            |                      |-----o------|  Classical  |--     o-----X----Z---- \
##		            |    qc_first_block    |            |    Logic    |                         |==> α₀β₀|00> + α₀β₁|01>
##		            |                      |-----o------|             |--     o-----X----Z---- /     + α₁β₀|10> + α₁β₁|11>
##		            |                      |---\      __+-------------+\  \        /   /
##		            +----------------------+    \____/BELL |--^    |    \  \______/M4 /M3
##	β₀|0> + β₁|1>   -------------------------------------\_____|-------+     \___________/
##
## @end example
## @end ifnottex
##
## Params:
## @itemize
## @item qba Input    α₀|0> + α₁|1>
## @item qbb Input    β₀|0> + β₁|1>
## @end itemize
##
## Return:
## @itemize
## @item qbout Output   α₀β₀|00> + α₀β₁|01> + α₁β₀|10> + α₁β₁|11>
## @end itemize
## @end deftypefn

function out=qc_teleport(qba, qbb)
    if (nargin < 2 || !ismatrix(qba) || !ismatrix(qbb))
        print_usage();
    endif

    if !(exist('qc_defs_loaded'))
        load qc_defs.mat;
    endif
    
    qba = qc_ket(qba); qbb = qc_ket(qbb);
    
    # This is the first input layer, before Bells meter and classic logic block.
    # |qba> ⊗ (|0> + |1>) ⊗ (|0> + |1>) ⊗ (|0> + |1>) ⊗ (|0> + |1>) ⊗ |qbb>

    qc_first_block_qbits = qc_split(qc_first_block());
    inp_bell = qbb;
    for qb_iter = 1:size(qc_first_block_qbits,1),
        inp_bell = kron(qc_first_block_qbits(qb_iter,:)', inp_bell);
    endfor
    inp_bell = kron(qba,inp_bell);

    # We need the individual qbits for the Bells meter. Takes two joint qbits and returns 
    # the equivalent in computational base.

    qb_measured = qc_split(inp_bell);
    qb_measured(qb_measured != 0) = 1;

    # comp_top is the computational output of the first Bells meter block (the top one), 
    # comp_bottom is second one.
    
    comp_top = qc_split(qc_bell2comp([qb_measured(1,:) qb_measured(2,:)]));
    "Entrada al medidor de Bell:"
    [qb_measured(1,:) qb_measured(2,:)]
    "Salida del medidor de Bell en la \"base computacional\":"
    qc_bell2comp([qb_measured(1,:) qb_measured(2,:)])

    comp_bottom = qc_split(qc_bell2comp([qb_measured(5,:) qb_measured(6,:)]));

    # This is a lambda function that returns the first element that find function delivers.
    
    find_first = @(condition) find(condition)(1);

    # Coefficients for the X and Z gates with the CNOT module. This vector will be
    # processed to return back other one with the suit coefficients for the classic logic 
    # block. (*)

    M = [find_first(comp_top(1,:) == max(comp_top(1,:))) - 1; 
            find_first(comp_top(2,:) ==  max(comp_top(2,:))) - 1;
            find_first(comp_bottom(1,:) == max(comp_bottom(1,:))) - 1; 
            find_first(comp_bottom(2,:) == max(comp_bottom(2,:))) - 1
        ];

    # Classic logic block. Generates the M coefficients adapted to the next step.
    
    Mp = qc_classic_logic_block(M)
    M1p = Mp(1);M2p = Mp(2);M3p = Mp(3);M4p = Mp(4);

    # Creates the combinated qbits state to be the input for the last layer.

    qbits_op_in = qc_ket(kron(qb_measured(3,:), qb_measured(4,:)));

    # Finally returns the result of operate the X and Z gates layer to the previous input.

    out = kron(Z^M1p * X^M2p, Z^M3p * X^M4p) * qbits_op_in;
endfunction

# (*) As you can see, I did some fits for the output of find, that is because the matrix
#   that represents the gates only takes 0 or 1 as input, for that I did a search to find the
#   vector elements that are diferent from 0, that means that if the result is 1 means that 
#   the qbit |0> is not 0 and then substracting 1 to the localization, the final result is 0,
#   means that we have to elevate by 0 the matrix X or Z according to the coefficient that we
#   are treating on.

%!demo
%! disp(qc_teleport([1,0],[1,0]))

%!test
%! assert(qc_teleport([1 0],[0 1]) == .5*[0 1 0 0]')
