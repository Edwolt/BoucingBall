-- Block Class
local Block = {
    SCALE = 1,
    sprite = love.graphics.newImage("image/campo.png")
}

Block.sprite:setFilter("nearest", "nearest")
function Block:new(x, y)
    local block = {
        pos = {x = x, y = y}
    }
    setmetatable(block, self)
	self.__index = self

    function block:draw()
        love.graphics.draw(Block.sprite, block.pos.x, block.pos.y, 0, Block.SCALE, Block.SCALE)
    end

    return block
end

local Blocks = {}

return Blocks