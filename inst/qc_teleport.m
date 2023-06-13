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
## @deftypefn {octave_qbits} {@var{qbout} =} qc_teleport(@var{qbin},@var{qbin2})
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
## @item qbin Input     α₀|0> + α₁|1>
## @item qbin2 Input    β₀|0> + β₁|1>
## @end itemize
##
## Return:
## @itemize
## @item qbout Output   α₀β₀|00> + α₀β₁|01> + α₁β₀|10> + α₁β₁|11>
## @end itemize
## @end deftypefn

function qbout=qc_teleport(qbin1, qbin2)
    if (nargin < 2 || !ismatrix(qbin1) || !ismatrix(qbin2))
        print_usage();
    endif
    qbin1 = qc_ket(qbin1); qbin2 = qc_ket(qbin2);
    input_bell = kron(qbin1, kron(qc_first_block(),qbin2));
    
    function out=qc_split(qbin)
        qbin = qc_ket(qbin);
        N = ceil(log2(size(qbin,1)));
        out = zeros(N,2);
        qbin_str = dec2bin([1:size(qbin,1)]');
        for iter = 1:N,
            out(iter,:) = qc_ket([sum(qbin(find(str2num(qbin_str(:,iter)) == 0))), ...
                                sum(qbin(find(str2num(qbin_str(:,iter)) == 1)))])';
        endfor
    endfunction;

    qbits_measured = qc_split(input_bell);
    
    comp_top = qc_split(qc_bell2comp([qbits_measured(1,:) qbits_measured(2,:)]));
    comp_bottom = qc_split(qc_bell2comp([qbits_measured(5,:) qbits_measured(6,:)]));
    
    M2 = (find(comp_top(1,:) == max(comp_top(1,:))) - 1)(1);
    M1 = (find(comp_top(2,:) == max(comp_top(2,:))) - 1)(1);
    M4 = (find(comp_bottom(1,:) == max(comp_bottom(1,:))) - 1)(1);
    M3 = (find(comp_bottom(2,:) == max(comp_bottom(2,:))) - 1)(1);
    M = [M1,M2,M3,M4];
    Mp = qc_classic_logic_block(M);
    M1p = Mp(1);M2p = Mp(2);M3p = Mp(3);M4p = Mp(4);

    load qc_defs.mat;
    qbits_op_in = qc_ket(kron(qbits_measured(3,:),qbits_measured(4,:)));
    qbout = kron(X.^M2p * Z.^M1p,X.^M4p * Z.^M3p) * qbits_op_in;
endfunction;
