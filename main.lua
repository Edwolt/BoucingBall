Ball = require "ball"
function love.load()
    ball = Ball.new()
end

function love.draw()
    ball:draw(escala)
end

function love.update(dt)
    val = 0
    if love.keyboard.isDown("a") then
        val = val - 1
    end
    if love.keyboard.isDown("d") then
        val = val + 1
    end
    ball:walk(val)
    if love.keyboard.isDown("w") then
        ball:jump()
    end

    ball:update(dt)
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end

--[[
function love.resize(w, h)
end
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
