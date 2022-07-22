--[[
    THIS SCRIPT DEPENDS ON NATIVEUILUA-RELOADED
    FOUND HERE: https://github.com/FrazzIe/NativeUILua
    ^ MUST BE NAMED NativeUI

    THIS SCRIPT __ALSO__ DEPENDS ON nearest-postal BY DevBlocky IF YOU
    ARE USING CATEGORIES! https://github.com/DevBlocky/nearest-postal
    ^ RESOURCE MUST BE NAMED nearest-postal

    asciidude#0001 on Discord for support-related issues
    DO NOT REUPLOAD WITHOUT MY PERMISSION
]]--

fx_version 'cerulean'
game 'gta5'
description '911 Menu created by asciidude'

server_script 'server.lua'

client_scripts {
    '@NativeUI/NativeUI.lua',
    'client.lua'
}

shared_scripts {
    'config.lua',
    'functions.lua'
}
