## qc_defs_generator.m
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

% This script generates qc_defs.mat file with necesary qbits objects.

clear all; close all;
I=eye(2);Z=[1 0;0 -1];X=[0 1;1 0];Y=[0 -i;i 0];     % Pauli doors I,X,Y,Z
H=1/sqrt(2)*[1 1;1 -1];                             % Hadamard H door
CNOT=eye(4);CNOT(3:4,3:4)=X;                        % CNOT door

B1z=I;                          % 1Q computational base
B1x=H*B1z;                      % 1Q Hadamard base
B2z=kron(I,I);                  % 2Q computational base
B2x=kron(B1x,B1x);              % 2Q Hadamard base
B2bell=CNOT*kron(H,I)*B2z;      % Bell base.

save(all, 'qc_defs.mat');
