local PlayerData = {}

ESX = nil 

Citizen.CreateThread(function() 
    while ESX == nil do 
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) 
        Citizen.Wait(0) 
    end
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
    PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)


-- Alerts
RegisterNetEvent("sims-dispatch:alertToClient")
AddEventHandler("sims-dispatch:alertToClient", function(text, coords, id)
    if PlayerData.job and PlayerData.job.name == Config.PoliceJob then
        PlaySoundFrontend(-1, "Bomb_Disarmed", "GTAO_Speed_Convoy_Soundset", 0) -- Sound/Sonido
        local street = GetStreetNameFromHashKey(GetStreetNameAtCoord(table.unpack(coords)))
        ESX.ShowAdvancedNotification('DISPATCH', Language['policedept'], "~w~"..Language['street']..": ~y~"..street.."~w~\n"..text.."", Config.PoliceAmbulanceDispatchIcon, 0)
        local blip = AddBlipForCoord(coords.x, coords.y)
		SetBlipSprite(blip, 161)
		SetBlipColour(blip,  1)
		SetBlipAlpha(blip, 250)
		SetBlipScale(blip, 0.7)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('[Dispatch] Llamada')
		EndTextCommandSetBlipName(blip)
        Wait(120 * 1000) -- 120 segundos --> 2 minutos
        RemoveBlip(blip)
    end
end)
RegisterNetEvent("sims-dispatch:vehToClient")
AddEventHandler("sims-dispatch:vehToClient", function(coords, model, finalColor, id)
    if PlayerData.job and PlayerData.job.name == Config.PoliceJob then
        PlaySoundFrontend(-1, "CONFIRM_BEEP", "HUD_MINI_GAME_SOUNDSET", 0) -- Sound/Sonido
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        local street = GetStreetNameFromHashKey(GetStreetNameAtCoord(table.unpack(coords)))
        local color = GetVehicleColor(vehicle)
        local klk = tostring(color)
        local finalColor = Config.Colors[klk]
        ESX.ShowAdvancedNotification('DISPATCH', Language['policedept'], "~w~"..Language['model']..": ~g~"..model.."\n~w~"..Language['color']..": ~f~"..finalColor.."\n~w~"..Language['street']..": ~y~"..street.."", Config.PoliceAmbulanceDispatchIcon, 0)
        local blip = AddBlipForCoord(coords.x, coords.y)
		SetBlipSprite(blip, 161)
		SetBlipColour(blip,  1)
		SetBlipAlpha(blip, 250)
		SetBlipScale(blip, 0.7)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('[Dispatch] Robo de Vehiculo Reportado')
		EndTextCommandSetBlipName(blip)
        Wait(120 * 1000) -- 120 segundos --> 2 minutos
        RemoveBlip(blip)
    end
end)
RegisterNetEvent("sims-dispatch:auxToClient")
AddEventHandler("sims-dispatch:auxToClient", function(text, coords, id)
    if PlayerData.job and PlayerData.job.name == Config.AmbulanceJob then
        PlaySoundFrontend(-1, "CONFIRM_BEEP", "HUD_MINI_GAME_SOUNDSET", 0) -- Sound/Sonido
        local street = GetStreetNameFromHashKey(GetStreetNameAtCoord(table.unpack(coords)))
        ESX.ShowAdvancedNotification('DISPATCH', Language['firedept'], "~w~"..Language['street']..": ~y~"..street.."~w~\n"..text.."", Config.PoliceAmbulanceDispatchIcon, 0)
        local blip = AddBlipForCoord(coords.x, coords.y)
        SetBlipSprite (blip, 153)
        SetBlipDisplay(blip, 4)
        SetBlipScale  (blip, 0.7)
        SetBlipColour(blip, 3)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('[Dispatch] Llamada')
		EndTextCommandSetBlipName(blip)
        Wait(120 * 1000) -- 120 segundos --> 2 minutos
        RemoveBlip(blip) 
    end 
end)
RegisterNetEvent("sims-dispatch:taxiToClient")
AddEventHandler("sims-dispatch:taxiToClient", function(text, coords, id)
    if PlayerData.job and PlayerData.job.name == Config.TaxiJob then
        local street = GetStreetNameFromHashKey(GetStreetNameAtCoord(table.unpack(coords)))
        ESX.ShowAdvancedNotification(Language['taxi'], "", "~w~"..Language['street']..": ~y~"..street.."~w~\n"..text.."", Config.TaxiDispatchIcon, 0)
        local blip = AddBlipForCoord(coords.x, coords.y)
        SetBlipSprite (blip, 280)
        SetBlipDisplay(blip, 4)
        SetBlipScale  (blip, 0.7)
        SetBlipColour(blip, 5)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName("[Central] Cliente")
        EndTextCommandSetBlipName(blip)
        Wait(120 * 1000) -- 120 segundos --> 2 minutos
        RemoveBlip(blip)
    end
end)
RegisterNetEvent("sims-dispatch:mecaToClient")
AddEventHandler("sims-dispatch:mecaToClient", function(text, coords, id)
    if PlayerData.job and PlayerData.job.name == Config.MechanicJob then
        local street = GetStreetNameFromHashKey(GetStreetNameAtCoord(table.unpack(coords)))
        ESX.ShowAdvancedNotification(Language['mechanic'], "", "~w~"..Language['street']..": ~y~"..street.."~w~\n"..text.."", Config.MechanicDispatchIcon, 0)
        local blip = AddBlipForCoord(coords.x, coords.y)
        SetBlipSprite (blip, 566)
        SetBlipDisplay(blip, 4)
        SetBlipScale  (blip, 0.7)
        SetBlipColour(blip, 21)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName("[Central] Asistencia Requerida")
        EndTextCommandSetBlipName(blip)
        Wait(120 * 1000) -- 120 segundos --> 2 minutos
        RemoveBlip(blip)
    end
end)
RegisterNetEvent("sims-dispatch:storerobbery")
AddEventHandler("sims-dispatch:storerobbery", function(coords, id)
    if PlayerData.job and PlayerData.job.name == Config.PoliceJob then
        PlaySoundFrontend(-1, "Arming_Countdown", "GTAO_Speed_Convoy_Soundset", 0) -- Sound/Sonido
        ESX.ShowAdvancedNotification('DISPATCH', Language['policedept'], "~w~"..Language['location']..": ~y~Badulaque/Licoreria~w~\n"..Language['storerobbery'].."", Config.PoliceAmbulanceDispatchIcon, 0)
        local blip = AddBlipForCoord(coords.x, coords.y)
		SetBlipSprite(blip, 161)
		SetBlipColour(blip,  1)
		SetBlipAlpha(blip, 250)
		SetBlipScale(blip, 0.7)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('[Dispatch] Robo de Tienda')
		EndTextCommandSetBlipName(blip)
        Wait(240 * 1000) -- 240 segundos --> 4 minutos
        RemoveBlip(blip)
    end
end)
RegisterNetEvent("sims-dispatch:bankrobbery")
AddEventHandler("sims-dispatch:bankrobbery", function(coords, id)
    if PlayerData.job and PlayerData.job.name == Config.PoliceJob then
        PlaySoundFrontend(-1, "Arming_Countdown", "GTAO_Speed_Convoy_Soundset", 0) -- Sound/Sonido
        ESX.ShowAdvancedNotification('DISPATCH', Language['policedept'], "~w~"..Language['location']..": ~y~Banco~w~\n"..Language['bankrobbery'].."", Config.PoliceAmbulanceDispatchIcon, 0)
        local blip = AddBlipForCoord(coords.x, coords.y)
		SetBlipSprite(blip, 161)
		SetBlipColour(blip,  1)
		SetBlipAlpha(blip, 250)
		SetBlipScale(blip, 0.7)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('[Dispatch] Robo de Banco')
		EndTextCommandSetBlipName(blip)
        Wait(240 * 1000) -- 240 segundos --> 4 minutos
        RemoveBlip(blip)
    end
end)


