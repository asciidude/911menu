postal = nil
allowed = false
message = ''
input = false

_menuPool = NativeUI.CreatePool()

mainMenu = NativeUI.CreateMenu(Config.menuName, Config.menuDescription, nil, nil, nil, nil, nil, 255, 255, 255, 210)
_menuPool:Add(mainMenu)

if Config.useCategories then
    -- [911 | User (ID)] Category Name at 000000
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            postal = exports['nearest-postal']:getPostal()
        end
    end)

    categories = {}
    for _, category in ipairs(Config.categories) do
        table.insert(
            categories,
            {
                NativeUI.CreateItem(category, '~b~Submit a call about (a/an) ' .. category),
                category
            }
        )
    end


    for _, catItem in ipairs(categories) do mainMenu:AddItem(catItem[1]) end

    mainMenu.OnItemSelect = function(sender, item, index)
        for _, catItem in ipairs(categories) do
            if item == catItem[1] then
                if Config.useDiscord then
                    TriggerServerEvent('SubmitWebhook', catItem[2] .. ' at ' .. postal, GetPlayerName(PlayerId()) .. ' (' .. GetPlayerServerId(PlayerId()) .. ')')
                    TriggerEvent('chat:addMessage', {
                        color = { 255, 0, 0 },
                        multiline = true,
                        args = {'[Dispatch]', 'Your call has been recieved and the authorities are on the way!'}
                    })
                else
                    TriggerServerEvent('SubmitMessage', catItem[2] .. ' at ' .. postal, GetPlayerName(PlayerId()) .. ' (' .. GetPlayerServerId(PlayerId()) .. ')')
                end

                break -- Break out the loop for obvious performance reasons
            end
        end
    end
else
    reason = NativeUI.CreateItem('Set Reason', '~r~~h~This will not change the item name, but your reason will be recorded.')
    mainMenu:AddItem(reason)

    submit = NativeUI.CreateItem('Submit Call', '~b~Submit the 911 call to the authorities')
    mainMenu:AddItem(submit)

    mainMenu.OnItemSelect = function(sender, item, index)
        if item == reason then
            DisplayOnscreenKeyboard(false, 'FMMC_KEY_TIP8', '', '', '', '', '', 64)
            input = true
        end

        if item == submit then
            if Config.useDiscord then
                TriggerServerEvent('SubmitWebhook', message, GetPlayerName(PlayerId()) .. ' (' .. GetPlayerServerId(PlayerId()) .. ')')
                TriggerEvent('chat:addMessage', {
                    color = { 255, 0, 0 },
                    multiline = true,
                    args = {'[Dispatch]', 'Your call has been recieved and the authorities are on the way!'}
                })
            else
                TriggerServerEvent('SubmitMessage', message, GetPlayerName(PlayerId()) .. ' (' .. GetPlayerServerId(PlayerId()) .. ')')
            end
        end
    end
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
                    DisplayOnscreenKeyboard(false, 'FMMC_KEY_TIP8', '', '', '', '', '', 64)
                end
            elseif UpdateOnscreenKeyboard() == 2 then
                input = false
            end
        end
    end
end)

RegisterCommand('911', function(source, args)
    if Config.restrictCommand then
        TriggerServerEvent('emergencymenu.isAllowed')

        if allowed then
            if Config.noPermissionMessage ~= false then
                TriggerEvent('chat:addMessage', {
                    color = { 255, 0, 0 },
                    multiline = true,
                    args = {'[911 Menu]', Config.noPermissionMessage}
                })
            end

            return
        end
    end
    
    mainMenu:Visible(not mainMenu:Visible())
end)

RegisterNetEvent('emergencymenu.isAllowed_return')
AddEventHandler('emergencymenu.isAllowed_return', function(isAllowed)
    allowed = isAllowed
end)