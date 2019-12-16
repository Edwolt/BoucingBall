Modules = Modules or {}
Modules.Vec = require "modules.vec"
local Vec = Modules.Vec

-- Collider Class
local Collider = {}

-- parametros podem ser:
-- (vec, vec)
-- (int, int, int, int)
function Collider:new(x1, y1, x2, y1)
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

    local collider = {
        p1 = vec1, -- top left
        p2 = vec2 -- botton right
    }
    return collider
end

-- Colliders Class
local Colliders = {}
function Colliders:new()
    local colliders = {vet = {}}

    -- parametros podem ser:
    -- (square)
    -- (vec, vec)
    -- (int, int, int, int)
    function colliders:add(x1, y1, x2, y2)
        table.insert(self.vet, Collider(x1, y1, x2, y2))
    end

    return colliders
end

return Colliders
