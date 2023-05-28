local QBCore = exports['qb-core']:GetCoreObject() 
local useDebug = Config.Debug

QBCore.Functions.CreateUseableItem(Config.ObdItem, function(source, item)
    TriggerClientEvent('cw-mechtool:client:openMechanicMenu', source)
end)

