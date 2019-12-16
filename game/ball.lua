UTIL = UTIL or require "util"
Modules = Modules or require "modules"
local Vec = Modules.Vec
local Square = Modules.Square

-- Life Class
local Life = {
    SCALE = 7,
    POS = Vec:new(50, 20),
    SPACE = 50,
    sprite = love.graphics.newImage("images/life.png")
}

Life.sprite:setFilter("nearest", "nearest")
function Life:new()
    local life = {
        n = 5
    }
    setmetatable(life, self)
    self.__index = self

    function life:loseLife()
        self.n = self.n - 1
        return self.n < 0
    end

    function life:draw()
        if self.n >= 0 then
            for i = 1, self.n do
                love.graphics.draw(
                    Life.sprite, --
                    Life.POS.x + i * Life.SPACE,
                    Life.POS.y,
                    0,
                    Life.SCALE,
                    Life.SCALE
                )
            end
        else
            for i = 1, -self.n do
                love.graphics.draw(
                    Life.sprite, --
                    Life.POS.x + i * Life.SPACE,
                    Life.POS.y + Life.sprite:getHeight() * Life.SCALE,
                    0,
                    Life.SCALE,
                    -Life.SCALE
                )
            end
        end
    end

    return life
end

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
        life = Life:new()
    }
    setmetatable(ball, self)
    self.__index = self

    function ball:draw()
        ball.life:draw()
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

    function ball:onFloor()
        return self.pos.y == Ball.FLOOR
    end

    return ball
end

return Ball
