local Modules = Modules or {}

Modules.Vec = Modules.Vec or require "modules.vec"
if not (Modules.Colliders and Modules.Collider) then
    Modules.Colliders, Modules.Collider = require "modules.collider"
end
return Modules
