#!/usr/bin/env lua
local lfs = require'lfs'

for iter, _ in lfs.dir('inst') do
    if string.match(iter, '%w+%.m$') then
        local f = io.open('inst/' .. iter,'r')
        if not f then error('Error opening ' .. iter) end
        local buff = ''
        local g= true
        for line in f:lines() do
            if g and #line == 0 then
                g = false
            else
                if g then
                    buff = buff .. line:gsub('##.*$','')
                else
                    buff = buff .. line .. '\n'
                end
            end
        end
        f:close()
        f = io.open('formated/' .. iter,'w')
        if not f then error('Error opening formated/'..iter) end
        f:write(buff)
        f:close()
    end
end
