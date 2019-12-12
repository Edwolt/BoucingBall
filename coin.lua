UTIL = UTIL or require("util.lua")

-- Coin Class
local Coin = {
    SCALE = UTIL.tile * 8,
    sprite = love.graphics.newImage("images/coin.png")
}

Coin.sprite:setFilter("nearest", "nearest")
function Coin:new(x, y)
    local coin = {
        pos = {x = x, y = y}
    }
    setmetatable(coin, self)
    self.__index = self

    function coin:draw()
        love.graphics.draw(Coin.sprite, self.pos.x, self.pos.y, 0, Coin.SCALE)
    end

    return coin
end

-- Coins Class
local Coins = {}
function Coins:new()
    local coins = {
        vet = {},
        n = 0
    }
    setmetatable(coins, self)
    self.__index = self

    function coins:add(x, y)
        self.vet[self.n] = Coin:new(x, y)
    end

    function coins:remove(x, y)
        for k, i in pairs(self.vet) do
            if i.x == x and i.y == y then
                self.vet[k] = nil
            end
        end
    end

    function coins:draw()
        for _, i in ipairs(self.vet) do
            print(i)
            i:draw()
        end
    end

    return coins
end

return Coins
