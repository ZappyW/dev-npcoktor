local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('hospital:server:RevivePlayer', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local bankBalance = Player.PlayerData.money['bank']

    if bankBalance >= Config.ReviveCost then
        Player.Functions.RemoveMoney('bank', Config.ReviveCost, 'revive-player')
        TriggerClientEvent('hospital:client:revivePlayerConfirmed', src)
    else
        TriggerClientEvent('QBCore:Notify', src, 'Yeterli paranız yok!', 'error')
    end
end)
