function(allstates)
    local config = aura_env.config
    local crestOptions = config.crestOptions
    local nascentOptions = config.nascentOptions
    local gci = C_CurrencyInfo.GetCurrencyInfo
    
    --Flightstones
    local flightstoneId = "2245"
    local fc = gci(flightstoneId)
    local amount = fc.quantity
    local max = fc.maxQuantity
    
    local name = aura_env.config.showFlightstonesName and fc.name or ""
    local value = amount.."/"..max
    
    local shouldShowFlightstones = config.flightstones and (config.flightstonesShowAtCap or amount < max)
    
    allstates[flightstoneId] = {
        changed = true,
        show = shouldShowFlightstones,
        progressType = "static",
        value = aura_env.getColouredText(config.flightstoneValueColour, value),
        icon = fc.iconFileID,
        name = aura_env.getColouredText(config.flightstoneNameColour, name),
        index = aura_env.indices[flightstoneId],
    }
    
    
    --Crests
    for crestId, isTracked in pairs(config.crests) do 
        local currency = gci(crestId)
        
        local earned = currency.totalEarned 
        local max = currency.maxQuantity
        
        local shouldShow = isTracked and (crestOptions.showAtCap or earned < max)
        
        local name = crestOptions.showName and currency.name or ""
        
        local value = earned.."/"..max
        
        allstates[crestId] = {
            changed = true, 
            show = shouldShow,
            progressType = "static",
            value = aura_env.getColouredText(crestOptions.colours[crestId], value),
            icon = currency.iconFileID,
            name = aura_env.getColouredText(crestOptions.colours[crestId], name),
            index = aura_env.indices[crestId],
        }
        
    end
    
    --Nascent Crests
    for nascentId, isTracked in pairs(config.nascents) do
        
        local count = GetItemCount(nascentId, true)
        
        local currencyId = aura_env.nascentToCrestMap[nascentId]
        local currency = gci(currencyId)
        local availableCrests = currency.quantity
        
        local nascentCost = aura_env.nascentCost[nascentId]
        local nascentsInCurrency = math.floor(availableCrests/nascentCost)
        
        local totalNascentCount = count + nascentsInCurrency
        
        local shouldShow = isTracked and (count > 0 or (nascentOptions.showFromFragments and totalNascentCount > 0) or nascentOptions.showAtNone)
        
        local name, _, _, _, _, _, _, _, _, icon = GetItemInfo(nascentId)
        
        local value = count 
        if(nascentOptions.showPurchasable) then
            value = value.." (+"..nascentsInCurrency..")"
        end
        
        allstates[nascentId] = {
            changed = true, 
            show = shouldShow,
            progressType = "static",
            value = aura_env.getColouredText(nascentOptions.colours[nascentId], value),
            icon = icon,
            name = aura_env.getColouredText(nascentOptions.colours[nascentId], name),
            index = aura_env.indices[nascentId],
        }
    end
    
    return true
end


