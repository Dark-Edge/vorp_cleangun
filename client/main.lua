--==========================================--
--====   	   CLEAN GUN SCRIPT     	====--
--====      Rework of Le Bookmaker   	====--
--====        and Alphatule Script		====--
--====         	 By Darky_13         	====--
--==========================================--

local key = 0xF09866F3

-- for cleaning your gun with animation ENJOY
RegisterNetEvent('cleaning:startcleaningshort')
AddEventHandler('cleaning:startcleaningshort', function()
    local ped = PlayerPedId()
    local Cloth= CreateObject(GetHashKey('s_balledragcloth01x'), GetEntityCoords(PlayerPedId()), false, true, false, false, true)
    local PropId = GetHashKey("CLOTH")
    local actshort = GetHashKey("SHORTARM_CLEAN_ENTER")
    local actlong = GetHashKey("LONGARM_CLEAN_ENTER")
	local wep = GetCurrentPedWeaponEntityIndex(ped, 0)
    local _, wepHash = GetCurrentPedWeapon(ped, true, 0, true)
	local WeaponType = GetWeaponType(wepHash)
    local retval, weaponHash = GetCurrentPedWeapon(PlayerPedId(), false, weaponHash, false)
    local model = GetWeapontypeGroup(weaponHash)
    local object = GetObjectIndexFromEntityIndex(GetCurrentPedWeaponEntityIndex(PlayerPedId(),0))
    if wepHash == `WEAPON_UNARMED` then return end
    if WeaponType == "SHOTGUN" then WeaponType = "LONGARM" end
    if WeaponType == "MELEE" then WeaponType = "SHORTARM" end
	if WeaponType == "BOW" then WeaponType = "SHORTARM" end
	TriggerEvent("vorp_inventory:CloseInv");
    TaskItemInteraction_2(PlayerPedId(), wepHash, Cloth, PropId, GetHashKey(WeaponType.."_CLEAN_ENTER"), 1, 1, -1.0)
	Wait(15000)
	SetWeaponDegradation(object,0.0,0)
    SetWeaponDirt(object,0.0,0)
end)


RegisterCommand('inspect', function(source, args, raw)
    local ped = PlayerPedId()
    local wep = GetCurrentPedWeaponEntityIndex(ped, 0)
    local _, wepHash = GetCurrentPedWeapon(ped, true, 0, true)
    local WeaponType = GetWeaponType(wepHash)
	if wepHash == `WEAPON_UNARMED` then return end
	if WeaponType == "SHOTGUN" then WeaponType = "LONGARM" end
	if WeaponType == "MELEE" then WeaponType = "SHORTARM" end
	if WeaponType == "BOW" then WeaponType = "SHORTARM" end
	ShowWeaponStats()
	TaskItemInteraction_2(PlayerPedId(), wepHash, wep, 0, GetHashKey(WeaponType.."_HOLD_ENTER"), 0, 0, -1.0)
end)

RegisterCommand('cleanweap', function(source, args, raw)
    local ped = PlayerPedId()
	local Cloth= CreateObject(GetHashKey('s_balledragcloth01x'), GetEntityCoords(PlayerPedId()), false, true, false, false, true)
    local wep = GetCurrentPedWeaponEntityIndex(ped, 0)
    local _, wepHash = GetCurrentPedWeapon(ped, true, 0, true)
    local WeaponType = GetWeaponType(wepHash)
    if wepHash == `WEAPON_UNARMED` then return end
    if WeaponType == "SHOTGUN" then WeaponType = "LONGARM" end
    if WeaponType == "MELEE" then WeaponType = "SHORTARM" end
	if WeaponType == "BOW" then WeaponType = "SHORTARM" end
	TriggerEvent("vorp_inventory:CloseInv");
    TaskItemInteraction_2(PlayerPedId(), wepHash, Cloth, PropId, GetHashKey(WeaponType.."_CLEAN_ENTER"), 1, 1, -1.0)
	Wait(15000)
	SetWeaponDegradation(object,0.0,0)
    SetWeaponDirt(object,0.0,0)
end)

function whenKeyJustPressed(key)
    if IsControlJustPressed(0, key) then
        return true
    else
        return false
    end
