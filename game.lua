Modules = Modules or require "modules"
local Vec = Modules.Vec

-- Game Class
local Game = {
    Scene = require "game.scene",
    Coins = require "game.coin",
    Ball = require "game.ball",
    HUD = require "game.hud"
}

function Game:new(o)
    o = o or {}
    local game = {
        player = o.player or Game.Ball:new(),
        scene = o.scene or Game.Scene:new(),
        coins = o.coins or Game.Coins:new()
    }

    function game:draw()
        self.scene:draw(Vec:new(0, 0))
        self.coins:draw(Vec:new(0, 0))
        self.player:draw()
        Game.HUD.Life:draw(self.player.life)
    end

    function game:update(dt)
        game.player:update(dt, game)
    end

    function game:move(vec)
        -- pos = pos + vec
        self.pos = self.pos:add(vec)
    end

    return game
end

return Game
