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
## @deftypefn   {quantum-octave} {@var{b1} =} bra1 ()
##
## Returns <1| quantum state.
##
## @tex
## \langle 1\ver = \begin{bmatrix}
## 0 & 1
## \end{bmatrix}
## @end tex
## @seealso{bra, bra0}
## @end deftypefn

function b1 = bra1 ()

  b1 = bra (2);

endfunction

%!demo
%! bra1 ()
