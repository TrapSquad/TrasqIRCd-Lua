-----------------------------------------------------------------------------
-- Pulled from tinyirc.lua in luasocket samples.
-- LuaSocket sample files.
-- Author: Diego Nehab
-----------------------------------------------------------------------------

-- simple set implementation
-- the select function doesn't care about what is passed to it as long as
-- it behaves like a table
-- creates a new set data structure

local _M = {}

function _M.newset()
    local reverse = {}
    local set = {}
    return setmetatable(set, {__index = {
        insert = function(set, value)
            if not reverse[value] then
                table.insert(set, value)
                reverse[value] = #set
            end
        end,
        remove = function(set, value)
            local index = reverse[value]
            if index then
                reverse[value] = nil
                local top = table.remove(set)
                if top ~= value then
                    reverse[top] = index
                    set[index] = top
                end
            end
        end
    }})
end

return _M
