Config = {}
Config.Debug = false
Config.Inventory = "qb" -- ox or qb. nothing else will work.
Config.OxLib = false -- use oxlib instead of qb menu. '@ox_lib/init.lua' needs to be in shared_scripts in fxmanifest for this to work

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