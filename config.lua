Config = {}

-- Define the available currencies and their properties
Config.Currencies = {
    ["dollar"] = {
        name = "Dollar",       -- The name of the currency
        symbol = "$",          -- The symbol of the currency
        initialAmount = 1000   -- The initial amount of this currency
    },
    ["euro"] = {
        name = "Euro",         -- The name of the currency
        symbol = "€",          -- The symbol of the currency
        initialAmount = 500    -- The initial amount of this currency
    }
}

-- Set the default currency to be used
Config.DefaultCurrency = "dollar"
