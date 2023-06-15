local lfs = require'lfs'

for iter, _ in lfs.dir('.') do
    if string.match(iter, '%w+%.m$') then
        local f = io.open(iter,'r')
        if not f then error('Error opening ' .. iter) end
        local buff = ''
        for line in f:lines() do
            buff = buff .. line:gsub('end%w+[; ]?$','end'):gsub('##','%%') .. '\n'
        end
        f:close()
        f = io.open('matlab/' .. iter,'w')
        if not f then error('Error opening matlab/'..iter) end
        f:write(buff)
        f:close()
    end
end
