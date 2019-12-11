UTIL = UTIL or require "util"
Ball = Ball or require "ball"

function love.load()
    ball = Ball.new()
end

function love.draw()
    ball:draw()
end

function love.update(dt)
    dt = dt * UTIL.tile

    local walk = 0
    if love.keyboard.isDown("a") then
        walk = walk - 1
    end
    if love.keyboard.isDown("d") then
        walk = walk + 1
    end
    ball:walk(walk)
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
