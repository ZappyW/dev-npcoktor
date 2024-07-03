local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('hospital:server:attemptRevive', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local bankBalance = Player.Functions.GetMoney('bank')

    if bankBalance >= Config.ReviveCost then
        Player.Functions.RemoveMoney('bank', Config.ReviveCost)
        TriggerClientEvent('hospital:client:Revive', src)
    else
        TriggerClientEvent('QBCore:Notify', src, "Yeterli paranız yok", "error")
    end
end)
