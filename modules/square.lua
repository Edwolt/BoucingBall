Vec = Vec or require "modules.vec"

-- Square Class
local Square = {}
function Square:new(x1, y1, x2, y2)
    local vec1, vec2
    if x2 == nil then
        vec1 = x1
        vec2 = y1
    else
        vec1 = Vec:new(x1, y1)
        vec2 = Vec:new(x2, y2)
    end
    if vec1.x > vec2.x then
        vec1, vec2 = vec2, vec1
    end

    local square = {
        p1 = vec1,
        p2 = vec2
    }

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
