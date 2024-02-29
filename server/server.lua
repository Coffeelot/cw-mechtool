local QBCore = exports['qb-core']:GetCoreObject() 
local useDebug = Config.Debug

if Config.Inventory == 'ox' then
    if useDebug then print("^2 OxInventory is enabled for MechTool") end
    AddEventHandler('ox_inventory:usedItem', function(playerId, name, slotId, metadata)
        if name == Config.ObdItem then
            TriggerClientEvent('cw-mechtool:client:openMechanicMenu', playerId)
        end
        return
    end)
else
    if useDebug then print("^3 OxInventory is disabled for MechTool") end
    QBCore.Functions.CreateUseableItem(Config.ObdItem, function(source, item)
        TriggerClientEvent('cw-mechtool:client:openMechanicMenu', source)
    end)    
end    

