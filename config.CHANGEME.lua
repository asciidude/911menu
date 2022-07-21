--[[
    Rename this file to config.lua :)

    THIS SCRIPT DEPENDS ON NATIVEUILUA-RELOADED
    FOUND HERE: https://github.com/MrMathias154/NativeUILua-Reloaded
    ^ MUST BE NAMED NativeUI

    DO NOT REUPLOAD WITHOUT MY PERMISSION
    asciidude#0001 on Discord for any support-related issues
]]--

Config = {}

Config.commandName = '911'
Config.menuName = '911 Menu'
Config.menuDescription = '~b~Report emergencies here'

Config.useDiscord = true -- If true, it will NOT use in-game chat. I highly recommend turning this to true
Config.webhookURL = 'https://discord.com/api/webhooks/999522066548137984/3pItT7BNdpgMeCJVF5KNcR40l-kzMwoYeYHSMGOStdcj8I3iQbj5YeWEPsQP-MTKBDed' -- The webhook of the channel to send to
Config.webhookName = '911 Calls by asciidude'
Config.webhookImage = 'https://icon-library.com/images/911-icon/911-icon-24.jpg' -- The icon of the webhook
Config.webhookStartNotify = false -- Notify once the script starts

-- Recommended to keep false - may slow down server upon loading menu!
Config.useCategories = false -- False: Kinda like /911 <reason>, true: force player to select from a category
Config.categories = {
    'Operator Call',
    'Abandoned Automobile',
    'Store/Bank Alarm',
    'Animal Bite',
    'Animal Cruelty',
    'Other'
}