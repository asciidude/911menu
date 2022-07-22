function SendToWebhook(message, call) -- Server only
    if message == nil or message == '' then
        return 'Unable to send empty message'
    end

    if category == nil then
        if call then
            PerformHttpRequest(
                Config.webhookURL,
                function(err, text, header) end,
                'POST',
                json.encode({
                    username = Config.webhookName,
                    content = '**911 Call Recieved:** ' .. message,
                    icon = Config.webhookImage
                }),
                {['Content-Type'] = 'application/json'}
            )
        else
            PerformHttpRequest(
                Config.webhookURL,
                function(err, text, header) end,
                'POST',
                json.encode({
                    username = Config.webhookName,
                    content = '**911 Menu**\n' .. message,
                    icon = Config.webhookImage
                }),
                {['Content-Type'] = 'application/json'}
            )
        end
    else
        PerformHttpRequest(
            Config.webhookURL,
            function(err, text, header) end,
            'POST',
            json.encode({
                username = Config.webhookName,
                content = '**911 Call Recieved:**\n' .. message,
                icon = Config.webhookImage
            }),
            {['Content-Type'] = 'application/json'}
        )
    end
end

function Notify(message)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end