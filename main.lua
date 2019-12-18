UTIL = UTIL or require "util"
Game = Game or require "game"

local game

function love.load()
    game = Game:new()
    game.coins:add(20, 20)
    game.scene:load("Fase1")
end

function love.draw()
    game:draw()
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
    game.player:walk(walk)
    if love.keyboard.isDown("w") then
        game.player:jump()
    end
    game:update(dt)
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end

function love.keyreleased(key)
    if key == "w" then
        game.player:stopJump()
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
