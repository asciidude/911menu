--[[
    Rename this file to config.lua :)

    THIS SCRIPT DEPENDS ON NATIVEUILUA-RELOADED
    FOUND HERE: https://github.com/FrazzIe/NativeUILua
    ^ MUST BE NAMED NativeUI

    THIS SCRIPT __ALSO__ DEPENDS ON nearest-postal BY DevBlocky IF YOU
    ARE USING CATEGORIES! https://github.com/DevBlocky/nearest-postal
    ^ RESOURCE MUST BE NAMED nearest-postal

    DO NOT REUPLOAD WITHOUT MY PERMISSION
    asciidude#0001 on Discord for any support-related issues
]]--

Config = {}

Config.commandName = '911'
Config.restrictCommand = false -- WARNING: UNTESTED FEATURE, ACE permission: emergencymenu.open (add_ace group.civ emergencymenu.open allow)
Config.noPermissionMessage = '~r~Sorry, you aren\'t allowed to open this menu!' -- Set to false to disable, this wont be used if restrictCommand is set to false

Config.menuName = '911 Menu'
Config.menuDescription = '~b~Report emergencies here'

--[[
    useDiscord must be set to false for emergencycalls to work
    Setting to true: disables global emergency calls, sends only to people with the ACE permission "emergencymenu.emergencycalls"
    Setting to false: enables global emergency calls (not recommended)
    Restarting this script means any emergency call members must restart their game
]]--

Config.emergencycalls = false

-- This will work with emergency calls permission along with global chats
-- This creates a blip at any call locations, postals still being provided
-- WARNING: These blips delete after every new 911 call from the same member and any time the player is dropped (aka leaves)
Config.enableBlips = true
Config.blipID = 57 -- The blip to show, https://docs.fivem.net/docs/game-references/blips/#BlipColors
Config.blipColor = 3 -- The blip color, shown at the bottom of this page ^

Config.useDiscord = false -- If true, it will NOT use in-game chat. I highly recommend turning this to true
Config.webhookURL = 'https://discord.com/api/webhooks/999524839515770920/ASmxt0y0nzPeNlb6-31hCsXipRSIstAs6-MxnqM-f8JsWMMvNxXrt5nZWwQ1qFEMhSDd' -- The webhook of the channel to send to
Config.webhookName = '911 Calls by asciidude'
Config.webhookImage = '' -- The icon of the webhook
Config.webhookStartNotify = false -- Notify once the script starts

-- Categories means that the server MUST have postals installed, as it will say "[911 | <Reporter> (<ID>)] <Category Name> at <Postal>", eg "Noise Disturbance at 2000"
Config.useCategories = true -- Setting to false will basically make this /911 <reason> in menu-form
Config.categories = {
    --[[
        {
            'Category Name',
            false -- Request input? (adds input to end of call, extremely helpful for things like "Other")
        }
    ]]--

    {
        'High Priority Call',
        true
    },
    {
        'Medium Priority Call',
        true
    },
    {
        'Low Priority Call',
        true
    },
    {
        -- I really recommend keeping this "Other" category :p
        'Other',
        true
    }
}