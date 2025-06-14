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
## @deftypefn   {quantum-octave} {@var{k} =} ket (@var{n})
## @deftypefnx  {quantum-octave} {@var{k} =} ket (@var{n}, @var{M})
##
## Returns @var{M} - dimensional ket "if the parameter was passed" with the @var{n} 
## ket state; another way to use it is passing only @var{n} using to be the dimension 
## and the ket state at same time.
##
## If @var{n} is 1, the dimension will be taken as two (it is the minimum to be a 
## quantum state).
## @tex
## \vert k\rangle = \begin{bmatrix}
## 0 \\
## 0 \\
## \vdots \\
## 1 \\
## \vdots \\
## 0 \\
## 0 \\
## \end{bmatrix}
## @end tex
## @seealso{bra, ket0, ket1}
## @end deftypefn

function k = ket (n, M)

  ispositive = @ (x) isinteger (n) || n > 0;

  if (nargin < 1 || !ispositive (n))
    print_usage
  endif

  if (nargin == 1)
    if (n == 1)
      k = circshift (eye (2, 1), n-1);
    else
      k = circshift (eye (2, 1), n-1);
    endif
  else
    if (ispositive (M) && M > n)
      k = circshift (eye (M, 1), n-1);
    else
      print_usage
    endif
  endif

endfunction

%!demo
%! ket (3, 5)

%!demo
%! ket (6)

