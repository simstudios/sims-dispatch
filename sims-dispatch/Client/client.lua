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
       
        Citizen.CreateThread(function()
            while true do
                local sleep = 1000
                local ped = PlayerPedId()
                local pedCoords = GetEntityCoords(ped)
                sleep = 0
                ESX.ShowHelpNotification("Presiona ~INPUT_CONTEXT~ para aceptar la llamada\nPresiona ~INPUT_DETONATE~ para rechazar la llamada")
                if IsControlJustReleased(2, 38) then
                    SetNewWaypoint(coords.x, coords.y)
                    break  
                elseif IsControlJustReleased(2, 47) then
                    break
                end
                Citizen.Wait(sleep)
            end
        end) 
    end
end)
RegisterNetEvent("sims-dispatch:alertPanicButton")
AddEventHandler("sims-dispatch:alertPanicButton", function(coords, id)
    if PlayerData.job and PlayerData.job.name == Config.PoliceJob then
        PlaySoundFrontend(-1, "Altitude_Warning", "EXILE_1", 0) -- Sound/Sonido
        local street = GetStreetNameFromHashKey(GetStreetNameAtCoord(table.unpack(coords)))
        ESX.ShowAdvancedNotification('DISPATCH', Language['policedept'], "~w~"..Language['street']..": ~y~"..street.."~w~\n~r~Para todas las unidades se ha activado el boton de Panico", Config.PoliceAmbulanceDispatchIcon, 0)
       
        Citizen.CreateThread(function()
            while true do
                local sleep = 1000
                local ped = PlayerPedId()
                local pedCoords = GetEntityCoords(ped)
                sleep = 0
                ESX.ShowHelpNotification("Presiona ~INPUT_CONTEXT~ para aceptar la llamada\nPresiona ~INPUT_DETONATE~ para rechazar la llamada")
                if IsControlJustReleased(2, 38) then
                    SetNewWaypoint(coords.x, coords.y)
                    StopSound()
                    break  
                elseif IsControlJustReleased(2, 47) then
                    StopSound()
                    break
                end
                Citizen.Wait(sleep)
            end
        end) 
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
        Citizen.CreateThread(function()
            while true do
                local sleep = 1000
                local ped = PlayerPedId()
                local pedCoords = GetEntityCoords(ped)
                sleep = 0
                ESX.ShowHelpNotification("Presiona ~INPUT_CONTEXT~ para aceptar la llamada\nPresiona ~INPUT_DETONATE~ para rechazar la llamada")
                if IsControlJustReleased(2, 38) then
                    SetNewWaypoint(coords.x, coords.y)
                    break   
                elseif IsControlJustReleased(2, 47) then
                    break
                end
                Citizen.Wait(sleep)
            end
        end) 
    end
end)
RegisterNetEvent("sims-dispatch:auxToClient")
AddEventHandler("sims-dispatch:auxToClient", function(text, coords, id)
    if PlayerData.job and PlayerData.job.name == Config.AmbulanceJob then
        PlaySoundFrontend(-1, "CONFIRM_BEEP", "HUD_MINI_GAME_SOUNDSET", 0) -- Sound/Sonido
        local street = GetStreetNameFromHashKey(GetStreetNameAtCoord(table.unpack(coords)))
        ESX.ShowAdvancedNotification('DISPATCH', Language['firedept'], "~w~"..Language['street']..": ~y~"..street.."~w~\n"..text.."", Config.PoliceAmbulanceDispatchIcon, 0)
        Citizen.CreateThread(function()
            while true do
                local sleep = 1000
                local ped = PlayerPedId()
                local pedCoords = GetEntityCoords(ped)
                sleep = 0
                ESX.ShowHelpNotification("Presiona ~INPUT_CONTEXT~ para aceptar la llamada\nPresiona ~INPUT_DETONATE~ para rechazar la llamada")
                if IsControlJustReleased(2, 38) then
                    SetNewWaypoint(coords.x, coords.y)
                    break   
                elseif IsControlJustReleased(2, 47) then
                    break
                end
                Citizen.Wait(sleep)
            end
        end) 
    end 
end)
RegisterNetEvent("sims-dispatch:taxiToClient")
AddEventHandler("sims-dispatch:taxiToClient", function(text, coords, id)
    if PlayerData.job and PlayerData.job.name == Config.TaxiJob then
        local street = GetStreetNameFromHashKey(GetStreetNameAtCoord(table.unpack(coords)))
        ESX.ShowAdvancedNotification(Language['taxi'], "", "~w~"..Language['street']..": ~y~"..street.."~w~\n"..text.."", Config.TaxiDispatchIcon, 0)
        Citizen.CreateThread(function()
            while true do
                local sleep = 1000
                local ped = PlayerPedId()
                local pedCoords = GetEntityCoords(ped)
                sleep = 0
                ESX.ShowHelpNotification("Presiona ~INPUT_CONTEXT~ para aceptar la llamada\nPresiona ~INPUT_DETONATE~ para rechazar la llamada")
                if IsControlJustReleased(2, 38) then
                    SetNewWaypoint(coords.x, coords.y)
                    break   
                elseif IsControlJustReleased(2, 47) then
                    break
                end
                Citizen.Wait(sleep)
            end
        end) 
    end
end)
RegisterNetEvent("sims-dispatch:mecaToClient")
AddEventHandler("sims-dispatch:mecaToClient", function(text, coords, id)
    if PlayerData.job and PlayerData.job.name == Config.MechanicJob then
        local street = GetStreetNameFromHashKey(GetStreetNameAtCoord(table.unpack(coords)))
        ESX.ShowAdvancedNotification(Language['mechanic'], "", "~w~"..Language['street']..": ~y~"..street.."~w~\n"..text.."", Config.MechanicDispatchIcon, 0)
        Citizen.CreateThread(function()
            while true do
                local sleep = 1000
                local ped = PlayerPedId()
                local pedCoords = GetEntityCoords(ped)
                sleep = 0
                ESX.ShowHelpNotification("Presiona ~INPUT_CONTEXT~ para aceptar la llamada\nPresiona ~INPUT_DETONATE~ para rechazar la llamada")
                if IsControlJustReleased(2, 38) then
                    SetNewWaypoint(coords.x, coords.y)
                    break   
                elseif IsControlJustReleased(2, 47) then
                    break
                end
                Citizen.Wait(sleep)
            end
        end) 
    end
end)
RegisterNetEvent("sims-dispatch:storerobbery")
AddEventHandler("sims-dispatch:storerobbery", function(coords, id)
    if PlayerData.job and PlayerData.job.name == Config.PoliceJob then
        PlaySoundFrontend(-1, "Arming_Countdown", "GTAO_Speed_Convoy_Soundset", 0) -- Sound/Sonido
        ESX.ShowAdvancedNotification('DISPATCH', Language['policedept'], "~w~"..Language['location']..": ~y~Badulaque/Licoreria~w~\n"..Language['storerobbery'].."", Config.PoliceAmbulanceDispatchIcon, 0)
        Citizen.CreateThread(function()
            while true do
                local sleep = 1000
                local ped = PlayerPedId()
                local pedCoords = GetEntityCoords(ped)
                sleep = 0
                ESX.ShowHelpNotification("Presiona ~INPUT_CONTEXT~ para aceptar la llamada\nPresiona ~INPUT_DETONATE~ para rechazar la llamada")
                if IsControlJustReleased(2, 38) then
                    SetNewWaypoint(coords.x, coords.y)
                    break   
                elseif IsControlJustReleased(2, 47) then
                    break
                end
                Citizen.Wait(sleep)
            end
        end) 
    end
end)
RegisterNetEvent("sims-dispatch:bankrobbery")
AddEventHandler("sims-dispatch:bankrobbery", function(coords, id)
    if PlayerData.job and PlayerData.job.name == Config.PoliceJob then
        PlaySoundFrontend(-1, "Arming_Countdown", "GTAO_Speed_Convoy_Soundset", 0) -- Sound/Sonido
        ESX.ShowAdvancedNotification('DISPATCH', Language['policedept'], "~w~"..Language['location']..": ~y~Banco~w~\n"..Language['bankrobbery'].."", Config.PoliceAmbulanceDispatchIcon, 0)
        Citizen.CreateThread(function()
            while true do
                local sleep = 1000
                local ped = PlayerPedId()
                local pedCoords = GetEntityCoords(ped)
                sleep = 0
                ESX.ShowHelpNotification("Presiona ~INPUT_CONTEXT~ para aceptar la llamada\nPresiona ~INPUT_DETONATE~ para rechazar la llamada")
                if IsControlJustReleased(2, 38) then
                    SetNewWaypoint(coords.x, coords.y)
                    break   
                elseif IsControlJustReleased(2, 47) then
                    break
                end
                Citizen.Wait(sleep)
            end
        end) 
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
    local coords = GetEntityCoords(PlayerPedId())
    local id = GetPlayerServerId(PlayerId())
    TriggerServerEvent("sims-dispatch:sendStoreRobbery", coords, id)
    ESX.ShowNotification("La alarma del establecimiento acaba de sonar, se ha notificado a todos los oficiales en servicio.")
end, false)
RegisterCommand("bankrobbery", function(source, args)
    local coords = GetEntityCoords(PlayerPedId())
    local id = GetPlayerServerId(PlayerId())
    TriggerServerEvent("sims-dispatch:sendBankRobbery", coords, id)
    ESX.ShowNotification("La alarma del banco acaba de sonar, se ha notificado a todos los oficiales en servicio.")
end, false)
RegisterCommand("panicbutton", function(source, args)
    local coords = GetEntityCoords(PlayerPedId())
    local id = GetPlayerServerId(PlayerId())
    TriggerServerEvent("sims-dispatch:sendPanicButton", coords, id)
    ESX.ShowNotification("Se ha enviado una alerta a todos los oficiales en servicio.")
end, false)
RegisterKeyMapping('panicbutton', "Boton de Panico", 'keyboard', "")