end


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if whenKeyJustPressed(key) then	
		local ped = PlayerPedId()
			local ped = PlayerPedId()
			local wep = GetCurrentPedWeaponEntityIndex(ped, 0)
			local _, wepHash = GetCurrentPedWeapon(ped, true, 0, true)
			local WeaponType = GetWeaponType(wepHash)
			if wepHash == `WEAPON_UNARMED` then return end
			if WeaponType == "SHOTGUN" then WeaponType = "LONGARM" end
			if WeaponType == "MELEE" then WeaponType = "SHORTARM" end
			if WeaponType == "BOW" then WeaponType = "SHORTARM" end
			ShowWeaponStats()
			TaskItemInteraction_2(PlayerPedId(), wepHash, wep, 0, GetHashKey(WeaponType.."_HOLD_ENTER"), 0, 0, -1.0)
		end
	end
end)


function ShowWeaponStats()
    local PlayerPed = PlayerPedId()
    local WeaponObject = GetObjectIndexFromEntityIndex(GetCurrentPedWeaponEntityIndex(PlayerPed , 0))
    local _, WeaponHash = GetCurrentPedWeapon(PlayerPed, true, 0, true)
    local Block = RequestFlowBlock(GetHashKey("PM_FLOW_WEAPON_INSPECT"))
    local Container = DatabindingAddDataContainerFromPath("" , "ItemInspection")
    DatabindingAddDataBool(Container, "Visible", true)
    DatabindingAddDataString(Container, "tipText", GetLabelText(WeaponObject))
    DatabindingAddDataHash(Container, "itemLabel", WeaponHash)
    Citizen.InvokeNative(0x10A93C057B6BD944 ,Block)
    Citizen.InvokeNative(0x3B7519720C9DCB45	,Block, 0)
    Citizen.InvokeNative(0x4C6F2C4B7A03A266 ,-813354801, Block)
    Citizen.CreateThread(function()
        Wait(1000)
        while true do
            Wait(100)
            if not Citizen.InvokeNative(0x6AA3DCA2C6F5EB6D, PlayerPedId()) then
                Citizen.InvokeNative(0x4EB122210A90E2D8, -813354801)
                break
            end
        end
    end)
end

function GetWeaponType(hash)
	if Citizen.InvokeNative(0x959383DCD42040DA, hash)  or Citizen.InvokeNative(0x792E3EF76C911959, hash)   then
		return "MELEE"
	elseif Citizen.InvokeNative(0x6AD66548840472E5, hash) or Citizen.InvokeNative(0x0A82317B7EBFC420, hash) or Citizen.InvokeNative(0xDDB2578E95EF7138, hash) then
		return "LONGARM"
	elseif  Citizen.InvokeNative(0xC75386174ECE95D5, hash) then
		return "SHOTGUN"
	elseif  Citizen.InvokeNative(0xDDC64F5E31EEDAB6, hash) or Citizen.InvokeNative(0xC212F1D05A8232BB, hash) then
		return "SHORTARM"
	else print ('Erreur : Ce n\'est pas un objet/une arme valide') return "ERROR"
	end
	return false
end

--[[								wanted to convert but the return values are fucked up without natives ones

    UiflowblockIsLoaded(Block)
    UiflowblockEnter(Block, 0)
    UiStateMachineCreate(-813354801, Block)
    Citizen.CreateThread(function()
        Wait(1000)
        while true do
            Wait(100)
            if not GetItemInteractionState(PlayerPedId()) then
                UiStateMachineDestroy(-813354801)
                break
            end
        end
    end)
end

function GetWeaponType(hash)
	if IsWeaponMeleeWeapon(hash)  or IsWeaponKnife(hash)   then
		return "MELEE"
	elseif IsWeaponSniper(hash) or IsWeaponRifle(hash) or IsWeaponRepeater(hash) then
		return "LONGARM"
	elseif  IsWeaponShotgun(hash) then
		return "SHOTGUN"
	elseif  IsWeaponPistol(hash) or IsWeaponRevolver(hash) then
		return "SHORTARM"
	end
	return false
end	--]]

