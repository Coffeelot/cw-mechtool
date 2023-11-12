local QBCore = exports['qb-core']:GetCoreObject()
local useDebug = Config.Debug
local obdIsOpen = false
local isMechanic = false
local usingObd = false

local function openOBDMenu()
    if Config.Menu == "ox" then
        local Options = {
        }
        if Config.UseTuning then
            Options[#Options+1] = {  -- CW tuning menu.
                title = 'Check car parts',
                description = '',
                icon = 'fas fa-screwdriver',
                event = 'cw-tuning:client:openTuningMenu',
            }
        end
        if Config.UsePerformance then
            Options[#Options+1] = {  -- CW Performnace overlay. REQUIRES LATEST VERSION MAYBE??
                title = 'Toggle tuning overlay',
                description = '',
                icon = 'fas fa-wrench',
                event = 'cw-mechtool:client:openTuning',
                args = { fromObd = true},
            }
        end
        if Config.UseRenzuStancer then
            Options[#Options+1] = { -- RENZU STANCER
                title = 'Stancer menu',
                description = '',
                icon = 'far fa-futbol',
                event = 'cw-mechtool:client:openStancer',
            }
        end
        if Config.UseVehicleSwap then
            Options[#Options+1] = { -- Vehicleswap
                title = 'List Vehicle Swaps',
                description = '',
                icon = 'fas fa-recycle',
                event = 'cw-mechtool:client:getSwaps',
            }
        end

        lib.registerContext({
            id = 'cw_mechtool',
            title = 'Mechanic Menu',
            options = Options
        })
        lib.showContext('cw_mechtool')
    elseif Config.Menu == "qb" then
        local options = {
            {
                header = "Mechanic Menu",
                isMenuHeader = true
            }, { -- CW tuning menu.
                header = "Check car parts",
                txt = "",
                icon = "fas fa-screwdriver",
                hidden = not Config.UseTuning,
                params = {
                    event = "cw-tuning:client:openTuningMenu",
                }
            }, { -- CW Performnace overlay. REQUIRES LATEST VERSION MAYBE??
                header = "Toggle tuning overlay",
                txt = "",
                icon = "fas fa-wrench",
                hidden = not Config.UsePerformance,
                params = {
                    event = "cw-mechtool:client:openTuning",
                    args = { fromObd = true}
                }
            }, { -- RENZU STANCER
                header = "Stancer menu",
                txt = "",
                icon = "far fa-futbol",
                hidden = not Config.UseRenzuStancer,
                params = {
                    event = "cw-mechtool:client:openStancer",
                }
            }, { -- Vehicleswap
                header = "List Vehicle Swaps",
                txt = "Under construction.",
                icon = "fas fa-recycle",
                hidden = not Config.UseVehicleSwap,
                params = {
                    event = "cw-mechtool:client:getSwaps",
                }
            }
        }

        exports['qb-menu']:openMenu(options)
    end
end

local function fetchVehicleData()
    local vehicle, distance = QBCore.Functions.GetClosestVehicle()
    if vehicle and distance then 
        if distance < 5 then
            if Config.UseTuning then 
                if not Entity(vehicle).state.workedOn then
                    exports['cw-tuning']:doVehicleCheck(vehicle)
                else
                    Wait(2000)
                end
            end
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

RegisterNetEvent('cw-mechtool:client:getSwaps', function()
    exports['cw-vehicleswap']:listSwaps()
end)