Vec = Vec or require "modules.vec"

-- Square Class
local Square = {}

-- parametros podem ser
-- (vec, vec)
-- (int, int, int, int)
function Square:new(x1, y1, x2, y2)
    local vec1, vec2
    if x2 == nil then
        vec1 = x1
        vec2 = y1
    else
        vec1 = Vec:new(x1, y1)
        vec2 = Vec:new(x2, y2)
    end
    
    -- Consertando vecs
    if vec1.x > vec2.x then
        vec1.x, vec2.x = vec2.x, vec1.x
    end
    if vec1.y > vec2.y then
        vec1.y, vec2.y = vec2.y, vec1.y
    end

    local square = {
        p1 = vec1, -- top left
        p2 = vec2 -- botton right
    }
    setmetatable(square, self)
    self.__index = self

    function square:vecInner(obj)
        local res = {x = 0, y = 0}

        if obj.x < self.p1.x then
            res.x = -1
        elseif obj.x > self.p2.x then
            res.x = 1
        else
            res.x = 0
        end

        if obj.y < self.p1.y then
            res.y = -1
        elseif obj.y > self.p2.y then
            res.y = 1
        else
            res.y = 0
        end

        return res
    end

    return square
end

return Square
