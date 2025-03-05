function(allstates)
    -- Generic Variables
    local general = aura_env.config.general 
    local colours = aura_env.config.colourOptions
    
    for _, expansion in ipairs(aura_env.expansions) do
        for factionID, isTracked in pairs(aura_env.config[expansion]) do
            if isTracked then 
                
                -- Renown
                local isMaxRenown = C_MajorFactions.HasMaximumRenown(factionID)
                local factionData = C_MajorFactions.GetMajorFactionData(factionID)
                -- Friendship
                local friendship = C_GossipInfo.GetFriendshipReputation(factionID)
                
                --------------------- Check if it's a renown faction ---------------------
                if factionData and
                (general.showRenownProg or general.showRenownLevel) 
                and not isMaxRenown or (isMaxRenown and not general.hideAtMaxRenown)
                then 
                    local repName = factionData["name"]
                    local renownLevel = factionData["renownLevel"]
                    local renownReputationEarned = factionData["renownReputationEarned"]
                    local renownLevelThreshold = factionData["renownLevelThreshold"]
                    
                    -- GetRenownLevels
                    local allRenownLevels = C_MajorFactions.GetRenownLevels(factionID)
                    local maxRenownLevelData = allRenownLevels[#allRenownLevels]
                    local maxRenownLevel = maxRenownLevelData["level"]
                    
                    --Should given renown faction be shown
                    local showRenownFaction = (renownLevel > 0 or renownReputationEarned > 0 or general.showUnmetRenownFaction) and (not general.onlyShowMaxRenownIfParagonBox or hasRewardPending or not isMaxRenown)
                    
                    allstates[factionID] = {
                        changed = true,
                        show = showRenownFaction,
                        progressType = "static",
                        repValue = aura_env.getRenownColouredValue(renownReputationEarned, renownLevelThreshold, renownLevel, maxRenownLevel, isMaxRenown, factionID),
                        icon = aura_env.reputations[factionID],
                        name = aura_env.getColouredRepName(repName)
                    }
                    --------------------- Check if it's a friendship reputation ---------------------
                    --friendship.nextThreshold is nil when a friendship is exalted
                elseif friendship and friendship.maxRep > 0 and friendship.nextThreshold then
                    local barMin = friendship.reactionThreshold
                    local barMax = friendship.nextThreshold or friendship.standing 
                    local barValue = friendship.standing
                    
                    allstates[factionID] = {
                        changed = true,
                        show = true,
                        progressType = "static",
                        repValue = aura_env.getColouredValue(barMin, barMax, barValue, friendship.reaction),
                        icon = aura_env.reputations[factionID],
                        name = aura_env.getColouredRepName(friendship.name)
                    }
                    --------------------- Assume it's a regular reputation ---------------------
                else
                    local fd = C_Reputation.GetFactionDataByID(factionID)
                    
                    local repName = fd.name
                    local standingId = fd.reaction
                    local barMin = fd.currentReactionThreshold
                    local barMax = fd.nextReactionThreshold
                    local barValue = fd.currentStanding
                    
                    local isAssumedUnmet = standingId == 4 and barMin == 0
                    
                    --check if faction has paragon levels
                    local paragonValue = C_Reputation.GetFactionParagonInfo(factionID)
                    
                    if barValue and 
                    (
                        barValue > 0 or 
                        general.showHostile and barValue < 0 or 
                        general.showUnmet and isAssumedUnmet
                    ) and 
                    (
                        barValue < barMax and general.showBeforeExalted or 
                        barValue == barMax and general.showAfterExalted and not paragonValue
                    )
                    then
                        -- Set reputation information for the faction
                        allstates[factionID] = {
                            changed = true,
                            show = true,
                            progressType = "static",
                            repValue = aura_env.getColouredValue(barMin, barMax, barValue, standingId),
                            icon = aura_env.reputations[factionID],
                            name = aura_env.getColouredRepName(repName)
                        }
                        
                        --Faction is exalted
                    elseif general.showAfterExalted then
                        
                        local curVal, threshold, _, hasRewardPending = C_Reputation.GetFactionParagonInfo(factionID)
                        
                        --Faction has paragon rewards possible
                        if curVal and threshold and (not general.onlyShowParagonRewards or hasRewardPending) then 
                            -- Set PARAGON information for the faction
                            allstates[factionID] = {
                                changed = true,
                                show = true,
                                progressType = "static",
                                repValue = aura_env.getParagonColouredValue(curVal, threshold, hasRewardPending, standingId),
                                icon = aura_env.reputations[factionID],
                                name = aura_env.getColouredRepName(repName)
                            }
                        end
                    end
                end
            end
        end
    end
    
    local count = 0
    for k in pairs(allstates) do
        if allstates[k].show then
            count = count + 1
            break
        end 
    end
    -- if non found then show nothing
    if count == 0 then 
        allstates[""] = {
            changed = true,
            show = true,
            name = "",
            icon = "",
        }
    end
    
    return true
end

