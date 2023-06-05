## qc_ket.m
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

function qb = qc_ket(qb)
    % function qb = qc_ket(qb);
    %
    % Checks if it is a column key and if it is then returns the vector normalized, 
    % if not then returns the transpose normalized
    %
    % @param qb DoubleMatrix
    % @returns DoubleMatrix
    if nargin < 1 and ~ismatrix(qb),
        print_usage();
    end
    qb = qb ./norm(qb);
    if size(qb,1) < size(qb,2),
        qb = qb';
    endif
endfunction;
