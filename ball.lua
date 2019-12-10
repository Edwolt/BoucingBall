Ball = {}
sprite = love.graphics.newImage("ball.png")

function Ball:new()
    local obj = {}

    obj.pos = {x = 50, y = 50}

    function obj:draw()
        love.graphics.draw(sprite, self.pos.x, self.pos.y)
    end

    return obj
end

return Ball
