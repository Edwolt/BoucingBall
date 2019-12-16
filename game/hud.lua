Modules = Modules or require "modules"
local Vec = Modules.Vec

-- Class Life
local Life = {
    SCALE = 7,
    POS = Vec:new(50, 20),
    SPACE = 50,
    sprite = love.graphics.newImage("images/life.png")
}
Life.sprite:setFilter("nearest", "nearest")

function Life:draw(n)
    if n >= 0 then
        for i = 1, n do
            love.graphics.draw(
                Life.sprite, --
                Life.POS.x + i * Life.SPACE,
                Life.POS.y,
                0,
                Life.SCALE,
                Life.SCALE
            )
        end
    else
        for i = 1, -n do
            love.graphics.draw(
                Life.sprite, --
                Life.POS.x + i * Life.SPACE,
                Life.POS.y + Life.sprite:getHeight() * Life.SCALE,
                0,
                Life.SCALE,
                -Life.SCALE
            )
        end
    end
end

HUD = {Life = Life}

return HUD
