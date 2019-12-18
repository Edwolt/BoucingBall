local Modules = Modules or {}

Modules.Vec = Modules.Vec or require "modules.vec"

if Modules.Colliders == nil or Modules.Collider == nil then
    local aux = require "modules.collider"
    Modules.Colliders = aux.Colliders
    Modules.Collider = aux.Collider
end
return Modules
