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
function Blocks:new()
    local blocks = {
        vet = {},
        n = 0
    }
    setmetatable(blocks, self)
    self.__index = self

    function coins:add(x, y)
        self.vet[self.n] = Block:new(x, y)
    end

    function coins:remove(x, y)
        for k, i in pairs(self.vet) do
            if i.x == x and i.y == y then
                self.vet[k] = nil
            end
        end
    end

    function coins:draw()
        for _, i in pairs(self.vet) do
            print(i)
            i:draw()
        end
    end
end

return Blocks
