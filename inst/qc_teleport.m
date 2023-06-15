## Copyright (C) 2023 Yassin Achengli <relifenatu@gmail.com>
## Copyright (C) 2023 Jesús Bravo <js_bravo98@uma.es>
##
## This program is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*-
## @deftypefn {octave_qbits} {@var{qbout} =} qc_teleport(@var{qba},@var{qbb})
##
## @ifnottex
## @example
##                                                              ______              ___________
##	α₀|0> + α₁|1>	--------------------------------------/ BELL |------+     /  ______M2 \M1
##		            +-----------------------+    _____\______|-v    |    /  /      \   \
##        		    |                       |---/        +-------------+/  /        \   \
##		            |                       |-----o------|  Classical  |--     o-----X----Z---- \
##		            |    qc_first_block     |            |    Logic    |                         |==> α₀β₀|00> + α₀β₁|01> + α₁β₀|10> + α₁β₁|11>
##		            |                       |-----o------|             |--     o-----X----Z---- /
##		            |                       |---\      __+-------------+\  \        /   /
##		            +-----------------------+    \____/BELL |--^    |    \  \______/M4 /M3
##	β₀|0> + β₁|1>   --------------------------------------\_____|-------+     \___________/
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

function out=qc_teleport_final(qba, qbb)
    if (nargin < 2 || !ismatrix(qba) || !ismatrix(qbb))
        print_usage();
    endif

    if !(exist('qc_defs_loaded'))
        load qc_defs.mat;
    endif
    
    qba = qc_ket(qba); qbb = qc_ket(qbb);
    
    # This is the first input layer, before Bells meter and classic logic block.
    inp_bell = kron(qba, kron(qc_first_block(), qbb));
    # We need the individual qbits for the Bells meter. Takes two joint qbits and returns 
    # the equivalent in computational base.
    qb_measured = qc_split(inp_bell);
    # comp_top is the computational output of the first Bells meter block (the top one), 
    # comp_bottom is second one.
    comp_top = qc_split(qc_bell2comp([qb_measured(1,:) qb_measured(2,:)]));
    comp_bottom = qc_split(qc_bell2comp([qbits_measured(5,:) qbits_measured(6,:)]));

    # This is a lambda function that returns the first element that find function delivers.
    find_first = @(condition) find(condition)(1);

    # Coefficients for the X and Z gates with the CNOT module. This vector will be
    # processed to return back other one with the suit coefficients for the classic logic 
    # block. (*)
    M = [find_first(comp_top(1,:) != 0) - 1; find_first(comp_top(2,:) != 0) - 1;
        find_first(comp_bottom(1,:) != 0) - 1; find_first(comp_bottom(2,:) != 0) - 1
    ];

    # Classic logic block. Generates the M coefficients adapted to the next step.
    Mp = qc_classic_logic_block(M);
    M1p = Mp(1);M2p = Mp(2);M3p = Mp(3);M4p = Mp(4);

    # Creates the combinated qbits state to be the input for the last layer.
    qbits_op_in = qc_ket(kron(qb_measured(3,:), qb_measured(4,:)));
    # Finally returns the result of operate the X and Z gates layer to the previous input.
    out = kron(Z^Mp1 * X^Mp2, Z^Mp3 * X^Mp4) * qbits_op_in;
endfunction

# (*) As you can see, I did some fits for the output of find, that is because the matrix
# that represents the gates only takes 0 or 1 as input, for that I did a search to find the
# vector elements that are diferent from 0, that means that if the result is 1 means that 
# the qbit |0> is not 0 and then substracting 1 to the localization, the final result is 0, means that we have to elevate by 0 the matrix X or Z according to the coefficient that we are 
# treating on.

