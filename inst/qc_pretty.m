## qc_pretty.m
## Copyright (C) <...>
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
## ---------------------------------------------------------------------
## Represents qbit vector or qbit combination vector with pretty syntax for
## better compresion.
## 
## @param qbincomp ColumnVector # qbit or qbits combination vector.
## ---------------------------------------------------------------------
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
