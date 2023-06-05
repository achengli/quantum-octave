function out=qc_second_block_noCNOT(qbin,M)
## qc_first_block.m
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
## ------------------------------------------------------------------------
## Intermediate block of the teleport circuit without CNOT blocks. This block
## is used to obtain results representing how will be the output if we removed
## CNOT blocks.
##
##		         M2    M1
##		          |    |
##		     -----X----Z-----
##		                    
##		     -----X----Z-----
##		          |    |
##		         M4    M3
## 
## @param qbin ColumnVector # ...
## @param M UnsignedVector # ...
## @returns ColumnVector
## -------------------------------------------------------------------
if (nargin < 2 || length(M) < 4),
        print_usage();
    endif
    reshape(M,4,1);
    
    if ~exist('qc_defs_loaded'),
        load qc_defs.mat;
    endif    

    M1=M(1);M2=M(2);M3=M(3);M4=M(4);
    op = kron((X^M2) * (Z^M1),(X^M4) * (Z^M3));
    out = qc_ket(op*qbin);
endfunction;
