PlayerManager = {}
PlayerManager.__index = PlayerManager

PlayerManager.players = {}

local SAVE_FILE = "player_data.json"
local RESOURCE_NAME = GetCurrentResourceName()

--- Load player data from the save file.
-- @return table The player data.
function PlayerManager:loadPlayerData()
    local content = LoadResourceFile(RESOURCE_NAME, SAVE_FILE)
    if content then
        return json.decode(content) or {}
    end
    return {}
end

--- Save player data to the save file.
function PlayerManager:savePlayerData()
    local content = json.encode(self.players)
    SaveResourceFile(RESOURCE_NAME, SAVE_FILE, content, -1)
end

--- Get the player account for the given identifier.
-- @param identifier string The player's identifier.
-- @return PlayerAccount The player account.
function PlayerManager:getPlayerAccount(identifier)
    if not self.players[identifier] then
        local playerData = self:loadPlayerData()
        
        if playerData[identifier] then
            self.players[identifier] = PlayerAccount.newFromData(identifier, playerData[identifier])
        else
            self.players[identifier] = PlayerAccount.new(identifier)
        end
    end
    return self.players[identifier]
end

AddEventHandler('playerDropped', function()
    local identifier = GetPlayerIdentifiers(source)[1]
    PlayerManager:savePlayerData()
end)

--- Add money to the player's account.
-- @param identifier string The player's identifier.
-- @param currency string The type of currency.
-- @param amount number The amount of money to add.
function PlayerManager:addMoney(identifier, currency, amount)
    local account = self:getPlayerAccount(identifier)
    account:addMoney(currency, amount)
    self:savePlayerData()
end

--- Remove money from the player's account.
-- @param identifier string The player's identifier.
-- @param currency string The type of currency.
-- @param amount number The amount of money to remove.
function PlayerManager:removeMoney(identifier, currency, amount)
    local account = self:getPlayerAccount(identifier)
    account:removeMoney(currency, amount)
    self:savePlayerData()
end

--- Transfer money from one player to another.
-- @param fromIdentifier string The identifier of the player sending money.
-- @param toIdentifier string The identifier of the player receiving money.
-- @param currency string The type of currency.
-- @param amount number The amount of money to transfer.
function PlayerManager:transferMoney(fromIdentifier, toIdentifier, currency, amount)
    local fromAccount = self:getPlayerAccount(fromIdentifier)
    local toAccount = self:getPlayerAccount(toIdentifier)

    fromAccount:transferMoney(toAccount, currency, amount)
    self:savePlayerData()
end
