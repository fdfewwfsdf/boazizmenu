-- MachoCheats Advanced Hack - macOS FiveM Executor
-- هاك متقدم للتطوير التعليمي

local hackActive = false
local godMode = false
local noClip = false
local speedBoost = false
local infiniteAmmo = false
local radarEnabled = false
local noclipSpeed = 2.0

-- ============ GOD MODE ============
function enableGodMode()
    godMode = not godMode
    if godMode then
        print("^2[Hack]^7 God Mode: ON")
    else
        print("^1[Hack]^7 God Mode: OFF")
    end
end

Citizen.CreateThread(function()
    while true do
        Wait(0)
        
        if godMode then
            local ped = PlayerPedId()
            SetEntityInvincible(ped, true)
            SetPlayerInvincible(PlayerId(), true)
            ResetEntityAlpha(ped)
        end
    end
end)

-- ============ NOCLIP ============
function toggleNoClip()
    noClip = not noClip
    if noClip then
        print("^2[Hack]^7 NoClip: ON")
    else
        print("^1[Hack]^7 NoClip: OFF")
    end
end

Citizen.CreateThread(function()
    while true do
        Wait(0)
        
        if noClip then
            local ped = PlayerPedId()
            local x, y, z = table.unpack(GetEntityCoords(ped))
            local heading = GetEntityHeading(ped)
            
            -- التحكم بـ WASD
            if IsControlPressed(0, 32) then -- W
                z = z + noclipSpeed * 0.1
            end
            if IsControlPressed(0, 33) then -- S
                z = z - noclipSpeed * 0.1
            end
            if IsControlPressed(0, 34) then -- A
                x = x - noclipSpeed * 0.1
            end
            if IsControlPressed(0, 35) then -- D
                x = x + noclipSpeed * 0.1
            end
            
            -- صعود/نزول (Space / Ctrl)
            if IsControlPressed(0, 108) then -- Space
                z = z + noclipSpeed * 0.15
            end
            if IsControlPressed(0, 52) then -- Ctrl
                z = z - noclipSpeed * 0.15
            end
            
            SetEntityCoords(ped, x, y, z, false, false, false, false)
            SetEntityVisible(ped, true)
        end
    end
end)

-- ============ INFINITE AMMO ============
function toggleInfiniteAmmo()
    infiniteAmmo = not infiniteAmmo
    if infiniteAmmo then
        print("^2[Hack]^7 Infinite Ammo: ON")
    else
        print("^1[Hack]^7 Infinite Ammo: OFF")
    end
end

Citizen.CreateThread(function()
    while true do
        Wait(100)
        
        if infiniteAmmo then
            local ped = PlayerPedId()
            local currentWeapon = GetSelectedPedWeapon(ped)
            
            if currentWeapon ~= GetHashKey("WEAPON_UNARMED") then
                GiveWeaponToPed(ped, currentWeapon, 9999, false, true)
                SetAmmoInClip(ped, currentWeapon, 9999)
            end
        end
    end
end)

-- ============ SPEED BOOST ============
function toggleSpeedBoost()
    speedBoost = not speedBoost
    if speedBoost then
        print("^2[Hack]^7 Speed Boost: ON")
    else
        print("^1[Hack]^7 Speed Boost: OFF")
    end
end

Citizen.CreateThread(function()
    while true do
        Wait(0)
        
        if speedBoost then
            local ped = PlayerPedId()
            SetRunSprintMultiplierForPlayer(PlayerId(), 2.0)
            SetSwimMultiplierForPlayer(PlayerId(), 2.0)
        end
    end
end)

-- ============ RADAR ESP ============
function toggleRadar()
    radarEnabled = not radarEnabled
    if radarEnabled then
        print("^2[Hack]^7 Radar ESP: ON")
    else
        print("^1[Hack]^7 Radar ESP: OFF")
    end
end

Citizen.CreateThread(function()
    while true do
        Wait(100)
        
        if radarEnabled then
            local players = {}
            for i = 0, 255 do
                if NetworkIsPlayerActive(i) and i ~= PlayerId() then
                    table.insert(players, i)
                end
            end
            
            for _, player in ipairs(players) do
                local targetPed = GetPlayerPed(player)
                if targetPed ~= 0 then
                    local targetCoords = GetEntityCoords(targetPed)
                    AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)
                end
            end
        end
    end
end)

-- ============ AIMBOT ============
local aimbotEnabled = false

function toggleAimbot()
    aimbotEnabled = not aimbotEnabled
    if aimbotEnabled then
        print("^2[Hack]^7 Aimbot: ON")
    else
        print("^1[Hack]^7 Aimbot: OFF")
    end
end

Citizen.CreateThread(function()
    while true do
        Wait(0)
        
        if aimbotEnabled then
            local playerPed = PlayerPedId()
            local closestPed = nil
            local closestDistance = 999999.0
            
            for i = 0, 255 do
                if NetworkIsPlayerActive(i) and i ~= PlayerId() then
                    local targetPed = GetPlayerPed(i)
                    if targetPed ~= 0 then
                        local distance = #(GetEntityCoords(playerPed) - GetEntityCoords(targetPed))
                        if distance < closestDistance and distance < 500.0 then
                            closestDistance = distance
                            closestPed = targetPed
                        end
                    end
                end
            end
            
            if closestPed ~= nil then
                local targetCoords = GetPedBoneCoords(closestPed, 0x796E8440, 0, 0, 0)
                local playerCoords = GetEntityCoords(playerPed)
                
                local direction = targetCoords - playerCoords
                local yaw = math.atan2(direction.y, direction.x) * 180 / math.pi
                
                SetGameplayCamRelativeHeading(yaw)
            end
        end
    end
end)

