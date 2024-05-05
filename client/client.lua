local useDebug = Config.Debug
local QBCore = exports['qb-core']:GetCoreObject()
local obdIsOpen = false
local isMechanic = false
local usingObd = false

local function getPlayerJob()
    local groups = {}
    local jobTable = {}
    if GetResourceState("qb-core") == "started" then
        groups = QBCore.Functions.GetPlayerData().job
        jobTable.name = groups.name
        jobTable.type = groups.type
        jobTable.grade = groups.grade.level
    elseif GetResourceState("ox_core") == "started" then
        groups = exports.ox_core.GetPlayerData()?.groups
        for k, v in pairs(groups) do
            jobTable.name = k
            jobTable.grade = v
            jobTable.type = k -- hack for ox core not having type? maybe?
        end
    end
    return jobTable
end

local function notify(text, type)
    if Config.OxLib then
        lib.notify({
            title = text,
            type = type,
        })
    else 
        QBCore.Functions.Notify(text, type)
    end
end

local qbOptions = {
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

local oxOptions = {
    { -- CW tuning menu.
        title = "Check car parts",
        description = "",
        icon = "fas fa-screwdriver",
        hidden = not Config.UseTuning,
        event = "cw-tuning:client:openTuningMenu",
    }, { -- CW Performnace overlay. REQUIRES LATEST VERSION MAYBE??
        title = "Toggle tuning overlay",
        description = "",
        icon = "fas fa-wrench",
        hidden = not Config.UsePerformance,
        event = "cw-mechtool:client:openTuning",
        args = { fromObd = true}
    }, { -- RENZU STANCER
        title = "Stancer menu",
        description = "",
        icon = "far fa-futbol",
        hidden = not Config.UseRenzuStancer,
        event = "cw-mechtool:client:openStancer",
    }, { -- Vehicleswap
        title = "List Vehicle Swaps",
        description = "Under construction.",
        icon = "fas fa-recycle",
        hidden = not Config.UseVehicleSwap,
        event = "cw-mechtool:client:getSwaps",
    }
}

if Config.OxLib then
    lib.registerContext({
        id = 'mechtool_menu',
        title = 'Mechanic Menu',
        menu = 'mechtool_menu',
        options = oxOptions
    })
end

local function openOBDMenuQB()
    exports['qb-menu']:openMenu(qbOptions)
end

local function openOBDMenuOx()
    lib.showContext('mechtool_menu')
end

local function getVehicleFromVehList(hash)
    for _, v in pairs(QBCore.Shared.Vehicles) do
		if hash == joaat(v.hash) then
			return v.name, v.brand
		end
	end
    print('^1It seems like you have not added your vehicle ('..GetDisplayNameFromVehicleModel(hash)..') to the vehicles.lua')
    return 'model not found', 'brand not found'
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
            local score, class, performanceScore = exports['cw-performance']:getVehicleInfo(vehicle)
            local vehicleModel, vehicleBrand = getVehicleFromVehList(GetEntityModel(vehicle))
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
            notify("Not close to a vehicle", 'error')
            obdIsOpen = false
            SendNUIMessage({
                action = "cwobd",
                toggle = false,
            })
        end
    else
        notify("Not close to a vehicle", 'error')
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
    local job = getPlayerJob()
    TriggerEvent('animations:client:EmoteCommandStart', {"keyfob"})
    if job.type == 'mechanic' then
        if Config.OxLib then
            openOBDMenuOx()
        else
            openOBDMenuQB()
        end
    else
        notify("You're not a mechanic", 'error')
    end
end)

RegisterNetEvent('cw-mechtool:client:getSwaps', function()
    exports['cw-vehicleswap']:listSwaps()
end)