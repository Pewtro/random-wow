aura_env.indices = {
    -- Currencies
    ["2245"] = 1, -- Flightstones
    ["2706"] = 2, -- Whelpling's Dreaming Crest
    ["2707"] = 3, -- Drake's Dreaming Crest
    ["2708"] = 4, -- Wyrm's Dreaming Crest
    ["2709"] = 5, -- Aspect's Dreaming Crest
    -- Items
    ["208395"] = 6, -- Nascent Whelpling's Dreaming Crest
    ["208394"] = 8, -- Nascent Wyrm's Dreaming Crest
    ["208393"] = 9 -- Nascent Aspect's Dreaming Crest
}

aura_env.nascentToCrestMap = {
    ["208395"] = 2706, -- Nascent Whelpling's Dreaming Crest
    ["208394"] = 2708, -- Nascent Wyrm's Dreaming Crest
    ["208393"] = 2709 -- Nascent Aspect's Dreaming Crest
}

aura_env.nascentCost = {
    ["208395"] = 30, -- Nascent Whelpling's Dreaming Crest
    ["208394"] = 45, -- Nascent Wyrm's Dreaming Crest
    ["208393"] = 60 -- Nascent Aspect's Dreaming Crest
}

local config = aura_env.config

local getColour = function(colour)
    return CreateColor(unpack(colour)):GenerateHexColor()
end

aura_env.getColouredText = function(colourTable, text)
    local textWithFallback = text or "unknown"
    local colour = getColour(colourTable)
    return "|c" .. colour .. textWithFallback .. "|r"
end

aura_env.getCrestCount = function(crestId, count, countInFrag)
    local color = getColour(config.crestOptions.colours[crestId])
    return "|c" .. color .. count .. " (+" .. countInFrag .. ")|r"
end
