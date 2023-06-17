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
% @deftypefn {octave_qbits} {@var{out} =} qc_split(@var{qbin})
%
% Returns the vector of combinated qbits spliting each qbit one by one
% saving them into out (each row is a qbit and has 2 columns).
%
% Params:
% @itemize
% @item qbin Vector
% @end itemize
%
% Return:
% @itemize
% @item qbout Output  Matrix
% @end itemize
% @end deftypefn

function out=qc_split(qbin)
    qbin = qc_ket(qbin);
    N = ceil(log2(size(qbin,1)));
    out = zeros(N,2);
    qbin_str = dec2bin([0:(size(qbin,1)-1)]');
    for iter = 1:N,
        out(iter,:) = qc_ket([sum(qbin(find(str2num(qbin_str(:,iter)) == 0))), ...
                 sum(qbin(find(str2num(qbin_str(:,iter)) == 1)))])';
    end
    out = out ./ max(out);
end


