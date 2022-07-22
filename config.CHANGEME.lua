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

Config.useDiscord = true -- If true, it will NOT use in-game chat. I highly recommend turning this to true
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
        'Operator Call',
        true
    },
    {
        'Abandoned Automobile',
        false
    },
    {
        'Store/Bank Alarm',
        false
    },
    {
        'Animal Bite',
        false
    },
    {
        -- I really recommend keeping this "Other" category :p
        'Other',
        true
    }
}