function(allstates)
    -- Generic Variables
    local anyFound = false
    local general = aura_env.config.general 
    
    -- Current Expansion
    local currentExpansion = aura_env.config.currentExpansion
    
    -- C_MajorFactions API
    local GetRenownLevels = C_MajorFactions.GetRenownLevels
    local GetMajorFactionData = C_MajorFactions.GetMajorFactionData
    local HasMaximumRenown = C_MajorFactions.HasMaximumRenown
    
    ------------------------------------------------------------------------------
    
    for factionID, isTracked in pairs(currentExpansion) do 
        
        if isTracked then 
            -- HasMaximumRenown
            local isMaxRenown = HasMaximumRenown(factionID)
            -- GetMajorFactionData
            local factionData = GetMajorFactionData(factionID)
            
            -- Renown
            if factionData and
            (general.showRenownProg or general.showRenownLevel) 
            and not isMaxRenown or (isMaxRenown and not general.hideAtMaxRenown)
            then 
                -- We have atleast found 1 to show
                anyFound = true
                
                local repName = factionData["name"]
                local renownLevel = factionData["renownLevel"]
                local renownReputationEarned = factionData["renownReputationEarned"]
                local renownLevelThreshold = factionData["renownLevelThreshold"]
                
                -- GetRenownLevels
                local allRenownLevels = GetRenownLevels(factionID)
                local maxRenownLevelData = allRenownLevels[#allRenownLevels]
                local maxRenownLevel = maxRenownLevelData["level"]
                
                --Should given renown faction be shown
                local showRenownFaction = renownLevel > 0 or renownReputationEarned > 0 or general.showUnmetRenownFaction
                
                if showRenownFaction then
                    
                    local curVal, threshold, _, hasRewardPending = C_Reputation.GetFactionParagonInfo(factionID)
                    
                    allstates[factionID] = {
                        changed = true,
                        show = true,
                        progressType = "static",
                        value = aura_env.getRenownColouredValue(renownReputationEarned, renownLevelThreshold, renownLevel, maxRenownLevel, isMaxRenown, factionID),
                        icon = aura_env.reputations[factionID],
                        name = aura_env.getColouredRepName(repName)
                    }
                end
            end
            
            -- Reputation
            if not factionData then
                local repName, _, standingId, barMin, barMax, barValue = GetFactionInfoByID(factionID)
                
                local isAssumedUnmet = standingId == 4 and barMin == 0
                
                if barValue and 
                (barValue > 0 or general.showHostile and barValue < 0 or general.showUnmet and isAssumedUnmet) and 
                barValue < 42000 and 
                general.showBeforeExalted
                then
                    
                    -- We have atleast found 1 to show
                    anyFound = true
                    
                    allstates[factionID] = {
                        changed = true,
                        show = true,
                        progressType = "static",
                        value = aura_env.getColouredValue(barMin, barMax, barValue, standingId),
                        icon = aura_env.reputations[factionID],
                        name = aura_env.getColouredRepName(repName)
                    }
                end
                
            end
        end
    end
    
    -- Previous Expansions
    local previousExpansions = aura_env.config.previousExpansions
    
    for xpacKey, _ in pairs(previousExpansions) do
        for factionID, isTracked in pairs(previousExpansions[xpacKey]) do
            if isTracked then
                
                local repName, _, standingId, barMin, barMax, barValue = GetFactionInfoByID(factionID)
                
                local isAssumedUnmet = standingId == 4 and barMin == 0
                
                if barValue and 
                (barValue > 0 or general.showHostile and barValue < 0 or general.showUnmet and isAssumedUnmet) and 
                barValue < 42000 and 
                general.showBeforeExalted
                then
                    
                    -- We have atleast found 1 to show
                    anyFound = true
                    
                    -- Set REPUTATION information for the faction
                    allstates[factionID] = {
                        changed = true,
                        show = true,
                        progressType = "static",
                        value = aura_env.getColouredValue(barMin, barMax, barValue, standingId),
                        icon = aura_env.reputations[factionID],
                        name = aura_env.getColouredRepName(repName)
                    }
                    
                    --Faction is exalted
                elseif general.showAfterExalt then
                    
                    local curVal, threshold, _, hasRewardPending = C_Reputation.GetFactionParagonInfo(factionID)
                    
                    --Faction has paragon rewards possible
                    if curVal and threshold and (not general.onlyShowParagonRewards or hasRewardPending) then 
                        
                        -- We have atleast found 1 to show
                        anyFound = true
                        
                        -- Set PARAGON information for the faction
                        allstates[factionID] = {
                            changed = true,
                            show = true,
                            progressType = "static",
                            value = aura_env.getParagonColouredValue(curVal, threshold, hasRewardPending, standingId),
                            icon = aura_env.reputations[factionID],
                            name = aura_env.getColouredRepName(repName)
                        }
                    end
                end
            end
        end
    end
    -- if non found then show nothing
    if not anyFound then 
        allstates[""] = {
            changed = true,
            show = true,
            name = "",
            icon = "",
        }
    end
    
    return true
end


