-- by jsimmons @ github
-- modified because sux
local _M = {}

function _M.parse(line)
         local prefix
         if line:sub(1,1) == ":" then
            local space = line:find(" ")
            prefix = line:sub(2, space-1)
            line = line:sub(space)
         end

         local colonsplit = line:find(" :")
         local last
         if colonsplit then
            last = line:sub(colonsplit+1)
            line = line:sub(1, colonsplit-2)
         end
         
         local params = {}
         local cmd
         for arg in line:gmatch("(%S+)") do
             if not cmd then
                 cmd = arg
             else
                 table.insert(params, arg)
             end
         end

         table.insert(params, last)

         return prefix, cmd, params
end

return _M
