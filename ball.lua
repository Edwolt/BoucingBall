Ball = {}
sprite = love.graphics.newImage("ball.png")

function Ball:new()
    local obj = {}

    obj.pos = {x = 50, y = 50}
    obj.vel = 100

    function obj:draw()
        love.graphics.draw(sprite, self.pos.x, self.pos.y)
    end

    function obj:move(vec, dt)
        local mod = math.sqrt(vec.x * vec.x + vec.y * vec.y)
        if mod ~= 0 then
            vec.x = vec.x / mod
            vec.y = vec.y / mod
            self.pos.x = self.pos.x + vec.x * self.vel * dt
            self.pos.y = self.pos.y + vec.y * self.vel * dt
        end
    end

    return obj
end

return Ball
