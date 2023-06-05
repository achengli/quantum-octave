function qb2_comp=qc_bell2comp(qb2_bell)
## qc_classic_logic_block.m
## Copyright (C) Yassin Achengli <relifenatu@gmail.com> and Jesús Bravo <js_bravo98@uma.es>
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
## --------------------------------------------------------------------
## function qb2_comp=qc_bell2comp(qb2_bell);
## Conversion from Computational base to Bell base.
##
## @param qb2_bell Vector # Input vector in the Bell base.
## @return Vector # Computational equivalent.
##
## Implemented circuit.
##
## |BELL> --o--H-- |COMP>
##          |          
## |BELL> --X--I-- |COMP>
## 
## --------------------------------------------------------------------
    if nargin < 1 || ~ismatrix(qb2_bell),
        print_usage();
    endif
    if ~exist('qc_defs_loaded'),
        load qc_defs.mat;
    endif
    qb2_comp=kron(H,I)*CNOT*qc_ket(qb2_bell);
endfunction

%! assert (qc_bell2comp((1/sqrt(2))[1 0 0 1]') == [1.0 0 0 0]')
%! assert (qc_bell2comp((1/sqrt(2))[0 1 1 0]') == [0 1.0 0 0]')
%! assert (qc_bell2comp((1/sqrt(2))[1 0 0 -1]') == [0 0 1.0 0]')
%! assert (qc_bell2comp((1/sqrt(2))[0 1 -1 0]') == [0 0 0 1.0]')
