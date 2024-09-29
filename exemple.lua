local playerManager = PlayerManager

RegisterCommand("solde", function(source, args, rawCommand)
    local identifier = GetPlayerIdentifiers(source)[1]
    local currency = args[1] or Config.DefaultCurrency

    local account = playerManager:getPlayerAccount(identifier)
    local balance = account:getBalance(currency)

    TriggerClientEvent('chat:addMessage', source, { args = { "[Banque]", "Solde en " .. currency .. ": " .. balance .. " " .. Config.Currencies[currency].symbol } })
end)

RegisterCommand("donner", function(source, args, rawCommand)
    local fromIdentifier = GetPlayerIdentifiers(source)[1]
    local toPlayerId = tonumber(args[1])s
    local amount = tonumber(args[2])
    local currency = args[3] or Config.DefaultCurrency

    local toIdentifier = GetPlayerIdentifiers(toPlayerId)[1]

    if toIdentifier then
        playerManager:transferMoney(fromIdentifier, toIdentifier, currency, amount)
        if Config.Chat then
            TriggerClientEvent('chat:addMessage', source, { args = { "[Banque]", "Vous avez donné " .. amount .. " " .. Config.Currencies[currency].symbol .. " à " .. GetPlayerName(toPlayerId) } })
            TriggerClientEvent('chat:addMessage', toPlayerId, { args = { "[Banque]", "Vous avez reçu " .. amount .. " " .. Config.Currencies[currency].symbol .. " de " .. GetPlayerName(source) } })
        end
    else
        if Config.Chat then
            TriggerClientEvent('chat:addMessage', source, { args = { "[Banque]", "Joueur introuvable." } })
        end
    end
end)
