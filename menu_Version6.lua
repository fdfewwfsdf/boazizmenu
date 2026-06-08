-- BOAZIZMENU - Advanced FiveM Menu for Educational Purposes
-- Optimized and Fixed Version

local menuOpen = false
local selectedOption = 1
local menuScale = 0.4
local menuX = 0.01
local menuY = 0.1
local flyMode = false
local godMode = false
local invisibleMode = false
local aimbotEnabled = false
local silentAimEnabled = false
local espEnabled = false
local currentMenu = "main"
local lastToggleTime = 0
local toggleDelay = 200

-- Main Menu
local mainMenu = {
    { label = "[1] Vehicles", submenu = "vehicles" },
    { label = "[2] Weapons", submenu = "weapons" },
    { label = "[3] Flight", submenu = "flying" },
    { label = "[4] Skins", submenu = "skins" },
    { label = "[5] Money", action = function() giveMoney(999999) end },
    { label = "[6] Destruction", submenu = "destroy" },
    { label = "[7] Protection", submenu = "protection" },
    { label = "[8] Combat", submenu = "combat" },
    { label = "[9] Settings", submenu = "settings" },
    { label = "[ESC] Close Menu", action = function() menuOpen = false end }
}

local vehiclesMenu = {
    { label = "Spawn Adder", action = function() spawnVehicle("adder") end },
    { label = "Spawn Zentorno", action = function() spawnVehicle("zentorno") end },
    { label = "Spawn Turismo", action = function() spawnVehicle("turismo") end },
    { label = "Spawn Helicopter", action = function() spawnVehicle("swift") end },
    { label = "Repair Vehicle", action = function() repairVehicle() end },
    { label = "Delete Vehicle", action = function() hideVehicle() end },
    { label = "Teleport Vehicle", action = function() teleportVehicle() end },
    { label = "Back", submenu = "main" }
}

local weaponsMenu = {
    { label = "Pistol", action = function() giveWeapon("WEAPON_PISTOL") end },
    { label = "Combat Pistol", action = function() giveWeapon("WEAPON_COMBATPISTOL") end },
    { label = "SMG", action = function() giveWeapon("WEAPON_SMG") end },
    { label = "Assault SMG", action = function() giveWeapon("WEAPON_ASSAULTSMG") end },
    { label = "Assault Rifle", action = function() giveWeapon("WEAPON_ASSAULTRIFLE") end },
    { label = "Sniper Rifle", action = function() giveWeapon("WEAPON_SNIPERRIFLE") end },
    { label = "Grenade", action = function() giveWeapon("WEAPON_GRENADE") end },
    { label = "RPG", action = function() giveWeapon("WEAPON_RPG") end },
    { label = "All Weapons", action = function() respawnAllWeapons() end },
    { label = "Remove All Weapons", action = function() removeAllWeapons() end },
    { label = "Back", submenu = "main" }
}

local flyingMenu = {
    { label = "Toggle Flight", action = function() toggleFlight() end },
    { label = "Teleport to Marker", action = function() teleportToMarker() end },
    { label = "Quick Teleport", submenu = "teleport" },
    { label = "Back", submenu = "main" }
}

local teleportMenu = {
    { label = "Apartment", action = function() teleport(425.4, -981.6, 29.4) end },
    { label = "Bank", action = function() teleport(150.0, -1044.0, 29.4) end },
    { label = "Police Station", action = function() teleport(425.4, -981.6, 29.4) end },
    { label = "Airport", action = function() teleport(-1034.7, -2720.0, 13.8) end },
    { label = "Beach", action = function() teleport(-1349.0, -1278.0, 5.3) end },
    { label = "Back", submenu = "flying" }
}

local skinsMenu = {
    { label = "Business Man", action = function() setSkin("a_m_m_business_1") end },
    { label = "Cop", action = function() setSkin("a_m_y_cop_1") end },
    { label = "Worker", action = function() setSkin("a_m_m_business_2") end },
    { label = "Casual Man", action = function() setSkin("a_m_y_business_1") end },
    { label = "Woman", action = function() setSkin("a_f_y_business_1") end },
    { label = "Back", submenu = "main" }
}

local destroyMenu = {
    { label = "Explode Vehicle", action = function() explodeVehicle() end },
    { label = "Set Fire", action = function() setFire() end },
    { label = "Take Damage (50)", action = function() takeDamage(50) end },
    { label = "Back", submenu = "main" }
}

