function [x] = octformat(file)
  
  if (nargin ~= 1)
    print_usage();
  endif

  f = fopen(file, 'r');
  f2 = fopen(file, 'w');

  if (~f || ~f2)
    error("Couldn't open file");
  endif

  while (feof(f))
    l = regexprep(regexprep(fgetl(f), '\(.\)(', '\1 ('),
                  ',\(.\)', ', \1');
    fwrite(f2);
  endwhile

  fclose(f);
  fclose(f2);
endfunction
