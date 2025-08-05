function(allstates)
    local config = aura_env.config
    aura_env.ingredients = {}
    for factionId, npc in pairs(aura_env.npcs) do
        local dish = npc.dish
        local ingredients = npc.ingredients
        local isTurnedIn = C_QuestLog.IsQuestFlaggedCompleted(npc.quest)
        local friendship = C_GossipInfo.GetFriendshipReputation(factionId)
        if(
            (not isTurnedIn or not config.ignoreCompleted) and
            (friendship.standing<(friendship.maxRep-1) or config.showAtMaxFriendship)
        ) then
            local dishCount = C_Item.GetItemCount(dish.id, config.includeBank)
            if(config.trackDishes) then
                local name, _, _,_,_,_,_,_,_,icon = C_Item.GetItemInfo(dish.id)
                
                allstates[dish.id] = {
                    show = true,
                    changed = true, 
                    index = factionId,
                    icon = icon, 
                    name = name,
                    value = dishCount,
                    total = dish.count,
                }
            end
            if(config.trackIngredients) then
                for _, ingredient in pairs(ingredients) do
                    aura_env.ingredients[ingredient.id] = (aura_env.ingredients[ingredient.id] or 0) + ingredient.count
                    if(config.hideIngredientsWithDish and dishCount > 0) then
                        local amountToRemove = math.min(dishCount * (ingredient.count/dish.count), ingredient.count)
                        aura_env.ingredients[ingredient.id] = aura_env.ingredients[ingredient.id] - amountToRemove
                    end
                    local name, _, _,_,_,_,_,_,_,icon = C_Item.GetItemInfo(ingredient.id)
                    allstates[ingredient.id] = {
                        show = true, 
                        changed = true,
                        index = ingredient.id,
                        icon = icon,
                        name = name, 
                        value = C_Item.GetItemCount(ingredient.id, config.includeBank),
                        total = aura_env.ingredients[ingredient.id],
                    }
                end
                
            end
        end
    end
    return true
end

