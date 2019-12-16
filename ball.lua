UTIL = UTIL or require "util"
Vec = Vec or require "modules.vec"
Square = Square or require "modules.square"

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
    sprite = love.graphics.newImage("images/ball.png")
}
Ball.FLOOR = 1000 * UTIL.tile - Ball.SCALE * Ball.sprite:getHeight()
Ball.sprite:setFilter("nearest", "nearest")

function Ball:new()
    local ball = {
        pos = Vec:new(100, 100),
        vel = Vec:new(0, 0),
        acel = Vec:new(0, Ball.GRAVIDADE),
        margin = Square:new(
            50 * UTIL.tile, --
            50 * UTIL.tile,
            (UTIL.width - 50 - self.sprite:getWidth() *Ball.SCALE) * UTIL.tile,
            (UTIL.height - 50 - self.sprite:getHeight() * Ball.SCALE) * UTIL.tile
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
    function ball:update(dt, scene)
        -- vel = vel + acel * dt
        self.vel = self.vel:add(self.acel:mul(dt))

        -- newpos = pos + vel * dt * SCALE
        local newpos = self.pos:add(self.vel:mul(dt))

        local restante = Vec:new() -- vector of left movement

        local ok = self.margin:vecInner(newpos)
        if ok.x == 0 then
            self.pos.x = newpos.x
            restante.x = 0
        elseif ok.x == -1 then
            self.pos.x = self.margin.p1.x
            restante.x = newpos.x - self.margin.p1.x
        else
            self.pos.x = self.margin.p2.x
            restante.x = newpos.x - self.margin.p2.x
        end

        if ok.y == 0 then
            self.pos.y = newpos.y
            restante.y = 0
        elseif ok.y == -1 then
            self.pos.y = self.margin.p1.y
            restante.y = newpos.y - self.margin.p1.y
        else
            self.pos.y = self.margin.p2.y
            restante.y = newpos.y - self.margin.p2.y
        end
        
        scene:move(restante)
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
