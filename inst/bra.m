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
## @deftypefn   {quantum-octave} {@var{k} =} bra (@var{n})
## @deftypefnx  {quantum-octave} {@var{k} =} bra (@var{n}, @var{M})
##
## Returns @var{M} - dimensional bra "if the parameter was passed" with the @var{n} 
## bra state; another way to use it is passing only @var{n} using to be the dimension 
## and the bra state at same time.
##
## If @var{n} is 1, the dimension will be taken as two (it is the minimum to be a 
## quantum state).
## @tex
## \langle b\vert = \begin{bmatrix}
## 0 & 0 & \dots & 1 & \dots & 0 & 0
## \end{bmatrix}
## @end tex
## @seealso{ket, bra0, bra1}
## @end deftypefn

function b = bra (n, M);

  ispositive = @ (x) (isinteger (x) && x > 0);

  if (nargin < 1 || !ispositive (n))
    print_usage
  endif

  if (nargin == 1)
    b = conj (ket (n)');
  else
    if (ispositive (M) && M > n)
      b = conj (ket (n, M)');
    else
      print_usage
    endif
  endif

endfunction

%!demo
%! bra (3)

%!demo
%! bra (4, 6)
