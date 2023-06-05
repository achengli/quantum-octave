function M=qc_classic_logic_block(qb_in,M)
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
    if nargin<2 || ~isvector(qb_in) || is_vector(M),
        print_usage();
    endif
    Mp = M; % temporal M allocator.
    if ~exist('qc_defs_loaded'), 
        load qc_defs.mat;
    endif
    load M_coefs.mat;
    if ~M_coefs_loaded,
        error('Fatal error: Could not import data.');
    endif

    index=find(M(,:)' == M_m);
    M=M_m(index,:)';
endfunction;
