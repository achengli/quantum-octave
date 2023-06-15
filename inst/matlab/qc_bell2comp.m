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
% @deftypefn {octave_qbits} {@var{qb2_comp} =} qc_bell2comp(@var{qb2_bell})
%
% Conversion from Computational base to Bell base.
% 
% Parameters:
% @itemize
% @item @var{qb2_bell} Vector in bell base. 
% @end itemize
%
% Return:
% @itemize
% @item @var{qb2_comp} Vector in computational base.
% @end itemize
% 
% @ifnottex
% @example
% 
% Implemented circuit.
%
% |BELL> --o--H-- |COMP>
%          |          
% |BELL> --X--I-- |COMP>
% 
% @end example
% @end ifnottex
% @end deftypefn

function qb2_comp=qc_bell2comp(qb2_bell)
    if nargin < 1 || ~ismatrix(qb2_bell),
        print_usage();
    end
    if ~exist('qc_defs_loaded'),
        load qc_defs.mat;
    end
    qb2_comp=kron(H,I)*CNOT*qc_ket(qb2_bell);
end

%! assert (qc_bell2comp((1/sqrt(2))[1 0 0 1]') == [1.0 0 0 0]')
%! assert (qc_bell2comp((1/sqrt(2))[0 1 1 0]') == [0 1.0 0 0]')
%! assert (qc_bell2comp((1/sqrt(2))[1 0 0 -1]') == [0 0 1.0 0]')
%! assert (qc_bell2comp((1/sqrt(2))[0 1 -1 0]') == [0 0 0 1.0]')
