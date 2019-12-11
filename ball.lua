UTIL = UTIL or require "util"

Life = {
    SCALE = UTIL.tile * 7,
    sprite = love.graphics.newImage("images/life.png")
}
Life.sprite:setFilter("nearest", "nearest")

function Life:new()
    local life = {
        n = 5
    }

    function life:loseLife()
        self.n = self.n - 1
        return n >= 0
    end

    function life:draw()
        for i = 1, 5 do
            love.graphics.draw(Life.sprite, 50 + i * 50, 20, 0, Life.SCALE, Life.SCALE)
        end
    end

    return life
end

Ball = {
    SCALE = 10 * UTIL.tile,
    GRAVIDADE = 500 * UTIL.tile,
    PULO = 500 * UTIL.tile,
    CAMINHADA = 200 * UTIL.tile,
    sprite = love.graphics.newImage("images/ball.png")
}
Ball.FLOOR = 1000 * UTIL.tile - Ball.SCALE * Ball.sprite:getHeight()
Ball.sprite:setFilter("nearest", "nearest")

function Ball:new()
    local ball = {
        pos = {x = 100, y = 100},
        vel = {x = 0, y = 0},
        acel = {x = 0, y = Ball.GRAVIDADE},
        life = Life:new()
    }

    function ball:draw()
        ball.life:draw()
        love.graphics.draw(Ball.sprite, self.pos.x, self.pos.y, 0, Ball.SCALE, Ball.SCALE)
    end

    function ball:update(dt)
        self.vel.x = self.vel.x + self.acel.x * dt
        self.vel.y = self.vel.y + self.acel.y * dt

        self.pos.x = self.pos.x + self.vel.x * dt
        self.pos.y = self.pos.y + self.vel.y * dt

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
