Ball = {}
sprite = love.graphics.newImage("ball.png")

function Ball:new()
    local obj = {}

    obj.pos = {x = 50, y = 50}
    obj.vel = 10

    function obj:draw()
        love.graphics.draw(sprite, self.pos.x, self.pos.y)
    end

    function obj:move_up(dt)
        self.pos.y = self.pos.y - self.vel
    end

    function obj:move_down(dt)
        self.pos.y = self.pos.y + self.vel
    end

    function obj:move_left(dt)
        self.pos.x =self.pos.x- self.vel
    end

    function obj:move_right(dt)
        self.pos.x = self.pos.x + self.vel
    end

    return obj
end

return Ball
