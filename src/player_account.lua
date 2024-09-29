PlayerAccount = {}
PlayerAccount.__index = PlayerAccount

--- Creates a new PlayerAccount.
-- @param identifier string: The identifier for the player account.
-- @return PlayerAccount: A new PlayerAccount instance.
function PlayerAccount.new(identifier)
    local self = setmetatable({}, PlayerAccount)
    self.identifier = identifier
    self.balances = {}

    for currency, data in pairs(Config.Currencies) do
        self.balances[currency] = data.initialAmount
    end

    return self
end

--- Creates a new PlayerAccount from saved data.
-- @param identifier string: The identifier for the player account.
-- @param savedData table: The saved data for the player account.
-- @return PlayerAccount: A new PlayerAccount instance.
function PlayerAccount.newFromData(identifier, savedData)
    local self = setmetatable({}, PlayerAccount)
    self.identifier = identifier
    self.balances = savedData.balances or {}
    return self
end

--- Gets the balance for a specific currency.
-- @param currency string: The currency to get the balance for.
-- @return number: The balance for the specified currency.
function PlayerAccount:getBalance(currency)
    return self.balances[currency] or 0
end

--- Adds money to the player's account.
-- @param currency string: The currency to add money to.
-- @param amount number: The amount of money to add.
function PlayerAccount:addMoney(currency, amount)
    if self.balances[currency] then
        self.balances[currency] = self.balances[currency] + amount
    else
        print("La monnaie spécifiée n'existe pas.")
    end
end

--- Removes money from the player's account.
-- @param currency string: The currency to remove money from.
-- @param amount number: The amount of money to remove.
function PlayerAccount:removeMoney(currency, amount)
    if self.balances[currency] then
        if self.balances[currency] >= amount then
            self.balances[currency] = self.balances[currency] - amount
        else
            print("Fonds insuffisants.")
        end
    else
        print("La monnaie spécifiée n'existe pas.")
    end
end

--- Transfers money to another player's account.
-- @param toPlayer PlayerAccount: The player account to transfer money to.
-- @param currency string: The currency to transfer.
-- @param amount number: The amount of money to transfer.
function PlayerAccount:transferMoney(toPlayer, currency, amount)
    if self.balances[currency] and self.balances[currency] >= amount then
        self:removeMoney(currency, amount)
        toPlayer:addMoney(currency, amount)
    else
        print("Transaction échouée, fonds insuffisants ou monnaie non valide.")
    end
end