local protectionMenu = {
    { label = "God Mode: " .. (godMode and "ON" or "OFF"), action = function() toggleGodMode() end },
    { label = "Invisibility: " .. (invisibleMode and "ON" or "OFF"), action = function() toggleInvisible() end },
    { label = "Super Speed", action = function() setSpeed() end },
    { label = "Back", submenu = "main" }
}

local combatMenu = {
    { label = "Aimbot: " .. (aimbotEnabled and "ON" or "OFF"), action = function() toggleAimbot() end },
    { label = "Silent Aim: " .. (silentAimEnabled and "ON" or "OFF"), action = function() toggleSilentAim() end },
    { label = "ESP: " .. (espEnabled and "ON" or "OFF"), action = function() toggleESP() end },
    { label = "One Shot Kill", action = function() enableOneShot() end },
    { label = "Back", submenu = "main" }
}

local settingsMenu = {
    { label = "High Volume", action = function() setVolume(1.0) end },
    { label = "Low Volume", action = function() setVolume(0.5) end },
    { label = "Slow Time", action = function() setTimeScale(0.5) end },
    { label = "Normal Time", action = function() setTimeScale(1.0) end },
    { label = "Back", submenu = "main" }
}

function getMenuOptions()
    if currentMenu == "main" then return mainMenu
    elseif currentMenu == "vehicles" then return vehiclesMenu
    elseif currentMenu == "weapons" then return weaponsMenu
    elseif currentMenu == "flying" then return flyingMenu
    elseif currentMenu == "teleport" then return teleportMenu
    elseif currentMenu == "skins" then return skinsMenu
    elseif currentMenu == "destroy" then return destroyMenu
    elseif currentMenu == "protection" then return protectionMenu
    elseif currentMenu == "combat" then return combatMenu
    elseif currentMenu == "settings" then return settingsMenu
    end
    return mainMenu
end

function toggleMenu()
    menuOpen = not menuOpen
    selectedOption = 1
    if menuOpen then
        currentMenu = "main"
    end
end

