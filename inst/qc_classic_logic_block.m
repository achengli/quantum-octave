function Mout=qc_classic_logic_block(M)
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
## 
##			   M1      M2 
##			   |       |
##			+-------------+
##			|             | ---> M'1
##			|  Classical  | ---> M'2
##			|    Logic    | ---> M'3
##			|             | ---> M'4
##			+-------------+
##			   |       |
##			   M3      M4
    if nargin<1 || ~ismatrix(M) || length(M) ~= 4
        print_usage();
    endif
    M = reshape(M,4,1);
    if ~exist('qc_defs_loaded'), 
        load qc_defs.mat;
    endif
    if ~exist('M_coefs_loaded'),
        load M_coefs.mat;
    endif
    index = sum((2.^[3 2 1 0]') .* M)+1;
    Mout=Mp_m(index,:)';
endfunction;
