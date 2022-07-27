callmembers = {}
blips = {} -- Check if members license is the same, if so remove blip

RegisterServerEvent('emergencymenu.load911chat')
RegisterServerEvent('emergencymenu.load911chat', function(id)
    if IsPlayerAceAllowed(id, 'emergencymenu.emergencycalls') then
        table.insert(callmembers, id)
    end
end)

RegisterServerEvent('emergencymenu.submitWebhook')
AddEventHandler('SubmitWebhook', function(message, source, call)
    SendToWebhook(message .. '\n*Call from ' .. source .. ' at ' .. os.date('%c') .. '*', true)

    if Config.emergencycalls then
        for _, id in ipairs(callmembers) do
            TriggerClientEvent('emergencymenu.addBlip', id)
        end
    else
        TriggerClientEvent('emergencymenu.addBlip', -1)
    end
end)

RegisterServerEvent('emergencymenu.submitMessage')
AddEventHandler('emergencymenu.submitMessage', function(message, source)
    if Config.emergencycalls then
        for _, id in ipairs(callmembers) do
            TriggerClientEvent('chat:addMessage', id, {
                color = { 255, 0, 0 },
                multiline = true,
                args = {'^4911 | ' .. source .. '', message}
            })

            TriggerClientEvent('emergencymenu.addBlip', id)
        end
    else
        TriggerClientEvent('chat:addMessage', -1, {
            color = { 255, 0, 0 },
            multiline = true,
            args = {'^4911 | ' .. source ..'', message}
        })

        TriggerClientEvent('emergencymenu.addBlip', -1)
    end
end)

RegisterServerEvent('emergencymenu.appendBlip')
AddEventHandler('emergencymenu.appendBlip', function(blip, source)
    local identifier = GetPlayerIdentifiers(source)[1]

    for i, t_blip in ipairs(blips) do
        if t_blip.identifier == identifier then
            TriggerClientEvent('emergencymenu.removeBlip', -1, t_blip.blip)
            table.remove(blips, i)

            break
        end
    end

    table.insert(blips, {
        ['identifier'] = identifier,
        ['blip'] = blip
    })
end)

RegisterServerEvent('emergencymenu.removePlayerBlip')
AddEventHandler('emergencymenu.removePlayerBlip', function(blip, source)
    local identifier = GetPlayerIdentifiers(source)[1]

    for i, t_blip in ipairs(blips) do
        if t_blip.identifier == identifier then
            TriggerClientEvent('emergencymenu.removeBlip', -1, t_blip.blip)
            table.remove(blips, i)

            break
        end
    end
end)

AddEventHandler('emergencymenu.removeCallMember', function(source)
    for i, id in ipairs(callmembers) do
        if id == source then
            table.remove(callmembers, i)

            break
        end
    end
end)

RegisterServerEvent('emergencymenu.isAllowed')
AddEventHandler('emergencymenu.isAllowed', function(source)
    if IsPlayerAceAllowed(source, 'emergencymenu.open') then
        TriggerClientEvent('emergencymenu.isAllowed_return', source, true)
    else
        TriggerClientEvent('emergencymenu.isAllowed_return', source, false)
    end
end)

if Config.useDiscord and Config.webhookStartNotify then
    SendToWebhook('**911 Menu successfully started!**', nil, nil, false)
end