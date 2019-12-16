UTIL = UTIL or require "util"
Modules = Modules or require "modules"
local Vec = Modules.Vec
local Square = Modules.Square

-- Ball Class
local Player = {
    SCALE = 10 * UTIL.tile,
    GRAVIDADE = 2000 * UTIL.tile,
    PULO = 1100 * UTIL.tile,
    CAMINHADA = 200 * UTIL.tile,
    MARGIN = Vec:new(UTIL.width / 4, UTIL.height / 4),
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
        margin = Square:new(
            Player.MARGIN.x * UTIL.tile, --
            Player.MARGIN.y * UTIL.tile,
            (UTIL.width - Player.MARGIN.x) * UTIL.tile - Player.sprite:getWidth() * Player.SCALE,
            (UTIL.height - Player.MARGIN.y) * UTIL.tile - Player.sprite:getHeight() * Player.SCALE
        ),
        life = 5
    }
    setmetatable(player, self)
    self.__index = self

    function player:draw(pos)
        love.graphics.draw(Player.sprite, pos.x, pos.y, 0, Player.SCALE, Player.SCALE)
    end

    -- Updates ball position and return a Vec of movement that can't be actualized
    function player:update(dt, level)
        -- vel = vel + acel * dt
        self.vel = self.vel:add(self.acel:mul(dt))

        -- newpos = pos + vel * dt * SCALE
        self.pos = self.pos:add(self.vel:mul(dt))
    end

    function player:forceMove(dt, vec)
        -- pos = pos + vec
        self.pos = self.pos:add(vec)
    end

    function player:walk(val)
        self.vel.x = val * Player.CAMINHADA
    end

    function player:jump()
        if player:onFloor() then
            self.vel.y = -Player.PULO
        end
    end

    function player:stopJump()
        print("stop jmp")
        if self.vel.y < 0 then
            self.vel.y = self.vel.y / 2
        end
    end

    function player:loseLife()
        self.life = self.life - 1
    end

    function player:onFloor()
        return false
    end

    return player
end

return Player