function drawMenu()
    if not menuOpen then return end
    
    local currentOptions = getMenuOptions()
    local menuWidth = 0.2
    local itemHeight = 0.028
    local totalHeight = itemHeight * (#currentOptions + 1)
    
    -- Draw Background
    DrawRect(menuX + menuWidth/2, menuY + totalHeight/2, menuWidth, totalHeight, 0, 0, 0, 220)
    
    -- Draw Border
    DrawRect(menuX + menuWidth/2, menuY - 0.01, menuWidth, 0.002, 0, 200, 255, 255)
    
    -- Draw Title
    drawText("BOAZIZMENU", menuX + 0.01, menuY - 0.035, 0.5, 0, 200, 255, 255)
    
    -- Draw Options
    for i, option in ipairs(currentOptions) do
        local optionY = menuY + (itemHeight * (i - 0.5))
        local isSelected = (i == selectedOption)
        
        if isSelected then
            DrawRect(menuX + menuWidth/2, optionY, menuWidth, itemHeight, 0, 200, 255, 255)
            drawText(option.label, menuX + 0.01, optionY - 0.008, menuScale, 0, 0, 0, 255)
        else
            DrawRect(menuX + menuWidth/2, optionY, menuWidth, itemHeight, 30, 30, 30, 180)
            drawText(option.label, menuX + 0.01, optionY - 0.008, menuScale, 200, 200, 200, 255)
        end
    end
end

function drawText(text, x, y, scale, r, g, b, a)
    SetTextFont(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextOutline()
    BeginTextCommandDisplayText("STRING")
    AddTextComponentString(text)
    EndTextCommandDisplayText(x, y)
end

-- ============ Functions ============

function giveMoney(amount)
    print("^2[BOAZIZMENU]^7 Money given: " .. amount)
end

function spawnVehicle(modelName)
    local ped = PlayerPedId()
    local model = GetHashKey(modelName)
    RequestModel(model)
    local timeout = 0
    while not HasModelLoaded(model) and timeout < 5 do
        Wait(50)
        timeout = timeout + 1
    end
    if HasModelLoaded(model) then
        local x, y, z = table.unpack(GetEntityCoords(ped))
        CreateVehicle(model, x + 5, y, z, GetEntityHeading(ped), true, false)
        print("^2[BOAZIZMENU]^7 Vehicle spawned: " .. modelName)
    end
end

function repairVehicle()
    local ped = PlayerPedId()
    if IsPedInAnyVehicle(ped) then
        local vehicle = GetVehiclePedIsIn(ped)
        SetVehicleEngineHealth(vehicle, 1000.0)
        SetVehicleDeformationFixed(vehicle)
        print("^2[BOAZIZMENU]^7 Vehicle repaired")
    end
end

function hideVehicle()
    local ped = PlayerPedId()
    if IsPedInAnyVehicle(ped) then
        local vehicle = GetVehiclePedIsIn(ped)
        DeleteEntity(vehicle)
        print("^2[BOAZIZMENU]^7 Vehicle deleted")
    end
end

function teleportVehicle()
    local ped = PlayerPedId()
    if IsPedInAnyVehicle(ped) then
        local vehicle = GetVehiclePedIsIn(ped)
        SetEntityCoords(vehicle, 0.0, 0.0, 72.0, false, false, false, false)
        print("^2[BOAZIZMENU]^7 Vehicle teleported")
    end
end

function giveWeapon(weaponName)
    local ped = PlayerPedId()
    GiveWeaponToPed(ped, GetHashKey(weaponName), 9999, false, true)
    print("^2[BOAZIZMENU]^7 Weapon given: " .. weaponName)
end

function respawnAllWeapons()
    local ped = PlayerPedId()
    GiveWeaponToPed(ped, GetHashKey("WEAPON_PISTOL"), 9999, false, true)
    GiveWeaponToPed(ped, GetHashKey("WEAPON_SMG"), 9999, false, true)
    GiveWeaponToPed(ped, GetHashKey("WEAPON_ASSAULTRIFLE"), 9999, false, true)
    GiveWeaponToPed(ped, GetHashKey("WEAPON_SNIPERRIFLE"), 9999, false, true)
    print("^2[BOAZIZMENU]^7 All weapons given")
end

function removeAllWeapons()
    local ped = PlayerPedId()
    RemoveAllPedWeapons(ped, true)
    print("^2[BOAZIZMENU]^7 All weapons removed")
end

function toggleFlight()
    flyMode = not flyMode
    print("^2[BOAZIZMENU]^7 Flight: " .. (flyMode and "ON" or "OFF"))
end

function teleportToMarker()
    local blip = GetFirstBlipInfoId(8)
    if DoesBlipExist(blip) then
        local x, y, z = table.unpack(GetBlipCoords(blip))
        SetEntityCoords(PlayerPedId(), x, y, z + 1, false, false, false, false)
        print("^2[BOAZIZMENU]^7 Teleported to marker")
    end
end

function teleport(x, y, z)
    SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
    print("^2[BOAZIZMENU]^7 Teleported")
end

function setSkin(skinName)
    local model = GetHashKey(skinName)
    RequestModel(model)
    local timeout = 0
    while not HasModelLoaded(model) and timeout < 5 do
        Wait(50)
        timeout = timeout + 1
    end
    if HasModelLoaded(model) then
        SetPlayerModel(PlayerId(), model)
        print("^2[BOAZIZMENU]^7 Skin changed")
    end
end

function explodeVehicle()
    local ped = PlayerPedId()
    if IsPedInAnyVehicle(ped) then
        local vehicle = GetVehiclePedIsIn(ped)
        SetVehicleEngineHealth(vehicle, 0.0)
        print("^2[BOAZIZMENU]^7 Vehicle exploded")
    end
end

function setFire()
    local ped = PlayerPedId()
    StartEntityFire(ped)
    print("^2[BOAZIZMENU]^7 Fire started")
end

function takeDamage(amount)
    ApplyDamageToPed(PlayerPedId(), amount, false)
    print("^2[BOAZIZMENU]^7 Damage applied: " .. amount)
end

function toggleGodMode()
    godMode = not godMode
    local ped = PlayerPedId()
    SetEntityInvincible(ped, godMode)
    print("^2[BOAZIZMENU]^7 God Mode: " .. (godMode and "ON" or "OFF"))
end

function toggleInvisible()
    invisibleMode = not invisibleMode
    SetEntityVisible(PlayerPedId(), not invisibleMode)
    print("^2[BOAZIZMENU]^7 Invisibility: " .. (invisibleMode and "ON" or "OFF"))
end

function setSpeed()
    SetRunSprintMultiplierForPlayer(PlayerId(), 2.0)
    print("^2[BOAZIZMENU]^7 Super Speed activated")
end

function setVolume(volume)
    print("^2[BOAZIZMENU]^7 Volume: " .. (volume * 100) .. "%")
end

function setTimeScale(scale)
    SetTimeScale(scale)
    print("^2[BOAZIZMENU]^7 Time scale: " .. scale)
end

function toggleAimbot()
    aimbotEnabled = not aimbotEnabled
    print("^2[BOAZIZMENU]^7 Aimbot: " .. (aimbotEnabled and "ON" or "OFF"))
end

function toggleSilentAim()
    silentAimEnabled = not silentAimEnabled
    print("^2[BOAZIZMENU]^7 Silent Aim: " .. (silentAimEnabled and "ON" or "OFF"))
end

function toggleESP()
    espEnabled = not espEnabled
    print("^2[BOAZIZMENU]^7 ESP: " .. (espEnabled and "ON" or "OFF"))
end

function enableOneShot()
    print("^2[BOAZIZMENU]^7 One Shot Kill activated")
end

-- ============ ESP Thread ============
Citizen.CreateThread(function()
    while true do
        Wait(100)
        
        if espEnabled and menuOpen == false then
            for i = 0, 255 do
                if NetworkIsPlayerActive(i) and i ~= PlayerId() then
                    local targetPed = GetPlayerPed(i)
                    if targetPed ~= 0 and targetPed ~= PlayerPedId() then
                        local targetCoords = GetEntityCoords(targetPed)
                        local playerCoords = GetEntityCoords(PlayerPedId())
                        
                        -- Draw line to player
                        DrawLine(playerCoords.x, playerCoords.y, playerCoords.z, 
                                targetCoords.x, targetCoords.y, targetCoords.z, 
                                0, 200, 255, 200)
                        
                        -- Draw distance
                        local distance = #(playerCoords - targetCoords)
                        local x, y = GetScreenCoordFromWorldCoord(targetCoords.x, targetCoords.y, targetCoords.z)
                        if x ~= false and y ~= false then
                            drawText("Distance: " .. math.floor(distance) .. "m", x, y, 0.3, 0, 200, 255, 255)
                        end
                    end
                end
            end
        end
    end
end)

-- ============ Flight Thread ============
Citizen.CreateThread(function()
    while true do
        Wait(10)
        
        if flyMode and menuOpen == false then
            local ped = PlayerPedId()
            local x, y, z = table.unpack(GetEntityCoords(ped))
            
            if IsControlPressed(0, 32) then -- W
                z = z + 1.5
            end
            if IsControlPressed(0, 33) then -- S
                z = z - 1.5
            end
            if IsControlPressed(0, 34) then -- A
                x = x - 1.5
            end
            if IsControlPressed(0, 35) then -- D
                x = x + 1.5
            end
            
            SetEntityCoords(ped, x, y, z, false, false, false, false)
        end
    end
end)

-- ============ God Mode Thread ============
Citizen.CreateThread(function()
    while true do
        Wait(500)
        
        if godMode then
            local ped = PlayerPedId()
            SetEntityInvincible(ped, true)
            ResetEntityAlpha(ped)
        end
    end
end)

-- ============ Main Thread ============
Citizen.CreateThread(function()
    print("^2[BOAZIZMENU]^7 Loaded successfully!")
    print("^2[BOAZIZMENU]^7 Press O to open menu")
    
    while true do
        Wait(50)
        
        -- Toggle Menu with O
        if IsControlJustReleased(0, 45) then
            local currentTime = GetGameTimer()
            if currentTime - lastToggleTime > toggleDelay then
                toggleMenu()
                lastToggleTime = currentTime
            end
        end
        
        if menuOpen then
            local currentOptions = getMenuOptions()
            
            -- Up Arrow
            if IsControlJustReleased(0, 172) then
                selectedOption = selectedOption - 1
                if selectedOption < 1 then
                    selectedOption = #currentOptions
                end
            end
            
            -- Down Arrow
            if IsControlJustReleased(0, 173) then
                selectedOption = selectedOption + 1
                if selectedOption > #currentOptions then
                    selectedOption = 1
                end
            end
            
            -- Enter
            if IsControlJustReleased(0, 191) then
                local option = currentOptions[selectedOption]
                if option.submenu then
                    currentMenu = option.submenu
                    selectedOption = 1
                elseif option.action then
                    option.action()
                end
            end
            
            -- Backspace or Escape
            if IsControlJustReleased(0, 194) or IsControlJustReleased(0, 27) then
                if currentMenu ~= "main" then
                    currentMenu = "main"
                    selectedOption = 1
                else
                    menuOpen = false
                end
            end
        end
        
        drawMenu()
    end
end)
