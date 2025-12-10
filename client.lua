local QBCore = exports['qb-core']:GetCoreObject()

-------------------------------------------------------
-- PROGRESS SYSTEM WRAPPER (Config'e göre çalışır)
-------------------------------------------------------
local function StartProgress(label, time, onFinish, onCancel)
    if Config.ProgressSystem == "qb-core" then
        QBCore.Functions.Progressbar("revive_player", label, time, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function()
            if onFinish then onFinish() end
        end, function()
            if onCancel then onCancel() end
        end)

    elseif Config.ProgressSystem == "ox-lib" then
        local success = lib.progressCircle({
            duration = time,
            position = 'bottom',
            label = label,
            useWhileDead = false,
            canCancel = true,
            disable = {
                move = true,
                car = true,
                combat = true,
            },
        })

        if success then
            if onFinish then onFinish() end
        else
            if onCancel then onCancel() end
        end
    end
end

-------------------------------------------------------
-- NPC SPAWN FONKSİYONU
-------------------------------------------------------
local function spawnNPCs()
    for _, npc in ipairs(Config.NPCs) do
        RequestModel(GetHashKey(npc.model))
        while not HasModelLoaded(GetHashKey(npc.model)) do
            Wait(10)
        end

        local npcEntity = CreatePed(
            4,
            GetHashKey(npc.model),
            npc.coords.x, npc.coords.y, npc.coords.z - 1.0,
            npc.heading,
            false, true
        )

        FreezeEntityPosition(npcEntity, true)
        SetEntityInvincible(npcEntity, true)
        SetBlockingOfNonTemporaryEvents(npcEntity, true)
        SetPedCanRagdoll(npcEntity, false)

        -------------------------------------------------------
        -- TARGET SİSTEM SEÇİMİ
        -------------------------------------------------------
        if Config.TargetSystem == "qb-target" then
            exports['qb-target']:AddTargetEntity(npcEntity, {
                options = {
                    {
                        type = "client",
                        icon = "fas fa-heartbeat",
                        label = "Tedavi Ol",
                        event = "hospital:client:startRevive",
                    }
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
                        TriggerEvent('hospital:client:startRevive')
                    end,
                }
            })
        end
    end
end

-------------------------------------------------------
-- REVIVE FONKSİYONU
-------------------------------------------------------
local function RevivePlayer(playerPed)
    SetEntityHealth(playerPed, GetEntityMaxHealth(playerPed))
    ClearPedTasksImmediately(playerPed)
    SetEntityCoords(playerPed, GetEntityCoords(playerPed))
end

-------------------------------------------------------
-- REVIVE EVENTLERİ
-------------------------------------------------------
RegisterNetEvent('hospital:client:startRevive', function()
    StartProgress(
        "Tedavi Oluyor...",
        10000,
        function()  -- On Finish
            TriggerServerEvent('hospital:server:attemptRevive')
        end,
        function()  -- On Cancel
            QBCore.Functions.Notify("Tedavi İptal Edildi", "error")
        end
    )
end)

RegisterNetEvent('hospital:client:Revive', function()
    RevivePlayer(PlayerPedId())
end)

-------------------------------------------------------
-- RESOURCE BAŞLARKEN NPC OLUŞTURMA
-------------------------------------------------------
AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        spawnNPCs()
    end
end)

AddEventHandler('onClientMapStart', function()
    spawnNPCs()
end)

-------------------------------------------------------
-- NPC INVINCIBLE KORUMA (5 saniyede bir)
-------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)
        for _, npc in ipairs(Config.NPCs) do
            local npcEntity = GetClosestPed(npc.coords.x, npc.coords.y, npc.coords.z, 1.5, false, false, false, false, -1)
            if npcEntity ~= 0 then
                FreezeEntityPosition(npcEntity, true)
                SetEntityInvincible(npcEntity, true)
                SetBlockingOfNonTemporaryEvents(npcEntity, true)
                SetPedCanRagdoll(npcEntity, false)
            end
        end
    end
end)
