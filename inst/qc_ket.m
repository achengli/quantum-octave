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
## @deftypefn {octave_qbits} {@var{qb} =} qc_ket (@var{qb})
##
## Checks if it is a column key and if it is then returns the vector normalized, 
## if not then returns the transpose normalized
## 
## Params:
## @itemize
## @item @qcode{@var{qb}} qbit state.
## @end itemize
## 
## Return:
## @itemize
## @item @qcode{@var{qb}} qbit state as a column row normalized.
## @end itemize
## 
## @end deftypefn

function qb = qc_ket(qb) 
    if nargin < 1 && ~isvector(qb),
        print_usage();
    endif
    if (norm(qb) != 0)
        qb = qb ./norm(qb);
    endif
    if (size(qb,1) != length(qb)),
        qb = reshape(qb,length(qb),1);       % create column vector.
    endif
endfunction;
