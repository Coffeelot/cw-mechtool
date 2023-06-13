local QBCore = exports['qb-core']:GetCoreObject()
local useDebug = Config.Debug
local obdIsOpen = false
local isMechanic = false
local usingObd = false

local function openOBDMenu()
    exports['qb-menu']:openMenu({{
            header = "Mechanic Menu",
            isMenuHeader = true
        }, { -- CW Performnace overlay. REQUIRES LATEST VERSION MAYBE??
            header = "Toggle tuning overlay",
            txt = "",
            icon = "fas fa-wrench",
            params = {
                event = "cw-mechtool:client:openTuning",
                args = { fromObd = true}
            }
        }, { -- RENZU STANCER
            header = "Stancer menu",
            txt = "",
            icon = "far fa-futbol",
            params = {
                event = "cw-mechtool:client:openStancer",
            }
        },
    })
end

local function fetchVehicleData()
    local vehicle, distance = QBCore.Functions.GetClosestVehicle()
    if vehicle and distance then 
        if distance < 5 then
            local score, class, performanceScore, vehicleModel, vehicleBrand = exports['cw-performance']:getVehicleInfo(vehicle)
            local details = exports['cw-performance']:getVehicleDetails(vehicle)

            SendNUIMessage({
                action = "updateobd",
                score = score,
                details = details,
                class = class,
                performanceScore = performanceScore,
                vehicleModel = vehicleModel,
                vehicleBrand = vehicleBrand,
                usingObd = usingObd
            })
        else
            QBCore.Functions.Notify("Not close to a vehicle", 'error')
            obdIsOpen = false
            SendNUIMessage({
                action = "cwobd",
                toggle = false,
            })
        end
    else
        QBCore.Functions.Notify("Not close to a vehicle", 'error')
        obdIsOpen = false
        SendNUIMessage({
            action = "cwobd",
            toggle = false,
        })
    end
    if obdIsOpen then
        SetTimeout(1000, function()
            fetchVehicleData()
        end)
    end
end

local function setOBDOpen(bool, fromObd)
    obdIsOpen = bool
    if obdIsOpen then
        usingObd = fromObd
        fetchVehicleData()
    end
    SendNUIMessage({
        action = "cwobd",
        toggle = obdIsOpen,
    })
end

RegisterNetEvent('cw-mechtool:client:openTuning', function(data)
    setOBDOpen(not obdIsOpen, data.fromObd)
end)

RegisterNUICallback('exitObd', function(_, cb)
    -- setOBDOpen(false)
end)

RegisterNetEvent('cw-mechtool:client:openStancer', function()
    exports['renzu_stancer']:OpenStancer()
end)

RegisterNetEvent('cw-mechtool:client:openMechanicMenu', function()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        TriggerEvent('animations:client:EmoteCommandStart', {"keyfob"})
        if PlayerData.job.type == 'mechanic' then
            openOBDMenu()
        else
            QBCore.Functions.Notify("You're not a mechanic", 'error')
        end

    end)
end)