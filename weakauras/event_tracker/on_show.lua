local config = aura_env.config.events[aura_env.cloneId]
local colour = config.colour
local clone = aura_env.state

if (clone and not clone.event_active and colour and config.tracked and aura_env.region) then
    aura_env.region:Color(colour[1], colour[2], colour[3], colour[4])
end