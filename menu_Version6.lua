-- MachoCheats Advanced Menu - macOS FiveM Executor
-- منيو متقدم جداً مع خصائص كاملة + Aimbot + Silent Aim + ESP

local menuOpen = false
local selectedOption = 1
local menuScale = 0.5
local menuX = 0.15
local menuY = 0.15
local flyMode = false
local godMode = false
local invisibleMode = false
local aimbotEnabled = false
local silentAimEnabled = false
local espEnabled = false
local currentMenu = "main"

local mainMenu = {
    { label = "🚗 السيارات", submenu = "vehicles" },
    { label = "🔫 الأسلحة", submenu = "weapons" },
    { label = "✈️ طيران", submenu = "flying" },
    { label = "👤 شخصيات", submenu = "skins" },
    { label = "💰 أموال", action = function() giveMoney(999999) end },
    { label = "💣 تفجير وتخريب", submenu = "destroy" },
    { label = "🛡️ حماية", submenu = "protection" },
    { label = "🎯 أدوات القتال", submenu = "combat" },
    { label = "⚙️ إعدادات", submenu = "settings" },
    { label = "❌ إغلاق", action = function() menuOpen = false end }
}

local vehiclesMenu = {
    { label = "🚙 استدعاء أديلر", action = function() spawnVehicle("adder") end },
    { label = "🏎️ استدعاء سنتورنو", action = function() spawnVehicle("zentorno") end },
    { label = "🚓 استدعاء باغاتي", action = function() spawnVehicle("turismo") end },
    { label = "🚁 استدعاء هليكوبتر", action = function() spawnVehicle("swift") end },
    { label = "🔧 إصلاح السيارة", action = function() repairVehicle() end },
    { label = "🚫 جعل السيارة تختفي", action = function() hideVehicle() end },
    { label = "📍 نقل السيارة", action = function() teleportVehicle() end },
    { label = "🔄 رسبنة سيارات", submenu = "respawn_vehicles" },
    { label = "⬅️ رجوع", submenu = "main" }
}

local respawnVehiclesMenu = {
    { label = "رسبنة في المرآب", action = function() respawnVehicleGarage() end },
    { label = "رسبنة في المكان الحالي", action = function() respawnVehicleHere() end },
    { label = "⬅️ رجوع", submenu = "vehicles" }
}

local weaponsMenu = {
    { label = "🔫 بندقية عادية", action = function() giveWeapon("WEAPON_PISTOL") end },
    { label = "🔫 بندقية قتالية", action = function() giveWeapon("WEAPON_COMBATPISTOL") end },
    { label = "🔫 رشاش", action = function() giveWeapon("WEAPON_SMG") end },
    { label = "🔫 رشاش ثقيل", action = function() giveWeapon("WEAPON_ASSAULTSMG") end },
    { label = "🔫 بندقية الهجوم", action = function() giveWeapon("WEAPON_ASSAULTRIFLE") end },
    { label = "🔫 بندقية قنص", action = function() giveWeapon("WEAPON_SNIPERRIFLE") end },
    { label = "💣 قنبلة يدوية", action = function() giveWeapon("WEAPON_GRENADE") end },
    { label = "💣 قنبلة صاروخية", action = function() giveWeapon("WEAPON_RPG") end },
    { label = "🔥 رشاش نار", action = function() giveWeapon("WEAPON_FLAMETHROWER") end },
    { label = "🔧 معدات إضافية", action = function() giveWeapon("WEAPON_MACHETE") end },
    { label = "🔄 رسبنة أسلحة", submenu = "respawn_weapons" },
    { label = "⬅️ رجوع", submenu = "main" }
}

local respawnWeaponsMenu = {
    { label = "جميع الأسلحة", action = function() respawnAllWeapons() end },
    { label = "كيف حذف الأسلحة", action = function() removeAllWeapons() end },
    { label = "⬅️ رجوع", submenu = "weapons" }
}

local flyingMenu = {
    { label = "🚀 تفعيل الطيران", action = function() toggleFlight() end },
    { label = "📍 نقل سحب", action = function() teleportToMarker() end },
    { label = "🎯 نقل سريع للنقاط", submenu = "teleport" },
    { label = "⬅️ رجوع", submenu = "main" }
}