-- ============ SILENT AIM ============
local silentAimEnabled = false

function toggleSilentAim()
    silentAimEnabled = not silentAimEnabled
    if silentAimEnabled then
        print("^2[Hack]^7 Silent Aim: ON")
    else
        print("^1[Hack]^7 Silent Aim: OFF")
    end
end

Citizen.CreateThread(function()
    while true do
        Wait(0)
        
        if silentAimEnabled then
            local playerPed = PlayerPedId()
            local closestPed = nil
            local closestDistance = 999999.0
            
            for i = 0, 255 do
                if NetworkIsPlayerActive(i) and i ~= PlayerId() then
                    local targetPed = GetPlayerPed(i)
                    if targetPed ~= 0 then
                        local distance = #(GetEntityCoords(playerPed) - GetEntityCoords(targetPed))
                        if distance < closestDistance and distance < 500.0 then
                            closestDistance = distance
                            closestPed = targetPed
                        end
                    end
                end
            end
            
            if closestPed ~= nil and IsPlayerFreeAiming(PlayerId()) then
                local targetCoords = GetPedBoneCoords(closestPed, 0x796E8440, 0, 0, 0)
                local weapon = GetSelectedPedWeapon(playerPed)
                
                if GetAmmoInClip(playerPed, weapon) > 0 then
                    ShootAtCoord(playerPed, targetCoords.x, targetCoords.y, targetCoords.z, weapon)
                end
            end
        end
    end
end)

-- ============ ONE SHOT KILL ============
local oneShotEnabled = false

function toggleOneShot()
    oneShotEnabled = not oneShotEnabled
    if oneShotEnabled then
        print("^2[Hack]^7 One Shot Kill: ON")
    else
        print("^1[Hack]^7 One Shot Kill: OFF")
    end
end

Citizen.CreateThread(function()
    while true do
        Wait(0)
        
        if oneShotEnabled then
            local playerPed = PlayerPedId()
            local weapon = GetSelectedPedWeapon(playerPed)
            
            -- زيادة الضرر
            SetWeaponDamageModifier(weapon, 100.0)
        end
    end
end)

-- ============ WALLBANG ============
local wallbangEnabled = false

function toggleWallbang()
    wallbangEnabled = not wallbangEnabled
    if wallbangEnabled then
        print("^2[Hack]^7 Wallbang: ON")
    else
        print("^1[Hack]^7 Wallbang: OFF")
    end
end

Citizen.CreateThread(function()
    while true do
        Wait(0)
        
        if wallbangEnabled then
            local playerPed = PlayerPedId()
            local weapon = GetSelectedPedWeapon(playerPed)
            
            -- تفعيل الاختراق عبر الجدران
            SetWeaponPenetration(weapon, true)
        end
    end
end)

-- ============ ESP (عرض جميع اللاعبين) ============
local espEnabled = false

function toggleESP()
    espEnabled = not espEnabled
    if espEnabled then
        print("^2[Hack]^7 ESP: ON")
    else
        print("^1[Hack]^7 ESP: OFF")
    end
end

Citizen.CreateThread(function()
    while true do
        Wait(100)
        
        if espEnabled then
            for i = 0, 255 do
                if NetworkIsPlayerActive(i) and i ~= PlayerId() then
                    local targetPed = GetPlayerPed(i)
                    if targetPed ~= 0 then
                        local playerPed = PlayerPedId()
                        local targetCoords = GetEntityCoords(targetPed)
                        local playerCoords = GetEntityCoords(playerPed)
                        
                        -- رسم خط
                        DrawLine(playerCoords.x, playerCoords.y, playerCoords.z, 
                                targetCoords.x, targetCoords.y, targetCoords.z, 
                                255, 0, 255, 255)
                        
                        -- عرض المسافة
                        local distance = #(playerCoords - targetCoords)
                        local x, y = GetScreenCoordFromWorldCoord(targetCoords.x, targetCoords.y, targetCoords.z)
                        if x ~= false and y ~= false then
                            drawText("["..math.floor(distance).."m]", x, y, 0.4, 255, 0, 255, 255)
                        end
                    end
                end
            end
        end
    end
end)

-- ============ دالة رسم النص ============
function drawText(text, x, y, scale, r, g, b, a)
    SetTextFont(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    BeginTextCommandDisplayText("STRING")
    AddTextComponentString(text)
    EndTextCommandDisplayText(x, y)
end

-- ============ أوامر سريعة بالمفاتيح ============
Citizen.CreateThread(function()
    while true do
        Wait(0)
        
        -- F1 = God Mode
        if IsControlJustReleased(0, 288) then
            enableGodMode()
        end
        
        -- F2 = NoClip
        if IsControlJustReleased(0, 289) then
            toggleNoClip()
        end
        
        -- F3 = Infinite Ammo
        if IsControlJustReleased(0, 290) then
            toggleInfiniteAmmo()
        end
        
        -- F4 = Speed Boost
        if IsControlJustReleased(0, 291) then
            toggleSpeedBoost()
        end
        
        -- F5 = Aimbot
        if IsControlJustReleased(0, 292) then
            toggleAimbot()
        end
        
        -- F6 = Silent Aim
        if IsControlJustReleased(0, 293) then
            toggleSilentAim()
        end
        
        -- F7 = ESP
        if IsControlJustReleased(0, 294) then
            toggleESP()
        end
    end
end)

print("^2[Hack]^7 تم تحميل الهاك بنجاح!")
print("^2[Hack]^7 اضغط F1-F7 للتحكم")
