Ball = {}
Ball.sprite = love.graphics.newImage('ball.png')

function Ball:new(obj)
	local obj = obj or {}
	setmetatable(obj, self)
    self.__index = self

    obj.pos.x = 50
    obj.pos.y = 50

	return obj
end

function Ball:draw()
	love.graphics.draw(self.sprite, self.pos.x, self.pos.y)
end

return Ball