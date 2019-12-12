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

-- Layer Class
local Layer = {}

function Layer:new(l)
    local layer = {
        vet = {},
        tam = {
            width = 0,
            height = 0
        }
    }
    setmetatable(layer, self)
    self.__index = self

    -- criar layer

    function Layer:draw()
        for _, i in pairs(self.vet) do
            print(i)
            i:draw()
        end
    end

    return layer
end

-- Scene Class
local Scene = {}

function Scene:new()
    local scene = {
        layers = {}
    }
    setmetatable(scene, self)
    self.__index = self

    function scene:load(path)
        local tilemap = require(path)
        for _, layer in ipairs(tilemap.tileset.layers) do
            self.layers:insert(Layer:new(layer))
        end
    end

    function scene:draw()
        for _, i in ipairs(self.layers) do
            i:draw()
        end
    end
end

return Scene
