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

function out = qc_first_block()
    % This block generates the 4 combinated qbits state with each of the four 
    % qbits as |0>. The combination returns a 4x1 column vector with a normalized
    % state.
    %
    %			|0> ---H-----o-----I----- | 
    %			             |            |
    %			|0> ---I-----X-----o----- |
    %			                   |      |==> out
    %			|0> ---I-----X-----X----- |
    %			             |            |
    %			|0> ---H-----o-----I----- |
    %
    % @returns DoubleColumnVector
    
    load qc_defs.mat;
    qb0 = [1;0];
    qc0 = kron(qb0, kron(qb0, kron(qb0,qb0)));
    CNOTI = [1 0 0 0; 
            0 0 0 1; 
            0 0 1 0; 
            0 1 0 0];
    op1 = kron(kron(H,I),kron(I,H));
    op2 = kron(CNOT, CNOTi);
    op3 = kron(I, kron(CNOT, I));

    out = qc_ket(op3 * op2 * op1 * qc0);
endfunction;
