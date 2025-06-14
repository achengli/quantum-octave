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
## @deftypefn   {quantum-octave} {@var{I} =} I ()
## @deftypefnx  {quantum-octave} {@var{I} =} I (n)
##
## Identity operator.
##
## @tex
## I\vert\Psi\rangle \triangleq \vert\Psi\rangle
## @end tex
##
## @seealso{hadamard}
## @end deftypefn

function I = identity (n)

  ispositive = @(x) isinteger (x) && x > 0;

  if (nargin == 1) 
    if (ispositive (n))
      if (n > 1)
        I = eye (n);
      else
        I = eye (2);
      endif
    else
      print_usage
    endif
  else
    I = eye (2);
  endif;

endfunction

%!demo
%! identity (2)

%!test
%! assert (identity (3) == eye (3))
%!test
%! assert (identity () == eye (2))
%!test
%! assert (identity (1) == eye (2))
