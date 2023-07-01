## -*- texinfo -*-
## @deftypefn {octave_qbits} qc_defs_generator
## 
## This script generates qc_defs.mat file with necesary qbits objects.
## 
## @ifnottex
## @example
##        | 1     0 |       | 0.707  0.707 |
##    I = |         | , H = |              |
##        | 0     1 |       | 0.707  0.707 |
## 
##        | 1  0  0  0 |
##        | 0  1  0  0 |
## CNOT = | 0  0  0  1 |
##        | 0  0  1  0 |
##
## @end example
## @end ifnottex
## 
## Results are saved into 'qc_defs.mat'
## @seealso{qc_generate_M}
## @end deftypefn

clear all; close all;
I=eye(2);Z=[1 0;0 -1];X=[0 1;1 0];Y=[0 -i;i 0];     % Pauli doors I,X,Y,Z
H=1/sqrt(2)*[1 1;1 -1];                             % Hadamard H door
CNOT=eye(4);CNOT(3:4,3:4)=X;                        % CNOT door

B1z=I;                          % 1Q computational base
B1x=H*B1z;                      % 1Q Hadamard base
B2z=kron(I,I);                  % 2Q computational base
B2x=kron(B1x,B1x);              % 2Q Hadamard base
B2bell=CNOT*kron(H,I)*B2z;      % Bell base.

qc_defs_loaded = true;

save -binary 'qc_defs.mat'
