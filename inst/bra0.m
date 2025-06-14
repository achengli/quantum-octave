## Copyright (C) 2025 Yassin Achengli <yassin_achengli@hotmail.com>
##
## This file is part of Quantum package for GNU Octave.
##
## This program is free software; you can redistribute it and/or modify it under
## the terms of the GNU General Public License as published by the Free Software
## Foundation; either version 3 of the License, or (at your option) any later
## version.
##
## This program is distributed in the hope that it will be useful, but WITHOUT
## ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
## FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
## details.
##
## You should have received a copy of the GNU General Public License along with
## this program; if not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*-
## @deftypefn   {quantum-octave} {@var{b0} =} bra0 ()
##
## Returns <0| quantum state.
##
## @tex
## \langle 0\ver = \begin{bmatrix}
## 1 & 0
## \end{bmatrix}
## @end tex
## @seealso{bra, bra1}
## @end deftypefn

function b0 = bra0 ()

  b0 = bra (1);

endfunction

%!demo
%! bra0 ()
