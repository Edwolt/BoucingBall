UTIL = UTIL or require "util"
Modules = Modules or require "modules"
local Vec = Modules.Vec
local Colliders = Modules.Colliders

-- Layer Class
local Layer = {
    SCALE = UTIL.tile * 3
}

function Layer:new(l, sheet)
    local layer = {
        width = l.width,
        height = l.height,
        data = l.data,
        sheet = sheet
    }
    setmetatable(layer, self)
    self.__index = self

    function layer:draw(info, pos)
        for x = 0, self.height - 1 do
            for y = 0, self.width - 1 do
                local k = y * self.width + x + 1
                if self.data[k] ~= 0 then
                    local i = self.data[k] - 1

                    local tile_pos = Vec:new(i % info.columns, math.floor(i / info.columns))

                    local quad =
                        love.graphics.newQuad(
                        tile_pos.x * info.tile.width,
                        tile_pos.y * info.tile.height,
                        info.tile.width,
                        info.tile.height,
                        info.image.width,
                        info.image.height
                    )

                    self:_draw(Vec:new(x, y), quad, info, pos)
                end
            end
        end
    end

    function layer:_draw(screen_pos, quad, info, pos)
        local x = screen_pos.x * info.tile.width
        local y = screen_pos.y * info.tile.height

        love.graphics.draw(
            self.sheet, --
            quad,
            x * Layer.SCALE - pos.x,
            y * Layer.SCALE - pos.y,
            0,
            Layer.SCALE,
            Layer.SCALE
        )
    end

    function layer:getTam()
        return self.height, self.width
    end

    function layer:createColliders(info)
        local colliders = Colliders:new()
        for x = 0, self.height - 1 do
            for y = 0, self.width - 1 do
                local k = y * self.width + x + 1
                if self.data[k] ~= 0 then
                    local x1 = x * info.tile.width * Layer.SCALE
                    local y1 = y * info.tile.width * Layer.SCALE
                    local x2 = (x + 1) * info.tile.width * Layer.SCALE
                    local y2 = (y + 1) * info.tile.width * Layer.SCALE
                    colliders:add(x1, y1, x2, y2)
                end
            end
        end
        return colliders
    end

    return layer
end

-- Scene Class
local Scene = {}
function Scene:new()
    local scene = {
        layers = {},
        colliders = Colliders:new()
    }
    setmetatable(scene, self)
    self.__index = self

    function scene:load(path)
        local tilemap = require("tilemap/" .. path)
        local tileset = tilemap.tilesets[1]
        local sheet = love.graphics.newImage(tileset.image:sub(3))
        self.info = {
            tile = {
                width = tileset.tilewidth,
                height = tileset.tileheight
            },
            image = {
                width = tileset.imagewidth,
                height = tileset.imageheight
            },
            columns = tileset.columns
        }
        sheet:setFilter("nearest", "nearest")

        for k, layer in ipairs(tilemap.layers) do
            local l = Layer:new(layer, sheet)
            table.insert(self.layers, l)
            self.colliders:concat(l:createColliders(self.info))
        end
    end

    function scene:draw(pos)
        for k, i in ipairs(self.layers) do
            i:draw(self.info, pos)
        end
    end

    return scene
end

return Scene
