Ball = {}
sprite = love.graphics.newImage("images/ball.png")
sprite:setFilter("nearest", "nearest")
function Ball:new()
    local obj = {}

    obj.pos = {x = 50, y = 50}
    obj.vel = {x = 0, y = 0}
    obj.acel = {x = 0, y = 500}

    function obj:draw(escala)
        love.graphics.draw(sprite, self.pos.x, self.pos.y, 0, 5, 5)
    end

    function obj:update(dt)
        self.vel.x = self.vel.x + self.acel.x * dt
        self.vel.y = self.vel.y + self.acel.y * dt

        self.pos.x = self.pos.x + self.vel.x * dt
        self.pos.y = self.pos.y + self.vel.y * dt
    end

    function obj:walk(val)
        obj.vel.x = val * 200
    end

    function obj:jump()
        obj.vel.y = -200
    end

    return obj
end

return Ball
