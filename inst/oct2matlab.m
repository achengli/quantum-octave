function [x] = oct2matlab ()
  dir_files = dir;

  for file = dir
    if (~isdir(file) && regexp('.+\.m') # it's an octave file
      f = fopen (file, 'r');
      f2 = fopen (regexprep (file, '\.m', '_formated.m'), 'w');

      if (~f  || ~f2)
        error (sprintf ('Cannot open %s file\n', file)
      endif

      for l = lines(f)
        ll = regexprep (l, '([#]+)', '%');
        ll = regexprep (ll, '^([ ]*)end[a-z]+', '\1end');
        fwrite(f2, ll);
      endfor

      fclose(f);
      fclose(f);
    endif
  endfor
endfunction
