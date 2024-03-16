Config = {}

Config.ESXanimations = false 

Config.Locale = GetConvar('esx:locale', 'de')

Config.Command = "autopilot"

Config.AutopilotSpeed = 20.0 -- mph x 2.236936 / kmh x 3,6
Config.MinSpeed = 1.0

Config.DecelerationRate = 1.0

Config.BlockedVehicles = {
     8, -- https://docs.fivem.net/natives/?_0x29439776AAA00A62
    13,
    14,
    15,
    16,
}