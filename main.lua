Ball = require "ball"
Teclas = {}

function love.load()
    ball = Ball.new()
end

function love.draw()
    ball:draw()
end

function love.update(dt)
    if love.keyboard.isDown("w") then
        ball:move_up()
    elseif love.keyboard.isDown("s") then
        ball:move_down()
    elseif love.keyboard.isDown("a") then
        ball:move_left()
    elseif love.keyboard.isDown("d") then
        ball:move_right()
    end
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
