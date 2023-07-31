ESX = nil 
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) 


RegisterServerEvent("sims-dispatch:sendAlert")
AddEventHandler("sims-dispatch:sendAlert", function(text, coords, id)
    local _source = source
    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == Config.PoliceJob then
            TriggerClientEvent("sims-dispatch:alertToClient", -1, text, coords, id)
        end
    end
end)
RegisterServerEvent("sims-dispatch:sendAmbuAlert")
AddEventHandler("sims-dispatch:sendAmbuAlert", function(text, coords, id)
    local _source = source
    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == Config.AmbulanceJob then
            TriggerClientEvent("sims-dispatch:auxToClient", -1, text, coords, id)
        end
    end
end)
RegisterServerEvent("sims-dispatch:sendMecaAlert")
AddEventHandler("sims-dispatch:sendMecaAlert", function(text, coords, id)
    local _source = source
    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == Config.MechanicJob then
            TriggerClientEvent("sims-dispatch:mecaToClient", -1, text, coords, id)
        end
    end
end)
RegisterServerEvent("sims-dispatch:sendVehRob")
AddEventHandler("sims-dispatch:sendVehRob", function(coords, model, finalColor, id)
    local _source = source
    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == Config.PoliceJob then
            TriggerClientEvent("sims-dispatch:vehToClient", -1, coords, model, finalColor, id)
        end
    end
end)
RegisterServerEvent("sims-dispatch:sendTaxiaAlert")
AddEventHandler("sims-dispatch:sendTaxiaAlert", function(text, coords, id)
    local _source = source
    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == Config.TaxiJob then
            TriggerClientEvent("sims-dispatch:taxiToClient", -1, text, coords, id)
        end
    end
end)
RegisterServerEvent("sims-dispatch:sendStoreRobbery")
AddEventHandler("sims-dispatch:sendStoreRobbery", function(coords, id)
    local _source = source
    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == Config.PoliceJob then
            TriggerClientEvent("sims-dispatch:storerobbery", -1, coords, id)
        end
    end
end)
RegisterServerEvent("sims-dispatch:sendBankRobbery")
AddEventHandler("sims-dispatch:sendBankRobbery", function(coords, id)
    local _source = source
    local xPlayers = ESX.GetPlayers()

    for i = 1, #xPlayers do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == Config.PoliceJob then
            TriggerClientEvent("sims-dispatch:bankrobbery", -1, coords, id)
        end
    end
end)
RegisterServerEvent("sims-dispatch:sendPanicButton")
AddEventHandler("sims-dispatch:sendPanicButton", function(coords, id)
    local _source = source
    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == Config.PoliceJob then
            TriggerClientEvent("sims-dispatch:alertPanicButton", -1, coords, id)
        end
    end
end)
