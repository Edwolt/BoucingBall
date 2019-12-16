UTIL = UTIL or require "util"
Modules = Modules or require "modules"
local Vec = Modules.Vec

-- Game Class
local Game = {
    Scene = require "game.scene",
    Coins = require "game.coin",
    Player = require "game.player",
    HUD = require "game.hud"
}

function Game:new(o)
    o = o or {}
    local game = {
        player = o.player or Game.Player:new(),
        scene = o.scene or Game.Scene:new(),
        coins = o.coins or Game.Coins:new()
    }

    function game:draw()
        
        local screenCenter = Vec:new(UTIL.width / 2, UTIL.height / 2)
        
        -- playerPos = screenCenter * tile - spriteCenter
        local playerPos = screenCenter:mul(UTIL.tile):sub(Game.Player:spriteCenter())
        
        -- scenePos = player.pos - playerPos
        local scenePos = self.player.pos:sub(playerPos)
        
        self.coins:draw(scenePos)
        self.scene:draw(scenePos)
        self.player:draw(playerPos)
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
