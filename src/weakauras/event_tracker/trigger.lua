function(allstates, triggerEvent, id)
    if triggerEvent == "THE_WAR_WITHIN_EVENT_TRACKER" and id == aura_env.id
    or triggerEvent == "STATUS" or triggerEvent == "OPTIONS"
    then
        -- Events can have the following properties:
        -- name: The name of the event
        -- activeName: (Optional) The name to be shown when event is active
        -- frequency: The frequency of the event in seconds
        -- duration: The duration of the event in seconds
        -- icon: The icon to display for the event
        -- quests?: A list of quest IDs to track for the event
        -- achievements?: A list of achievement IDs to track for the event
        -- start: A list of epoch times for the start of the event for each region
        for key, event in pairs(aura_env.events) do
            local config = aura_env.config["events"][key]
            
            local start = type(event.start) == "table" and event.start[GetCurrentRegion()] or event.start
            local next = event.frequency - ((GetServerTime() - start) % event.frequency)
            local event_active = (event.frequency - next) < event.duration
            local remaining_active = event.duration - (event.frequency - next)
            
            local isCompleted = false
            if (config.hide) then
                if(event.quests) then
                    for _, questID in ipairs(event.quests) do
                        if C_QuestLog.IsQuestFlaggedCompleted(questID) then
                            isCompleted = true
                        end
                    end
                end
                if(event.achievements) then
                    for _, achievementID in ipairs(event.achievements) do
                        local id, name, points, completed, month, day, year, description, flags,
                        icon, rewardText, isGuild, wasEarnedByMe, earnedBy, isStatistic = GetAchievementInfo(achievementID)
                        if wasEarnedByMe then
                            isCompleted = true
                        end
                    end
                end
            end
            
            allstates[key] = {
                -- static properties
                changed = true,
                progressType = "timed",
                autoHide = true,
                -- data options 
                name = event_active and event.activeName and event.activeName or event.name,
                icon = event.icon,
                -- dynamic properties
                show = config.tracked and not isCompleted,
                duration = event_active and event.duration or event.frequency-event.duration,
                expirationTime = GetTime() + (event_active and remaining_active or next),
                -- custom properties
                event_active = event_active,
                sound_alert = config.sound_alert
                
            }            
        end
        
        return true
        
    end
    
end




