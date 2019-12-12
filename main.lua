UTIL = UTIL or require("util")
Ball = Ball or require("ball")
Coins = Coins or require("coin")

function love.load()
    ball = Ball:new()
    coins = Coins:new()
    coins:add(20, 20)
end

function love.draw()
    coins:draw()
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
    if key == "s" then
        if ball:onFloor() and ball.life:loseLife() then
            ball.draw = function()
            end
        end
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
