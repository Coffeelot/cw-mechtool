Config = {}
Config.Debug = false
Config.Inventory = "ox" -- ox or qb. nothing else will work.
Config.Menu = "ox" -- "ox" for ox_lib or "qb" for qb-menu. COMMENT OUT '@ox_lib/init.lua', IN fxmanifest.lua IF NOT USING ox_lib

Config.UseTuning = true -- if you use cw-tuning
Config.UsePerformance = true -- if you use cw-performance
Config.UseVehicleSwap = false -- if you use cw-vehicleswap
Config.UseRenzuStancer = false -- if you use Renzus Stancer
Config.ObdItem = "obd_scanner"
Config.OnlyForJobs = true
Config.Jobs = {
    -- job = grade
    mechanic = 0,
    tuner = 0
}