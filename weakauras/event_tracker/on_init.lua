-- Events can have the following properties:
-- name: The name of the event
-- activeName: (Optional) The name to be shown when event is active
-- frequency: The frequency of the event in seconds
-- duration: The duration of the event in seconds
-- icon: The icon to display for the event
-- quests?: A list of quest IDs to track for the event
-- achievements?: A list of achievement IDs to track for the event
-- start: A list of epoch times for the start of the event for each region
aura_env.events = {
    ["theater"] = {
        name = "Theater Troupe",
        activeName = "Theater Troupe active",
        frequency = 3600,
        duration = 600,
        icon = 134927,
        quests = {
            83240,
        },
        start = {
            [1] = 1724436000, -- NA
            [2] = 1724436000, -- KR
            [3] = 1724436000, -- EU
            [4] = 1724436000, -- TW
            [5] = 1724436000  -- CN
        },
    },
    ["beledar"] = {
        name = "Beledar's Shadow", 
        activeName = "Beledar's Shadow spawned",
        frequency = 10800,
        duration = 1800,
        icon = 5767210,
        quests = {81763},
        start = (GetServerTime()+GetQuestResetTime())+3660%10800,
    },
    ["storytime"] = {
        name = "Story Time", 
        activeName = "Story Time active",
        frequency = 1800,
        duration = 315,
        icon = 132333,
        achievements = {40992},
        start = (GetServerTime()+GetQuestResetTime())+3660%10800,
    },
    ["mountMania"] = {
        name = "Mount Mania", 
        activeName = "Mount Mania active",
        frequency = 3600,
        duration = 420,
        icon = 132224,
        achievements = {40985},
        start = (GetServerTime()+GetQuestResetTime())+3660+2700%10800,
    },
    ["fashionFrenzy"] = {
        name = "Fashion Frenzy", 
        activeName = "Fashion Frenzy active",
        frequency = 3600,
        duration = 300,
        icon = 4524582,
        achievements = {40987},
        start = (GetServerTime()+GetQuestResetTime())+3660+900%10800,
    },
}

