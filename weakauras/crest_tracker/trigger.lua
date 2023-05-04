function(allstates)
    local config = aura_env.config
    local fragmentOptions = config.fragmentOptions
    local crestOptions = config.crestOptions
    local gci = C_CurrencyInfo.GetCurrencyInfo
    
    --Flightstones
    local flightstoneId = "2245"
    local fc = gci(flightstoneId)
    local amount = fc.quantity
    local max = fc.maxQuantity
    
    local name = aura_env.names[flightstoneId]
    local value = amount.."/"..max
    
    local shouldShowFlightstones = config.flightstones and (config.flightstonesShowAtCap or amount < max)
    
    allstates[flightstoneId] = {
        changed = true,
        show = shouldShowFlightstones,
        progressType = "static",
        value = aura_env.getColouredText(config.flightstoneValueColour, value),
        icon = aura_env.icons[flightstoneId],
        name = aura_env.getColouredText(config.flightstoneNameColour, name),
        index = aura_env.indices[flightstoneId],
    }
    
    
    --Fragments total
    for fragmentId, isTracked in pairs(config.fragments) do 
        local currency = gci(fragmentId)
        
        local earned = currency.totalEarned 
        local max = currency.maxQuantity
        
        local shouldShow = isTracked and (fragmentOptions.showAtCap or earned < max)
        
        local name = fragmentOptions.showName and aura_env.names[fragmentId] or ""
        local value = earned.."/"..max
        
        allstates[fragmentId] = {
            changed = true, 
            show = shouldShow,
            progressType = "static",
            value = aura_env.getColouredText(fragmentOptions.colours[fragmentId], value),
            icon = aura_env.icons[fragmentId],
            name = aura_env.getColouredText(fragmentOptions.colours[fragmentId], name),
            index = aura_env.indices[fragmentId],
        }
        
    end
    
    --Crests in inventory
    for crestId, isTracked in pairs(config.crests) do
        
        local count = GetItemCount(crestId)
        local fragmentsInInventory = GetItemCount(aura_env.crestToFragmentMap[crestId])
        local crestsInFragments = math.floor(fragmentsInInventory/15)
        local totalCrestCount = count + crestsInFragments
        
        local shouldShow = isTracked and (totalCrestCount > 0 or crestOptions.showAtNone)
        
        local name = crestOptions.showName and aura_env.names[crestId] or ""
        local value = count.." (+"..crestsInFragments..")"
        
        allstates[crestId] = {
            changed = true, 
            show = shouldShow,
            progressType = "static",
            value = aura_env.getColouredText(crestOptions.colours[crestId], value),
            icon = aura_env.icons[crestId],
            name = aura_env.getColouredText(crestOptions.colours[crestId], name),
            index = aura_env.indices[crestId],
        }
    end
    
    return true
end


