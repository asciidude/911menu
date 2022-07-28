--Onyx Development NativeUI Integration
--[[
    HUGE thanks to Alec for supporting this project and fixing some things
    that I could not fix.

    THIS SCRIPT DEPENDS ON nearest-postal BY DevBlocky IF YOU
    ARE USING CATEGORIES! https://github.com/DevBlocky/nearest-postal

    If you are using nearest-postal and change the name, simply change it
    your script name in the client.lua.

    asciidude#0001 on Discord for support-related issues
    DO NOT REUPLOAD WITHOUT MY PERMISSION
]]--

fx_version 'cerulean'
game 'gta5'
description '911 Menu created by asciidude'

server_script 'server.lua'

client_scripts {
    'client/*.lua'
}

shared_scripts {
    'config.lua',
    'functions.lua'
}