local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('hospital:server:attemptRevive', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if not Player then
        print("Revive attempt failed: Player not found (" .. tostring(src) .. ")")
        return
    end

    local bankBalance = Player.Functions.GetMoney('bank')

    if bankBalance >= Config.ReviveCost then
        Player.Functions.RemoveMoney('bank', Config.ReviveCost, "hospital-revive")
        TriggerClientEvent('hospital:client:Revive', src)
    else
        TriggerClientEvent('QBCore:Notify', src, "Yeterli paranız yok", "error")
        -- Alternatif (QBCore:Notify çalışmıyorsa):
        -- TriggerClientEvent('qb-core:client:Notify', src, "Yeterli paranız yok", "error")
    end
end)

