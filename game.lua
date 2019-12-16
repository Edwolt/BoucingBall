Modules = Modules or require "modules"
local Vec = Modules.Vec

-- Game Class
local Game = {
    Scene = require "game.scene",
    Coins = require "game.coin",
    Ball = require "game.ball"
}

function Game:new(o)
    o = o or {}
    local game = {
        player = o.player or Game.Ball:new(),
        scene = o.scene or Game.Scene:new(),
        coins = o.coins or Game.Coins:new(),
        pos = Vec:new(0, 0)
    }

    function game:draw()
        self.scene:draw(self.pos)
        self.coins:draw(self.pos)
        self.player:draw()
    end

    function game:move(vec)
        -- pos = pos + vec
        self.pos = self.pos:add(vec)
    end

    return game
end

return Game
