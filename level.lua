Scene = Scene or require "level.scene"
Coins = Coins or require "level.coin"

-- Level Class
local Level = {}
function Level:new(scene, coins)
    local level = {
        scene = scene or Scene:new(),
        coins = coins or Coins:new(),
        pos = Vec:new(0, 0)
    }

    function level:draw()
        self.scene:draw(self.pos)
        self.coins:draw(self.pos)
    end

    function level:move(vec)
        -- pos = pos + vec
        self.pos = self.pos:add(vec)
    end

    return level
end

return Level