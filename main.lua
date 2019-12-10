Ball = require "ball"
function love.load()
    ball = Ball.new()
end

function love.draw()
    ball:draw(escala)
end

function love.update(dt)
    local vec = {x = 0, y = 0}
    if love.keyboard.isDown("w") then
        vec.y = vec.y - 1
    end
    if love.keyboard.isDown("s") then
        vec.y = vec.y + 1
    end
    if love.keyboard.isDown("a") then
        vec.x = vec.x - 1
    end
    if love.keyboard.isDown("d") then
        vec.x = vec.x + 1
    end
    ball:move(vec, dt)
    print(vec.x, vec.y)
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