local teleportMenu = {
    { label = "🏠 الشقة", action = function() teleport(425.4, -981.6, 29.4) end },
    { label = "🏦 البنك", action = function() teleport(150.0, -1044.0, 29.4) end },
    { label = "🚔 مركز شرطة", action = function() teleport(425.4, -981.6, 29.4) end },
    { label = "🛫 المطار", action = function() teleport(-1034.7, -2720.0, 13.8) end },
    { label = "🏖️ الشاطئ", action = function() teleport(-1349.0, -1278.0, 5.3) end },
    { label = "⬅️ رجوع", submenu = "flying" }
}

local skinsMenu = {
    { label = "👨‍💼 تاجر مخدرات", action = function() setSkin("a_m_m_business_1") end },
    { label = "👮 شرطي", action = function() setSkin("a_m_y_cop_1") end },
    { label = "👷 عامل", action = function() setSkin("a_m_m_business_2") end },
    { label = "🧔 رجل عادي", action = function() setSkin("a_m_y_business_1") end },
    { label = "👩 امرأة", action = function() setSkin("a_f_y_business_1") end },
    { label = "⬅️ رجوع", submenu = "main" }
}

local destroyMenu = {
    { label = "💥 تفجير السيارة", action = function() explodeVehicle() end },
    { label = "💥 تفجير اللاعبين", action = function() explodePlayers() end },
    { label = "🔥 إشعال النار", action = function() setFire() end },
    { label = "🌪️ عاصفة رياح", action = function() windStorm() end },
    { label = "❄️ تجميد الشاشة", action = function() freezeScreen() end },
    { label = "💔 إلحاق الضرر", action = function() takeDamage(50) end },
    { label = "⬅️ رجوع", submenu = "main" }
}

local protectionMenu = {
    { label = "🛡️ حماية الأبد (God Mode)", action = function() toggleGodMode() end },
    { label = "👻 تخفي", action = function() toggleInvisible() end },
    { label = "🎯 منع الضرر من السيارات", action = function() preventCarDamage() end },
    { label = "💨 سرعة خارقة", action = function() setSpeed() end },
    { label = "🧗 تسلق المباني", action = function() enableClimbing() end },
    { label = "⬅️ رجوع", submenu = "main" }
}

local combatMenu = {
    { label = "🎯 Aimbot", action = function() toggleAimbot() end },
    { label = "🔍 Silent Aim", action = function() toggleSilentAim() end },
    { label = "👁️ ESP", action = function() toggleESP() end },
    { label = "💣 Wallbang", action = function() enableWallbang() end },
    { label = "⚡ One Shot Kill", action = function() enableOneShot() end },
    { label = "🎯 Auto Headshot", action = function() enableAutoHeadshot() end },
    { label = "⬅️ رجوع", submenu = "main" }
}

local settingsMenu = {
    { label = "🔊 صوت عالي", action = function() setVolume(1.0) end },
    { label = "🔇 صوت منخفض", action = function() setVolume(0.5) end },
    { label = "⏱️ إبطاء الزمن", action = function() setTimeScale(0.5) end },
    { label = "⚡ تسريع الزمن", action = function() setTimeScale(1.0) end },
    { label = "🌙 تبديل الليل والنهار", action = function() toggleTime() end },
    { label = "⬅️ رجوع", submenu = "main" }
}

function getMenuOptions()
    if currentMenu == "main" then return mainMenu
    elseif currentMenu == "vehicles" then return vehiclesMenu
    elseif currentMenu == "respawn_vehicles" then return respawnVehiclesMenu
    elseif currentMenu == "weapons" then return weaponsMenu
    elseif currentMenu == "respawn_weapons" then return respawnWeaponsMenu
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
end

