message = ''
input = false

_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu(Config.menuName, Config.menuDescription, nil, nil, nil, nil, nil, 255, 255, 255, 210)
_menuPool:Add(mainMenu)

if Config.useCategories == false then
    reason = NativeUI.CreateItem("Set Reason", "~r~~h~This will not change the item name, but your reason will be recorded.")
    mainMenu:AddItem(reason)

    submit = NativeUI.CreateItem("Submit Call", "~b~Submit the 911 call to the authorities")
    mainMenu:AddItem(submit)

    mainMenu.OnItemSelect = function(sender, item, index)
        if item == reason then
            DisplayOnscreenKeyboard(false, "FMMC_KEY_TIP8", "", "", "", "", "", 64)
            input = true
        end

        if item == submit then
            if Config.useDiscord then
                TriggerServerEvent('SubmitWebhook', message, nil, GetPlayerName(PlayerId()) .. ' (' .. GetPlayerServerId(PlayerId()) .. ')')
                TriggerEvent('chat:addMessage', {
                    color = { 255, 0, 0 },
                    multiline = true,
                    args = {"[Dispatch]", "Your call has been recieved and the authorities are on the way!"}
                })
            else
                TriggerServerEvent('SubmitMessage', message, nil, GetPlayerName(PlayerId()) .. ' (' .. GetPlayerServerId(PlayerId()) .. ')')
            end
        end
    end
else
    -- Still a work in progress
end

-- EOF --
_menuPool:RefreshIndex()

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        _menuPool:ProcessMenus()

        if input == true then
            mainMenu:Visible(false)
            HideHudAndRadarThisFrame()
            if UpdateOnscreenKeyboard() == 3 then
                input = false
            elseif UpdateOnscreenKeyboard() == 1 then
                message = GetOnscreenKeyboardResult()
                if string.len(message) > 0 then
                    mainMenu:Visible(true)
                    input = false
                else
                    DisplayOnscreenKeyboard(false, "FMMC_KEY_TIP8", "", "", "", "", "", 64)
                end
            elseif UpdateOnscreenKeyboard() == 2 then
                input = false
            end
        end
    end
end)

RegisterCommand('911', function(source, args)
    mainMenu:Visible(not mainMenu:Visible())
end)