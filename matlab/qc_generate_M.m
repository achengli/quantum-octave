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
% @deftypefn {octave_qbits} @qcode{qc_generate_M}
% 
% This script maps all the combinations of M input in the second block searching for the match 
% which apply to the second block without CNOT blocks retrieves the same response.
% Saves M and Mp to M_coefs.mat. qc_classic_logic_block.m use the data inside for mapping the 
% M input for an M output
% 
% @seealso{qc_defs_generator}
% @end deftypefn

qb = [1;1]; qbin = kron(qb,qb);
M = [0 0 0 0; 0 0 0 1; 0 0 1 0; 0 0 1 1;
    0 1 0 0; 0 1 0 1; 0 1 1 0; 0 1 1 1;
    1 0 0 0; 1 0 0 1; 1 0 1 0; 1 0 1 1;
    1 1 0 0; 1 1 0 1; 1 1 1 0; 1 1 1 1
];
Mp = M;
for iter=1:size(M,1),
    Mrow = M(iter,:);
    qc_result=qc_second_block(qbin,Mrow');
    for iter2=1:size(M,1),
        Mmrow = M(iter2,:);
        qc_result2=qc_second_block_noCNOT(qbin,Mmrow');
        if sum(abs(qc_result2 - qc_result)) < 1e-9,         % 1e-9 (error margin)
            Mp(iter,:) = Mmrow;
        end
    end
end

for iter=1:size(M,1),
    fprintf(' * from-to: [%g %g %g %g] ---> [%g %g %g %g]\n',M(iter,:),Mp(iter,:));
end

M_coefs_loaded=true;
M_m = M; Mp_m = Mp;
clear M Mp;

save -binary 'M_coefs.mat' M_m Mp_m M_coefs_loaded
