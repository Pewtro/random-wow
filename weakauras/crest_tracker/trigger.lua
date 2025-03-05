function(allstates)
    local config = aura_env.config
    local crestOptions = config.crestOptions
    local nascentOptions = config.nascentOptions
    local gci = C_CurrencyInfo.GetCurrencyInfo
    
    --Flight/Valorstones
    local stones = aura_env.table["stones"].currency
    local fc = gci(stones.id)
    local amount = fc.quantity
    local max = fc.maxQuantity
    
    local name = aura_env.config.showValorstonesName and fc.name or ""
    local value = amount.."/"..max
    
    local shouldShowValorstones = config.valorstones and (config.valorstonesShowAtCap or amount < max)
    
    allstates[stones.id] = {
        changed = true,
        show = shouldShowValorstones,
        progressType = "static",
        amount = aura_env.getColouredText(config.valorstoneValueColour, value),
        icon = fc.iconFileID,
        name = aura_env.getColouredText(config.valorstoneNameColour, name),
        index = stones.index,
    }
    
    
    --Crests
    for crestRank, isTracked in pairs(config.crests) do 
        local crest = aura_env.table[crestRank]
        local crestId = crest.currency.id
        local currency = gci(crestId)
        
        local earned = currency.totalEarned
        local max = currency.maxQuantity
        
        local hasAchievement = false
        if (C_AchievementInfo.IsValidAchievement(crest.achievement)) then
            hasAchievement = select(13, GetAchievementInfo(crest.achievement))
        end
        
        
        -- max == 0 indicates the cap has been removed so they can be shown regardless of amount earned
        local shouldShow = isTracked and (crestOptions.showAtCap or earned < max or max == 0) and (not crestOptions.hideAchievement or crestOptions.hideAchievement and not hasAchievement)
        
        local name = currency.name
        
        if (name and crestOptions.shortenName) then
            local indexToSplit = string.find(name, " ")
            name = string.sub(name, 1, indexToSplit-1)
        end
        
        local value = ""
        if (crestOptions.showCapProgress) then 
            if (max ~= 0) then
                value = earned.."/"..max
            else 
                value = earned
            end
        end
        
        if (crestOptions.showCapProgress and crestOptions.showCurrent) then
            value = " - " .. value
        end
        
        if (crestOptions.showCurrent) then
            value = currency.quantity .. value
        end
        
        allstates[crestId] = {
            changed = true, 
            show = shouldShow,
            progressType = "static",
            amount = aura_env.getColouredText(crestOptions.colours[crestRank], value),
            icon = currency.iconFileID,
            name =  crestOptions.showName and aura_env.getColouredText(crestOptions.colours[crestRank], name) or "",
            index = crest.currency.index,
        }
        
    end
    
    --Nascent Crests
    for nascentRank, isTracked in pairs(config.nascents) do
        local crest = aura_env.table[nascentRank]
        local nascentId = crest.item.id
        
        local count = GetItemCount(nascentId, true)
        
        local availableCrests = gci(crest.currency.id).quantity
        
        local nascentsInCurrency = math.floor(availableCrests/crest.item.cost)
        
        local totalNascentCount = count + nascentsInCurrency
        
        local hasAchievement = false
        if (C_AchievementInfo.IsValidAchievement(crest.achievement)) then
            hasAchievement = select(13, GetAchievementInfo(crest.achievement))
        end
        
        
        local shouldShow = isTracked and (count > 0 or (nascentOptions.showFromFragments and totalNascentCount > 0) or nascentOptions.showAtNone) and (not nascentOptions.hideAchievement or nascentOptions.hideAchievement and not hasAchievement)
        
        local name, _, _, _, _, _, _, _, _, icon = GetItemInfo(nascentId)
        
        if (name and nascentOptions.shortenName) then
            local firstSpace = string.find(name, " ")
            local indexToSplit = string.find(name, " ", firstSpace+1)
            name = string.sub(name, 1, indexToSplit-1)
            name = name:sub(1,1).."."..string.sub(name, firstSpace, indexToSplit-1)
        end
        
        local value = count 
        if (nascentOptions.showPurchasable) then
            value = value.." (+"..nascentsInCurrency..")"
        end
        
        
        allstates[nascentId] = {
            changed = true, 
            show = shouldShow,
            progressType = "static",
            amount = aura_env.getColouredText(nascentOptions.colours[nascentRank], value),
            icon = icon,
            name = nascentOptions.showName and aura_env.getColouredText(nascentOptions.colours[nascentRank], name) or "",
            index = crest.item.id,
        }
    end
    
    return true
end

