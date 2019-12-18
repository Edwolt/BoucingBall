UTIL = UTIL or require "util"
Modules = Modules or require "modules"
local Vec = Modules.Vec
local Collider = Modules.Collider

-- Ball Class
local Player = {
    SCALE = 10 * UTIL.tile,
    GRAVIDADE = 2000 * UTIL.tile,
    PULO = 1100 * UTIL.tile,
    CAMINHADA = 200 * UTIL.tile,
    sprite = love.graphics.newImage("images/ball.png")
}
Player.sprite:setFilter("nearest", "nearest")

function Player:spriteCenter()
    return Vec:new(
        self.sprite:getWidth() / 2, --
        self.sprite:getHeight() / 2
    ):mul(self.SCALE)
end

function Player:new()
    local player = {
        pos = Vec:new(100, 100),
        vel = Vec:new(0, 0),
        acel = Vec:new(0, Player.GRAVIDADE),
        life = 5,
        canJump = false
    }
    setmetatable(player, self)
    self.__index = self

    function player:draw(pos)
        love.graphics.draw(Player.sprite, pos.x, pos.y, 0, Player.SCALE, Player.SCALE)
    end

    -- Updates ball position and return a Vec of movement that can't be actualized
    function player:update(dt)
        -- pos = pos + vel * dt * SCALE
        self.pos = self.pos:add(self.vel:mul(dt))

        -- vel = vel + acel * dt
        self.vel = self.vel:add(self.acel:mul(dt))
    end

    function player:walk(val)
        self.vel.x = val * Player.CAMINHADA
    end

    function player:jump()
        if player.canJump then
            self.vel.y = -Player.PULO
            player.canJump = false
        end
    end

    function player:stopJump()
        if self.vel.y < 0 then
            self.vel.y = self.vel.y / 2
        end
    end

    function player:loseLife()
        self.life = self.life - 1
    end

    function player:getCollider()
        local p2 = Vec:new(Player.sprite:getWidth(), Player.sprite:getHeight()):mul(Player.SCALE)
        p2 = p2:add(self.pos)
        return Collider:new(self.pos, p2)
    end

    return player
end

return Player
