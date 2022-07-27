postal = nil
allowed = false
message = ''
input = false

_menuPool = NativeUI.CreatePool()
_menuPool:MouseControlsEnabled(false)
_menuPool:MouseEdgeEnabled(false)
_menuPool:ControlDisablingEnabled(false)

mainMenu = NativeUI.CreateMenu(Config.menuName, Config.menuDescription)
_menuPool:Add(mainMenu)

if Config.useCategories then
    -- [911 | User (ID)] Category Name at 000000
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            postal = exports['ncsrp_postal']:getPostal()
        end
    end)

    categories = {}

    for _, category in ipairs(Config.categories) do
        table.insert(
            categories,
            {
                NativeUI.CreateItem(category[1], '~b~Submit a call about (a/an) ' .. category[1]),
                category[1],
                category[2]
            }
        )
    end

    for _, catItem in ipairs(categories) do mainMenu:AddItem(catItem[1]) end

    mainMenu.OnItemSelect = function(sender, item, index)
        for _, catItem in ipairs(categories) do
            if item == catItem[1] then
                if Config.useDiscord then
                    if catItem[3] then
                        input = true
                        DisplayOnscreenKeyboard(false, 'FMMC_KEY_TIP8', '', '', '', '', '', 64)

                        Citizen.CreateThread(function()
                            while true do
                                Citizen.Wait(0)
                                if input == false then
                                    TriggerServerEvent('emergencymenu.submitWebhook', catItem[2] .. ' at ' .. postal .. ': ' .. message, GetPlayerName(PlayerId()) .. ' (' .. GetPlayerServerId(PlayerId()) .. ')')
                                    TriggerEvent('chat:addMessage', {
                                        color = { 255, 0, 0 },
                                        multiline = true,
                                        args = {'[Dispatch]', 'Your call has been recieved and the authorities are on the way!'}
                                    })

                                    break
                                end
                            end
                            
                            return
                        end)
                    else
                        TriggerServerEvent('emergencymenu.submitWebhook', catItem[2] .. ' at ' .. postal, GetPlayerName(PlayerId()) .. ' (' .. GetPlayerServerId(PlayerId()) .. ')')
                        TriggerEvent('chat:addMessage', {
                            color = { 255, 0, 0 },
                            multiline = true,
                            args = {'[Dispatch]', 'Your call has been recieved and the authorities are on the way!'}
                        })
                    end
                else
                    if catItem[3] then
                        input = true
                        DisplayOnscreenKeyboard(false, 'FMMC_KEY_TIP8', '', '', '', '', '', 64)

                        Citizen.CreateThread(function()
                            while true do
                                Citizen.Wait(0)
                                if input == false then
                                    TriggerServerEvent('emergencymenu.submitMessage', catItem[2] .. ' at ' .. postal .. ": " .. message, GetPlayerName(PlayerId()) .. ' (' .. GetPlayerServerId(PlayerId()) .. ')')
                                    
                                    if Config.emergencycalls then
                                        TriggerEvent('chat:addMessage', {
                                            color = { 255, 0, 0 },
                                            multiline = true,
                                            args = {'[Dispatch]', 'Your call has been recieved and the authorities are on the way!'}
                                        })
                                    end

                                    break
                                end
                            end
                            
                            return
                        end)
                    else
                        TriggerServerEvent('emergencymenu.submitMessage', catItem[2] .. ' at ' .. postal, GetPlayerName(PlayerId()) .. ' (' .. GetPlayerServerId(PlayerId()) .. ')')

                        if Config.emergencycalls then
                            TriggerEvent('chat:addMessage', {
                                color = { 255, 0, 0 },
                                multiline = true,
                                args = {'[Dispatch]', 'Your call has been recieved and the authorities are on the way!'}
                            })
                        end
                    end
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
                TriggerServerEvent('emergencymenu.submitWebhook', message, GetPlayerName(PlayerId()) .. ' (' .. GetPlayerServerId(PlayerId()) .. ')')
                TriggerEvent('chat:addMessage', {
                    color = { 255, 0, 0 },
                    multiline = true,
                    args = {'[Dispatch]', 'Your call has been recieved and the authorities are on the way!'}
                })
            else
                TriggerServerEvent('emergencymenu.submitMessage', message, GetPlayerName(PlayerId()) .. ' (' .. GetPlayerServerId(PlayerId()) .. ')')
                
                if Config.emergencycalls == false then
                    TriggerEvent('chat:addMessage', {
                        color = { 255, 0, 0 },
                        multiline = true,
                        args = {'[Dispatch]', 'Your call has been recieved and the authorities are on the way!'}
                    })
                end
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

RegisterCommand('call911', function(source, args)
    if Config.restrictCommand then
        TriggerServerEvent('emergencymenu.isAllowed', GetPlayerServerId(PlayerId()))

        if allowed == false then
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

RegisterNetEvent('emergencymenu.addBlip')
AddEventHandler('emergencymenu.addBlip', function()
    local playerPos = GetEntityCoords(GetPlayerPed(-1))
    local playerName = GetPlayerName(PlayerId())
    local blip = AddBlip(playerName .. '\'s 911 Call', Config.blipID, playerPos, Config.blipColor)
    TriggerServerEvent('emergencymenu.appendBlip', blip, GetPlayerServerId(PlayerId()))
end)

RegisterNetEvent('emergencymenu.removeBlip')
AddEventHandler('emergencymenu.removeBlip', function(blip)
    RemoveBlip(blip)
end)

AddEventHandler('playerSpawned', function()
    if Config.emergencycalls then
        TriggerServerEvent('emergencymenu.load911chat', GetPlayerServerId(PlayerId()))
    end
end)

AddEventHandler('playerDropped', function()
    if Config.emergencycalls then
        TriggerServerEvent('emergencymenu.removeCallMember', GetPlayerServerId(PlayerId()))
    end

    if Config.enableBlips then
        TriggerServerEvent('emergencymenu.removePlayerBlip', blip, GetPlayerServerId(PlayerId()))
    end
end)