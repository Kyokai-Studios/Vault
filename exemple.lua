local playerManager = PlayerManager

RegisterCommand("balance", function(source, args, rawCommand)
    local identifier = GetPlayerIdentifiers(source)[1]
    local currency = args[1] or Config.DefaultCurrency

    local account = playerManager:getPlayerAccount(identifier)
    local balance = account:getBalance(currency)

    TriggerClientEvent('chat:addMessage', source, { args = { "[Banque]", "Solde en " .. currency .. ": " .. balance .. " " .. Config.Currencies[currency].symbol } })
end)

RegisterCommand("transfer", function(source, args, rawCommand)
    local fromIdentifier = GetPlayerIdentifiers(source)[1]
    local toPlayerId = tonumber(args[1])
    local amount = tonumber(args[2])
    local currency = args[3] or Config.DefaultCurrency

    local toIdentifier = GetPlayerIdentifiers(toPlayerId)[1]

    if toIdentifier then
        playerManager:transferMoney(fromIdentifier, toIdentifier, currency, amount)
        TriggerClientEvent('chat:addMessage', source, { args = { "[Banque]", "Vous avez donné " .. amount .. " " .. Config.Currencies[currency].symbol .. " à " .. GetPlayerName(toPlayerId) } })
        TriggerClientEvent('chat:addMessage', toPlayerId, { args = { "[Banque]", "Vous avez reçu " .. amount .. " " .. Config.Currencies[currency].symbol .. " de " .. GetPlayerName(source) } })
    else
        TriggerClientEvent('chat:addMessage', source, { args = { "[Banque]", "Joueur introuvable." } })
    end
end)
