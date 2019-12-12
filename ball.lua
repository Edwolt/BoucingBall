UTIL = UTIL or require("util")
Vec = Vec or require("vec")

-- Life Class
local Life = {
    SCALE = UTIL.tile * 7,
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
    end

    return life
end

-- Ball Class
local Ball = {
    SCALE = 10 * UTIL.tile,
    GRAVIDADE = 2000 * UTIL.tile,
    PULO = 1100 * UTIL.tile,
    CAMINHADA = 200 * UTIL.tile,
    sprite = love.graphics.newImage("images/ball.png")
}
Ball.FLOOR = 1000 * UTIL.tile - Ball.SCALE * Ball.sprite:getHeight()
Ball.sprite:setFilter("nearest", "nearest")

function Ball:new()
    local ball = {
        pos = Vec:new(100, 100),
        vel = Vec:new(0, 0),
        acel = Vec:new(0, Ball.GRAVIDADE),
        life = Life:new()
    }
    setmetatable(ball, self)
    self.__index = self

    function ball:draw()
        ball.life:draw()
        love.graphics.draw(Ball.sprite, self.pos.x, self.pos.y, 0, Ball.SCALE, Ball.SCALE)
    end

    function ball:update(dt)
        -- vel = vel + acel * dt
        self.vel = self.vel:add(self.acel:mul(dt))

        -- pos = pos + vel * dt
        self.pos = self.pos:add(self.vel:mul(dt))

        if self.pos.y > Ball.FLOOR then
            self.pos.y = Ball.FLOOR
        end
    end

    function ball:walk(val)
        self.vel.x = val * Ball.CAMINHADA
    end

    function ball:jump()
        if ball:onFloor() then
            self.vel.y = -Ball.PULO
        end
    end

    function ball:onFloor()
        return self.pos.y == Ball.FLOOR
    end

    return ball
end

return Ball
