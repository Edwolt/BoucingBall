-- Vec Class
local Vec = {}
function Vec:new(x, y)
    local vec = {
        x = x or 0,
        y = y or 0
    }
    setmetatable(vec, self)
    self.__index = self

    function vec:add(other)
        return Vec:new(
            self.x + other.x, --
            self.y + other.y
        )
    end

    function vec:sub(other)
        return Vec:new(
            self.x - other.x, --
            self.y - other.y
        )
    end

    function vec:mul(num)
        return Vec:new(
            self.x * num, --
            self.y * num
        )
    end

    return vec
end

return Vec