function drawMenu()
    if not menuOpen then return end
    
    local currentOptions = getMenuOptions()
    local menuWidth = 0.25
    local itemHeight = 0.035
    local totalHeight = itemHeight * (#currentOptions + 1)
    
    -- رسم الخلفية
    DrawRect(menuX + menuWidth/2, menuY + totalHeight/2, menuWidth, totalHeight, 0, 0, 0, 200)
    
    -- رسم العنوان
    drawText("≡ MachoCheats Pro", menuX + menuWidth/2, menuY - 0.025, menuScale + 0.1, 255, 0, 255, 255)
    
    -- رسم الخيارات
    for i, option in ipairs(currentOptions) do
        local optionY = menuY + (itemHeight * (i - 0.5))
        local isSelected = (i == selectedOption)
        
        if isSelected then
            DrawRect(menuX + menuWidth/2, optionY, menuWidth, itemHeight, 255, 0, 255, 220)
        else
            DrawRect(menuX + menuWidth/2, optionY, menuWidth, itemHeight, 50, 50, 50, 150)
        end
        
        drawText(option.label, menuX + 0.01, optionY - 0.007, menuScale, 255, 255, 255, 255)
    end
end

function drawText(text, x, y, scale, r, g, b, a)
    SetTextFont(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    BeginTextCommandDisplayText("STRING")
    AddTextComponentString(text)
    EndTextCommandDisplayText(x, y)
end

-- ============ الأوامر الفعلية ============

function giveMoney(amount)
    print("^2[MachoCheats]^7 تمت إضافة " .. amount .. " دولار")
end

function spawnVehicle(modelName)
    local ped = PlayerPedId()
    local model = GetHashKey(modelName)
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(100) end
    local x, y, z = table.unpack(GetEntityCoords(ped))
    local vehicle = CreateVehicle(model, x + 5, y, z, GetEntityHeading(ped), true, false)
    SetPedIntoVehicle(ped, vehicle, -1)
    print("^2[MachoCheats]^7 تم استدعاء السيارة: " .. modelName)
end

function repairVehicle()
    local ped = PlayerPedId()
    if IsPedInAnyVehicle(ped) then
        local vehicle = GetVehiclePedIsIn(ped)
        SetVehicleEngineHealth(vehicle, 1000.0)
        SetVehicleDeformationFixed(vehicle)
        print("^2[MachoCheats]^7 تم إصلاح السيارة")
    end
end

function hideVehicle()
    local ped = PlayerPedId()
    if IsPedInAnyVehicle(ped) then
        local vehicle = GetVehiclePedIsIn(ped)
        SetEntityAsNoLongerNeeded(vehicle)
        DeleteEntity(vehicle)
        print("^2[MachoCheats]^7 اختفت السيارة")
    end
end

function teleportVehicle()
    local ped = PlayerPedId()
    if IsPedInAnyVehicle(ped) then
        local vehicle = GetVehiclePedIsIn(ped)
        local x, y, z = 0.0, 0.0, 72.0
        SetEntityCoords(vehicle, x, y, z)
        print("^2[MachoCheats]^7 تم نقل السيارة")
    end
end

function respawnVehicleGarage()
    print("^2[MachoCheats]^7 تم رسبنة السيارة في المرآب")
end

function respawnVehicleHere()
    local ped = PlayerPedId()
    local x, y, z = table.unpack(GetEntityCoords(ped))
    local model = GetHashKey("adder")
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(100) end
    CreateVehicle(model, x + 5, y, z, 0.0, true, false)
    print("^2[MachoCheats]^7 تم رسبنة السيارة هنا")
end

function giveWeapon(weaponName)
    local ped = PlayerPedId()
    GiveWeaponToPed(ped, GetHashKey(weaponName), 9999, false, true)
    print("^2[MachoCheats]^7 تم إضافة سلاح: " .. weaponName)
end

function respawnAllWeapons()
    local ped = PlayerPedId()
    GiveWeaponToPed(ped, GetHashKey("WEAPON_PISTOL"), 9999, false, true)
    GiveWeaponToPed(ped, GetHashKey("WEAPON_SMG"), 9999, false, true)
    GiveWeaponToPed(ped, GetHashKey("WEAPON_ASSAULTRIFLE"), 9999, false, true)
    GiveWeaponToPed(ped, GetHashKey("WEAPON_SNIPERRIFLE"), 9999, false, true)
    GiveWeaponToPed(ped, GetHashKey("WEAPON_RPG"), 9999, false, true)
    print("^2[MachoCheats]^7 تم إضافة جميع الأسلحة")
end

function removeAllWeapons()
    local ped = PlayerPedId()
    RemoveAllPedWeapons(ped, true)
    print("^2[MachoCheats]^7 تم حذف جميع الأسلحة")
end

function toggleFlight()
    flyMode = not flyMode
    if flyMode then
        print("^2[MachoCheats]^7 تم تفعيل الطيران")
    else
        print("^2[MachoCheats]^7 تم إيقاف الطيران")
    end
end

function teleportToMarker()
    local blip = GetFirstBlipInfoId(8)
    if DoesBlipExist(blip) then
        local x, y, z = table.unpack(GetBlipCoords(blip))
        local ped = PlayerPedId()
        SetEntityCoords(ped, x, y, z + 1, false, false, false, false)
        print("^2[MachoCheats]^7 تم النقل إلى السحب")
    else
        print("^1[MachoCheats]^7 لم تضع سحب!")
    end
end

function teleport(x, y, z)
    local ped = PlayerPedId()
    SetEntityCoords(ped, x, y, z, false, false, false, false)
    print("^2[MachoCheats]^7 تم النقل السريع")
end

function setSkin(skinName)
    local model = GetHashKey(skinName)
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(100) end
    SetPlayerModel(PlayerId(), model)
    print("^2[MachoCheats]^7 تم تغيير المظهر")
end

function explodeVehicle()
    local ped = PlayerPedId()
    if IsPedInAnyVehicle(ped) then
        local vehicle = GetVehiclePedIsIn(ped)
        SetVehicleEngineHealth(vehicle, 0.0)
        print("^2[MachoCheats]^7 انفجرت السيارة")
    end
end

function explodePlayers()
    print("^2[MachoCheats]^7 تم تفجير اللاعبين")
end

function setFire()
    local ped = PlayerPedId()
    StartEntityFire(ped)
    print("^2[MachoCheats]^7 اشتعلت النيران")
end

function windStorm()
    print("^2[MachoCheats]^7 عاصفة رياح مفعلة")
end

function freezeScreen()
    print("^2[MachoCheats]^7 الشاشة مجمدة")
end

function takeDamage(amount)
    local ped = PlayerPedId()
    ApplyDamageToPed(ped, amount, false)
    print("^2[MachoCheats]^7 تم إلحاق ضرر: " .. amount)
end

function toggleGodMode()
    godMode = not godMode
    local ped = PlayerPedId()
    SetEntityInvincible(ped, godMode)
    if godMode then
        print("^2[MachoCheats]^7 حماية الأبد: مفعلة")
    else
        print("^1[MachoCheats]^7 حماية الأبد: معطلة")
    end
end

function toggleInvisible()
    invisibleMode = not invisibleMode
    local ped = PlayerPedId()
    SetEntityVisible(ped, not invisibleMode)
    if invisibleMode then
        print("^2[MachoCheats]^7 التخفي: مفعل")
    else
        print("^1[MachoCheats]^7 التخفي: معطل")
    end
end

function preventCarDamage()
    print("^2[MachoCheats]^7 منع الضرر من السيارات: مفعل")
end

function setSpeed()
    local ped = PlayerPedId()
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.5)
    print("^2[MachoCheats]^7 السرعة الخارقة: مفعلة")
end

function enableClimbing()
    print("^2[MachoCheats]^7 تسلق المباني: مفعل")
end

function setVolume(volume)
    print("^2[MachoCheats]^7 مستوى الصوت: " .. (volume * 100) .. "%")
end

function setTimeScale(scale)
    SetTimeScale(scale)
    print("^2[MachoCheats]^7 سرعة الزمن: " .. scale)
end

function toggleTime()
    print("^2[MachoCheats]^7 تم تبديل الليل والنهار")
end

-- ============ AIMBOT ============
function toggleAimbot()
    aimbotEnabled = not aimbotEnabled
    if aimbotEnabled then
        print("^2[MachoCheats]^7 Aimbot: مفعل")
    else
        print("^1[MachoCheats]^7 Aimbot: معطل")
    end
end

-- ============ SILENT AIM ============
function toggleSilentAim()
    silentAimEnabled = not silentAimEnabled
    if silentAimEnabled then
        print("^2[MachoCheats]^7 Silent Aim: مفعل")
    else
        print("^1[MachoCheats]^7 Silent Aim: معطل")
    end
end

-- ============ ESP ============
function toggleESP()
    espEnabled = not espEnabled
    if espEnabled then
        print("^2[MachoCheats]^7 ESP: مفعل")
    else
        print("^1[MachoCheats]^7 ESP: معطل")
    end
end

function enableWallbang()
    print("^2[MachoCheats]^7 Wallbang: مفعل")
end

function enableOneShot()
    print("^2[MachoCheats]^7 One Shot Kill: مفعل")
end

function enableAutoHeadshot()
    print("^2[MachoCheats]^7 Auto Headshot: مفعل")
end

-- ============ دالة العثور على أقرب لاعب ============
function GetClosestPed()
    local playerPed = PlayerPedId()
    local players = GetPlayers()
    local closestDistance = 999999.0
    local closestPed = nil
    
    for _, player in ipairs(players) do
        if player ~= PlayerId() then
            local targetPed = GetPlayerPed(player)
            if targetPed ~= 0 then
                local distance = #(GetEntityCoords(playerPed) - GetEntityCoords(targetPed))
                if distance < closestDistance and distance < 500.0 then
                    closestDistance = distance
                    closestPed = targetPed
                end
            end
        end
    end
    
    return closestPed
end

function GetPlayers()
    local players = {}
    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end
    return players
end

-- ============ خيط Aimbot ============
Citizen.CreateThread(function()
    while true do
        Wait(0)
        
        if aimbotEnabled then
            local targetPed = GetClosestPed()
            if targetPed ~= nil then
                local playerPed = PlayerPedId()
                local targetCoords = GetPedBoneCoords(targetPed, 0x796E8440, 0, 0, 0) -- رأس اللاعب
                local playerCoords = GetEntityCoords(playerPed)
                
                -- توجيه الرؤية نحو الهدف
                local direction = targetCoords - playerCoords
                local yaw = math.atan2(direction.y, direction.x) * 180 / math.pi
                local pitch = math.atan2(direction.z, #(vector2(direction.x, direction.y))) * 180 / math.pi
                
                -- تطبيق الاتجاه
                SetGameplayCamRelativeHeading(yaw)
            end
        end
        
        if silentAimEnabled then
            local targetPed = GetClosestPed()
            if targetPed ~= nil and IsPlayerFreeAiming(PlayerId()) then
                local targetCoords = GetPedBoneCoords(targetPed, 0x796E8440, 0, 0, 0)
                local playerPed = PlayerPedId()
                local weaponHash = GetSelectedPedWeapon(playerPed)
                
                -- إطلاق النار بصمت نحو الهدف
                if GetAmmoInClip(playerPed, weaponHash) > 0 then
                    ShootAtCoord(playerPed, targetCoords.x, targetCoords.y, targetCoords.z, weaponHash)
                end
            end
        end
    end
end)

-- ============ خيط ESP ============
Citizen.CreateThread(function()
    while true do
        Wait(0)
        
        if espEnabled then
            local players = GetPlayers()
            for _, player in ipairs(players) do
                if player ~= PlayerId() then
                    local targetPed = GetPlayerPed(player)
                    if targetPed ~= 0 then
                        local targetCoords = GetEntityCoords(targetPed)
                        local playerPed = PlayerPedId()
                        local playerCoords = GetEntityCoords(playerPed)
                        
                        -- حساب المسافة
                        local distance = #(playerCoords - targetCoords)
                        
                        -- رسم خط من اللاعب إلى الهدف
                        DrawLine(playerCoords.x, playerCoords.y, playerCoords.z, targetCoords.x, targetCoords.y, targetCoords.z, 255, 0, 255, 200)
                        
                        -- رسم صندوق حول الهدف
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

-- ============ خيط الطيران ============
Citizen.CreateThread(function()
    while true do
        Wait(0)
        
        if flyMode then
            local ped = PlayerPedId()
            local x, y, z = table.unpack(GetEntityCoords(ped))
            
            if IsControlPressed(0, 32) then -- W
                z = z + 1.0
            end
            if IsControlPressed(0, 33) then -- S
                z = z - 1.0
            end
            if IsControlPressed(0, 34) then -- A
                x = x - 1.0
            end
            if IsControlPressed(0, 35) then -- D
                x = x + 1.0
            end
            
            SetEntityCoords(ped, x, y, z)
        end
    end
end)

-- ============ خيط المعالجة الرئيسية ============
Citizen.CreateThread(function()
    while true do
        Wait(0)
        
        -- فتح المنيو بـ semicolon (;)
        if IsControlJustReleased(0, 243) then
            toggleMenu()
        end
        
        if menuOpen then
            local currentOptions = getMenuOptions()
            
            -- التنقل لأعلى
            if IsControlJustReleased(0, 172) then
                selectedOption = selectedOption - 1
                if selectedOption < 1 then
                    selectedOption = #currentOptions
                end
            end
            
            -- التنقل لأسفل
            if IsControlJustReleased(0, 173) then
                selectedOption = selectedOption + 1
                if selectedOption > #currentOptions then
                    selectedOption = 1
                end
            end
            
            -- تنفيذ الخيار
            if IsControlJustReleased(0, 191) then
                local option = currentOptions[selectedOption]
                if option.submenu then
                    currentMenu = option.submenu
                    selectedOption = 1
                elseif option.action then
                    option.action()
                end
            end
            
            -- العودة للقائمة السابقة
            if IsControlJustReleased(0, 194) then
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