--weaponHash = {
--    "WEAPON_PISTOL_M1899",      
--    "WEAPON_PISTOL_MAUSER",       
--    "WEAPON_PISTOL_SEMIAUTO",        
--    "WEAPON_PISTOL_VOLCANIC",       
--    "WEAPON_REVOLVER_CATTLEMAN",       
--    "WEAPON_REVOLVER_DOUBLEACTION",       
--    "WEAPON_REVOLVER_LEMAT",        
--    "WEAPON_REVOLVER_SCHOFIELD",
--    "WEAPON_REPEATER_CARBINE",
--	"WEAPON_REPEATER_HENRY",
--	"WEAPON_RIFLE_VARMINT",
--    "WEAPON_REPEATER_WINCHESTER",
--    "WEAPON_SHOTGUN_DOUBLEBARREL",
--	"WEAPON_SHOTGUN_DOUBLEBARREL_EXOTIC",
--	"WEAPON_SHOTGUN_PUMP",
--	"WEAPON_SHOTGUN_REPEATING",
--	"WEAPON_SHOTGUN_SAWEDOFF",
--	"WEAPON_SHOTGUN_SEMIAUTO",
--    "WEAPON_SNIPERRIFLE_ROLLINGBLOCK_EXOTIC",
--    "WEAPON_SNIPERRIFLE_ROLLINGBLOCK",
--    "WEAPON_SNIPERRIFLE_CARCANO"
--}                                        
--
---- for cleaning your gun with animation ENJOY
--RegisterNetEvent('cleaning:startcleaningshort')
--AddEventHandler('cleaning:startcleaningshort', function(cleaning)
--    while cleaning do 
--           Citizen.Wait(0) 
--        for i = 1, #weaponHash, 1 do
--            local ped = PlayerPedId()
--            local Cloth= CreateObject(GetHashKey('s_balledragcloth01x'), GetEntityCoords(PlayerPedId()), false, true, false, false, true)
--            local PropId = GetHashKey("CLOTH")
--            local actshort = GetHashKey("SHORTARM_CLEAN_ENTER")
--            local actlong = GetHashKey("LONGARM_CLEAN_ENTER")
--            local retval, weaponName = GetCurrentPedWeapon(PlayerPedId(), false, GetHashKey(weaponHash[i]), false)
--            if i <= 9 then
--                TriggerEvent("vorp_inventory:CloseInv");
--                Citizen.InvokeNative(0x72F52AA2D2B172CC,  PlayerPedId(), 1242464081, Cloth, PropId, actshort, 1, 0, -1.0)   
--                Wait(15000)
--                TriggerEvent("vorp:NotifyLeft", Language.translate[Config.lang]['word'], Language.translate[Config.lang]['notif'], "generic_textures", "tick", 5000)
--                --Citizen.InvokeNative(0xA7A57E89E965D839, weaponHash, 0.0)
--                Citizen.InvokeNative(0xA7A57E89E965D839, weaponName, 0.0)
--                cleaning = false
--            else
--                TriggerEvent("vorp_inventory:CloseInv");
--                Citizen.InvokeNative(0x72F52AA2D2B172CC,  PlayerPedId(), 1242464081, Cloth, PropId, actlong, 1, 0, -1.0)   
--                Wait(15000)
--                TriggerEvent("vorp:NotifyLeft", Language.translate[Config.lang]['word'], Language.translate[Config.lang]['notif'], "generic_textures", "tick", 5000)
--                Citizen.InvokeNative(0xA7A57E89E965D839, weaponName, 0.0)
--                cleaning = false            
--            end
--            if cleaning == false then 
--                break
--            end
--        end 
--    end
--end)
-- 
--
--RegisterCommand('weapon', function(source, args, rawCommand)
--    local retval --[[ boolean ]], weaponHash = GetCurrentPedWeapon(PlayerPedId(), false, weaponHash , false)
--    local weaponName = Citizen.InvokeNative(0x89CF5FF3D363311E, weaponHash)
--    --print("Weapon name --> "..weaponName)
--    print("Weapon hash --> "..weaponHash)
--    --print("Weappon hash --> "..GetHashKey(weaponHash))
--end)
