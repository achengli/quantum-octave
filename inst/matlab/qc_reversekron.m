% Copyright (C) 2023 Yassin Achengli <relifenatu@gmail.com> 
% Copyright (C) 2023 Jesús Bravo <js_bravo98@uma.es>
% 
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% any later version.
% 
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
% 
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>.

% -*- texinfo -*-
% @deftypefn {octave_qbits} {@var{out} =} qc_first_block ()
%
% This block generates the 4 combinated qbits state with each of the four 
% qbits as |0>. The combination returns a 4x1 column vector with a normalized
% state.
% 
% @ifnottex
% @example
%			|0> ---H-----o-----I----- | 
%			             |            |
%			|0> ---I-----X-----o----- |
%			                   |      |==> out
%			|0> ---I-----X-----X----- |
%			             |            |
%			|0> ---H-----o-----I----- |
% @end ifnottex
% @end example
%
% Params:
% @itemize
% @item @qcode{@var{out}} qbit state in question.
% @end itemsize
% @seealso{qc_second_block,qc_second_block_noCNOT}
% @end deftypefn
function qbits = qc_reversekron(qbin)
    if (nargin < 1 || !ismatrix(qbin))
        print_usage();
    end
    
    qbin = qc_ket(qbin);
    valued_indexes = dec2bin(find(qbin != 0),size(log2(size(qbin,1)),1));
    qbits = [];
    for idx = 1:size(valued_indexes,2)
        valued_indexes(:,idx)
        spin_0 = find(strcmp(valued_indexes(:,idx),'0'));
        spin_1 = find(strcmp(valued_indexes(:,idx),'1'));
        spin_0 = sum(qbin(spin_0));
        spin_1 = sum(qbin(spin_1));
        qbits = [qbits; qc_ket([spin_0, spin_1])];
    end
end
