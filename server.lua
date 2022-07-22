RegisterServerEvent('SubmitWebhook')
AddEventHandler("SubmitWebhook", function(message, source, call)
    SendToWebhook(message .. '\n*Call from ' .. source .. ' at ' .. os.date('%c') .. '*', true)
end)

RegisterServerEvent('emergencymenu.isAllowed')
AddEventHandler('emergencymenu.isAllowed', function(source)
    if IsPlayerAceAllowed(source, 'emergencymenu.open') then
        TriggerClientEvent('emergencymenu.isAllowed_return', source, true)
    else
        TriggerClientEvent('emergencymenu.isAllowed_return', source, false)
    end
end)

RegisterServerEvent('SubmitMessage')
AddEventHandler("SubmitMessage", function(message, source)
    TriggerClientEvent('chat:addMessage', -1, {
        color = { 255, 0, 0 },
        multiline = true,
        args = {'[911 | ' .. source ..']', message}
    })
end)

if Config.useDiscord and Config.webhookStartNotify then
    SendToWebhook('**911 Menu successfully started!**', nil, nil, false)
end