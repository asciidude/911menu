RegisterServerEvent('SubmitWebhook')
AddEventHandler("SubmitWebhook", function(message, category, source)
    SendToWebhook(message .. '\n*Call from ID ' .. source .. '*', category, true)
end)

RegisterServerEvent('SubmitMessage')
AddEventHandler("SubmitMessage", function(message, category, source)
    if category == nil then
        TriggerClientEvent('chat:addMessage', -1, {
            color = { 255, 0, 0 },
            multiline = true,
            args = {'[911 | ' .. source .. ']', message}
        })
    else
        TriggerClientEvent('chat:addMessage', -1, {
            color = { 255, 0, 0 },
            multiline = true,
            args = {'[911 | ' .. category .. ' | ' .. source ..']', message}
        })
    end
end)

if Config.useDiscord and Config.webhookStartNotify then
    SendToWebhook('**911 Menu successfully started!**', nil, false)
end