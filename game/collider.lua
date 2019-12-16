Modules = Modules or require "modules"
local Square = Modules.Square

-- Collider Class
local Collider = {}

-- parametros podem ser:
-- (square)
-- (vec, vec)
-- (int, int, int, int)
function Collider:new(x1, y1, x2, y1)
    local square
    if y1 == nil then
        square = x1
    elseif x2 == nil then
        square = Square:new(x1, y1)
    else
        square = Square:new(x1, y1, x2)
    end

    local collider = {square = square}
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

return Collider, Colliders
