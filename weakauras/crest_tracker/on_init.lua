aura_env.table = {
    --The generic stones currency
    ["stones"] = { 
        currency = { id = 3008, index = 1 }, --Valorstones
    },
    --Weathered
    ["rank1"] = { 
        currency  = { id = 3107, index = 2 }, --Weathered Undermine Crest
        item = { cost = 30, id = 230937, index = 6 }, --Nascent Weathered Undermine Crest
        achievement = 40942, --Weathered of the Undermine
    },
    --Carved
    ["rank2"] = { 
        currency = { id = 3108, index = 3 }, --Carved Undermine Crest
        achievement = 40943, --Carved of the Undermine
    },
    --Runed
    ["rank3"] = {
        currency  = { id = 3109, index = 4 }, --Runed Undermine Crest
        item = { cost = 45, id = 230936, index = 7 }, --Nascent Runed Undermine Crest
        achievement = 40944, --Runed of the Undermine
    },
    --Gilded
    ["rank4"] = {
        currency  = { id = 3110, index = 5 }, --Gilded Undermine Crest
        item = { cost = 90, id = 230935, index = 8 }, --Nascent Gilded Undermine Crest
        achievement = 40945, --Gilded of the Undermine
    },
}

local getColour = function(colour)
    return CreateColor(unpack(colour)):GenerateHexColor()
end

aura_env.getColouredText = function(colourTable, text)
    local textWithFallback = text or "unknown"
    local colour = getColour(colourTable)
    return "|c" .. colour .. textWithFallback .. "|r"
end

