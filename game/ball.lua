UTIL = UTIL or require "util"
Modules = Modules or require "modules"
local Vec = Modules.Vec
local Square = Modules.Square

-- Ball Class
local Ball = {
    SCALE = 10 * UTIL.tile,
    GRAVIDADE = 2000 * UTIL.tile,
    PULO = 1100 * UTIL.tile,
    CAMINHADA = 200 * UTIL.tile,
    MARGIN = Vec:new(UTIL.width / 4, UTIL.height / 4),
    sprite = love.graphics.newImage("images/ball.png")
}
Ball.sprite:setFilter("nearest", "nearest")

function Ball:new()
    local ball = {
        pos = Vec:new(100, 100),
        vel = Vec:new(0, 0),
        acel = Vec:new(0, Ball.GRAVIDADE),
        margin = Square:new(
            Ball.MARGIN.x * UTIL.tile, --
            Ball.MARGIN.y * UTIL.tile,
            (UTIL.width - Ball.MARGIN.x) * UTIL.tile - Ball.sprite:getWidth() * Ball.SCALE,
            (UTIL.height - Ball.MARGIN.y) * UTIL.tile - Ball.sprite:getHeight() * Ball.SCALE
        ),
        life = 5
    }
    setmetatable(ball, self)
    self.__index = self

    function ball:draw()
        love.graphics.draw(Ball.sprite, self.pos.x, self.pos.y, 0, Ball.SCALE, Ball.SCALE)
    end

    -- Updates ball position and return a Vec of movement that can't be actualized
    function ball:update(dt, level)
        -- vel = vel + acel * dt
        self.vel = self.vel:add(self.acel:mul(dt))

        -- newpos = pos + vel * dt * SCALE
        self.pos = self.pos:add(self.vel:mul(dt))
    end

    function ball:forceMove(dt, vec)
        -- pos = pos + vec
        self.pos = self.pos:add(vec)
    end

    function ball:walk(val)
        self.vel.x = val * Ball.CAMINHADA
    end

    function ball:jump()
        if ball:onFloor() then
            self.vel.y = -Ball.PULO
        end
    end

    function ball:stopJump()
        print("stop jmp")
        if self.vel.y < 0 then
            self.vel.y = self.vel.y / 2
        end
    end

    function ball:loseLife()
        self.life = self.life - 1
    end
    
    return ball
end

return Ball