-- Commands
RegisterCommand("forzar", function()
    local ped = PlayerPedId()
    if IsPedInAnyVehicle(ped, false) then
        local vehicle = GetVehiclePedIsIn(ped, false)
        local model = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
        local coords = GetEntityCoords(PlayerPedId())
        local id = GetPlayerServerId(PlayerId())
        local color = GetVehicleColor(vehicle)
        local klk = tostring(color)
        local finalColor = Config.Colors[klk]
        TriggerServerEvent("sims-dispatch:sendVehRob", coords, model, finalColor, id)
    else
        ESX.ShowNotification(Language['not_in_car'])
    end
end, false)
RegisterCommand("auxilio", function(source, args)
    local text = table.concat(args, " ")
    local coords = GetEntityCoords(PlayerPedId())
    local id = GetPlayerServerId(PlayerId())
    TriggerServerEvent("sims-dispatch:sendAmbuAlert", text, coords, id)
end, false)
RegisterCommand("meca", function(source, args)
    local text = table.concat(args, " ")
    local coords = GetEntityCoords(PlayerPedId())
    local id = GetPlayerServerId(PlayerId())
    TriggerServerEvent("sims-dispatch:sendMecaAlert", text, coords, id)
end, false)
RegisterCommand("pedirtaxi", function(source, args)
    local text = table.concat(args, " ")
    local coords = GetEntityCoords(PlayerPedId())
    local id = GetPlayerServerId(PlayerId())
    TriggerServerEvent("sims-dispatch:sendTaxiaAlert", text, coords, id)
end, false)
RegisterCommand("entorno", function(source, args)
    local text = table.concat(args, " ")
    local coords = GetEntityCoords(PlayerPedId())
    local id = GetPlayerServerId(PlayerId())
    TriggerServerEvent("sims-dispatch:sendAlert", text, coords, id)
end, false)
RegisterCommand("storerobbery", function(source, args)
    local text = table.concat(args, " ")
    local coords = GetEntityCoords(PlayerPedId())
    local id = GetPlayerServerId(PlayerId())
    TriggerServerEvent("sims-dispatch:sendStoreRobbery", coords, id)
    ESX.ShowNotification("La alarma del establecimiento acaba de sonar, se ha notificado a todos los oficiales en servicio.")
end, false)
RegisterCommand("bankrobbery", function(source, args)
    local text = table.concat(args, " ")
    local coords = GetEntityCoords(PlayerPedId())
    local id = GetPlayerServerId(PlayerId())
    TriggerServerEvent("sims-dispatch:sendBankRobbery", coords, id)
    ESX.ShowNotification("La alarma del banco acaba de sonar, se ha notificado a todos los oficiales en servicio.")
end, false)