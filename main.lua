Ball = require 'ball'

function love.load()
    ball = Ball.new()
end

function love.draw()
    love.graphics.print({{255, 255, 255}, love.timer.getFPS()}, 0, 0)
    ball:draw()
    
end

function love.update(dt)
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end

function love.resize(w, h)
    -- body...
end

--[[
function love.focus(bool)
end
function love.keypressed(key, unicode)
end
function love.keyreleased(key, unicode)
end
function love.mousepressed(x, y, button)
end
function love.mousereleased(x, y, button)
end
function love.quit()
end
--]]
