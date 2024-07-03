local QBCore = exports['qb-core']:GetCoreObject()

local function spawnNPCs()
    for _, npc in ipairs(Config.NPCs) do
        RequestModel(GetHashKey(npc.model))
        while not HasModelLoaded(GetHashKey(npc.model)) do
            Wait(1)
        end
        local npcEntity = CreatePed(4, GetHashKey(npc.model), npc.coords.x, npc.coords.y, npc.coords.z - 1.0, npc.heading, false, true)
        FreezeEntityPosition(npcEntity, true)
        SetEntityInvincible(npcEntity, true)
        SetBlockingOfNonTemporaryEvents(npcEntity, true)
        SetPedCanRagdoll(npcEntity, false)

        if Config.TargetSystem == "qb-target" then
            exports['qb-target']:AddTargetEntity(npcEntity, {
                options = {
                    {
                        type = "client",
                        event = "hospital:client:Revive",
                        icon = "fas fa-heartbeat",
                        label = "Tedavi Ol"
                    },
                },
                distance = 2.5,
            })
        elseif Config.TargetSystem == "ox-target" then
            exports.ox_target:addLocalEntity(npcEntity, {
                {
                    name = 'revive_npc',
                    icon = 'fas fa-heartbeat',
                    label = 'Tedavi Ol',
                    onSelect = function()
                        TriggerEvent('hospital:client:Revive')
                    end,
                }
            })
        end
    end
end

local function RevivePlayer(playerPed)
    SetEntityHealth(playerPed, GetEntityMaxHealth(playerPed))
    ClearPedTasksImmediately(playerPed)
    SetEntityCoords(playerPed, GetEntityCoords(playerPed))
end

RegisterNetEvent('hospital:client:revivePlayer', function()
    TriggerServerEvent('hospital:server:attemptRevive')
end)

RegisterNetEvent('hospital:client:revivePlayerConfirmed', function()
    local playerPed = PlayerPedId()
    RevivePlayer(playerPed)
end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        spawnNPCs()
    end
end)


AddEventHandler('onClientMapStart', function()
    spawnNPCs()
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000) -- 5 saniyede bir kontrol
        for _, npc in ipairs(Config.NPCs) do
            local npcEntity = GetClosestPed(npc.coords.x, npc.coords.y, npc.coords.z, 1.0, 0, 0, 0, 0, -1)
            if npcEntity ~= 0 then
                FreezeEntityPosition(npcEntity, true)
                SetEntityInvincible(npcEntity, true)
                SetBlockingOfNonTemporaryEvents(npcEntity, true)
                SetPedCanRagdoll(npcEntity, false)
            end
        end
    end
end)
