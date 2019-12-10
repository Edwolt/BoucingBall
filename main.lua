function love.load()
end

function love.draw()
    love.graphics.print({{255, 255, 255}, love.timer.getFPS()}, 0, 0)
end

function love.update(dt)
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    elseif key == "f11" then
        love.window.setFullscreen(true)
    elseif key == "f5" then
        love.event.quit("restart")
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
