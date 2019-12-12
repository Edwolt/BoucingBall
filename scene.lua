Vec = Vec or require "vec"

-- Layer Class
local Layer = {}

function Layer:new(l, sheet)
    local layer = {
        data = l.data,
        sheet = sheet
    }
    setmetatable(layer, self)
    self.__index = self

    function layer:draw(info) -- TODO fazer o draw funcionar
        for k, i in ipairs(self.data) do
            if i ~= 0 then
                local screen_pos = Vec:new(math.floor(k / info.columns), k % info.columns)
                local tile_pos = Vec:new(math.floor(i / info.columns), i % info.columns)

                local quad =
                    love.graphics.newQuad(
                    tile_pos.x * info.tile.width,
                    tile_pos.y * info.tile.height,
                    info.tile.width,
                    info.tile.height,
                    info.image.width,
                    info.image.height
                )

                self:_draw(screen_pos, quad, info)
            end
        end
    end

    function layer:_draw(screen_pos, quad, info)
        local x = screen_pos.x * info.tile.width
        local y = screen_pos.y * info.tile.height

        love.graphics.draw(self.sheet, quad, x, y)
    end

    return layer
end

-- Scene Class
local Scene = {}

function Scene:new()
    local scene = {
        layers = {}
    }
    setmetatable(scene, self)
    self.__index = self

    function scene:load(path)
        local tilemap = require("tilemap/" .. path)
        local tileset = tilemap.tilesets[1]
        local sheet = love.graphics.newImage(tileset.image)
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
            table.insert(self.layers, (Layer:new(layer, sheet)))
        end
    end

    function scene:draw()
        for k, i in ipairs(self.layers) do
            i:draw(self.info)
        end
    end

    return scene
end

return Scene
