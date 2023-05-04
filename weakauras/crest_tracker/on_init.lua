aura_env.icons = {
    -- ["id"] = iconID,
    -- id is used as the key in custom options
    -- iconID is the ID of the icon you want shown for the currency, if you don't define one, the fallback icon will be used

    -- Currencies
    ["2245"] = 5172976, -- Flightstones
    ["2409"] = 5062636, -- Whelpling Crest Fragment
    ["2410"] = 5062624, -- Drake Crest Fragment
    ["2411"] = 5062642, -- Wyrm Crest Fragment
    ["2412"] = 5062612, -- Aspect Crest Fragment
    -- Items
    ["204193"] = 5062634, -- Whelpling's Shadowflame Crest
    ["204195"] = 5062613, -- Drake's Shadowflame Crest
    ["204196"] = 5062637, -- Wyrm's Shadowflame Crest
    ["204194"] = 5062582 -- Aspect's Shadowflame Crest
}

aura_env.names = {
    -- Currencies
    ["2245"] = "Flightstones", -- Flightstones
    ["2409"] = "Whelpling Fragment", -- Whelpling Crest Fragment
    ["2410"] = "Drake Fragment", -- Drake Crest Fragment
    ["2411"] = "Wyrm Fragment", -- Wyrm Crest Fragment
    ["2412"] = "Aspect Fragment", -- Aspect Crest Fragment
    -- Items
    ["204193"] = "Whelpling Crest", -- Whelpling's Shadowflame Crest
    ["204195"] = "Drake Crest", -- Drake's Shadowflame Crest
    ["204196"] = "Wyrm Crest", -- Wyrm's Shadowflame Crest
    ["204194"] = "Aspect Crest" -- Aspect's Shadowflame Crest
}

aura_env.indices = {
    -- Currencies
    ["2245"] = 1, -- Flightstones
    ["2409"] = 2, -- Whelpling Crest Fragment
    ["2410"] = 3, -- Drake Crest Fragment
    ["2411"] = 4, -- Wyrm Crest Fragment
    ["2412"] = 5, -- Aspect Crest Fragment
    -- Items
    ["204193"] = 6, -- Whelpling's Shadowflame Crest
    ["204195"] = 7, -- Drake's Shadowflame Crest
    ["204196"] = 8, -- Wyrm's Shadowflame Crest
    ["204194"] = 9 -- Aspect's Shadowflame Crest
}

aura_env.crestToFragmentMap = {
    ["204193"] = 204075, -- Whelpling's Shadowflame Crest
    ["204195"] = 204076, -- Drake's Shadowflame Crest
    ["204196"] = 204077, -- Wyrm's Shadowflame Crest
    ["204194"] = 204078 -- Aspect's Shadowflame Crest
}

local config = aura_env.config

local getColour = function(colour)
    return CreateColor(unpack(colour)):GenerateHexColor()
end

aura_env.getColouredText = function(colourTable, text)
    local colour = getColour(colourTable)
    return "|c" .. colour .. text .. "|r"
end

aura_env.getCrestCount = function(crestId, count, countInFrag)
    local color = getColour(config.crestOptions.colours[crestId])
    return "|c" .. color .. count .. " (+" .. countInFrag .. ")|r"
end
