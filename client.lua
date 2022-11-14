ESX = nil

local nesky1 = {}
local nesky2, nesky3 = nil, nil
local nesky4 = true
local nesky5 = nil
local nesky6 = nil

local vetement = {
    "Mettre",
    "Enlever"
}

local optionmoteur = {
    "Allumer",
    "Eteindre"
}

local porte = {
    "Avant Gauche",
    "Avant Droit",
    "Arrière Gauche",
    "Arrière Droit",
    "Capot",
    "Coffre",
    "Toutes les Portes"
}

ragdol = true

RegisterNetEvent("Ragdoll") 
AddEventHandler("Ragdoll", function()
    if ( ragdol ) then
        setRagdoll(true)
        ragdol = false
        ESX.ShowNotification("Vous êtes par terre !")
    else

        setRagdoll(false)
        ragdol = true
        ESX.ShowNotification("Vous êtes debout !")
    end
end)

Citizen.CreateThread(function()
	while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job2 == nil do
		Citizen.Wait(10)
	end
	while nesky6 == nil do
		TriggerEvent('skinchanger:getSkin', function(skin) nesky6 = skin end)
		Citizen.Wait(10)
    end
    ESX.PlayerData = ESX.GetPlayerData()
	nesky5 = ESX.GetWeaponList()
end)

function startAnim(lib, anim)
	ESX.Streaming.RequestAnimDict(lib, function()
		TaskPlayAnim(plyPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
	end)
end

RegisterNetEvent("::{{sLaKOD}}::#34613")
AddEventHandler("::{{sLaKOD}}::#34613", function(value, quantity)
	local weaponHash = GetHashKey(value)

	if HasPedGotWeapon(plyPed, weaponHash, false) and value ~= 'WEAPON_UNARMED' then
		AddAmmoToPed(plyPed, value, quantity)
	end
end)
function RefreshMoney()
    Citizen.CreateThread(function()
            ESX.Math.GroupDigits(ESX.PlayerData.money)
            ESX.Math.GroupDigits(ESX.PlayerData.accounts[1].money)
            ESX.Math.GroupDigits(ESX.PlayerData.accounts[2].money)
    end)
end
function KeyboardInput(entryTitle, textEntry, inputText, maxLength)
    AddTextEntry(entryTitle, textEntry)
    DisplayOnscreenKeyboard(1, entryTitle, '', inputText, '', '', '', maxLength)
    blockinput = true
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(0)
    end
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Citizen.Wait(500)
        blockinput = false
        return result
    else
        Citizen.Wait(500)
        blockinput = false
        return nil
    end
end


ftest = {
	Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {0, 0, 0}, Title = "Paradise Rp" },
	Data = { currentMenu = "MenuF5 by nesky311","Facture", GetPlayerName() }, 
    Events = {
		onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
		PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
        local slide = btn.slidenum
        local button = btn
        local btn = btn.name   
		local check = btn.unkCheckbox
		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        local currentMenu = self.Data.currentMenu

		if btn == "🧥| Dressing" then              
            RefreshMoney()
            OpenMenu('🧥| Dressing')
        elseif slide == 3 and btn == "Accessoires" then
            TriggerEvent('access:lunette')
        elseif slide == 2 and btn == "Accessoires" then
            TriggerEvent('access:chapeau')
        elseif slide == 1 and btn == "Accessoires" then                                      
            TriggerEvent('access:masque')
        elseif slide == 4 and btn == "Accessoires" then 
            TriggerEvent('access:montre')
        elseif slide == 6 and btn == "Accessoires" then 
            TriggerEvent(':{#AKDsJE}:#951')
        elseif btn == "Bas" then
            TriggerEvent(':{#AKDsJE}:#456')        
        elseif slide == 1 and btn == "Haut" then
            TriggerEvent(':{#AKDsJE}:#123')  
        elseif slide == 2 and btn == "Haut" then
            TriggerEvent(':{#AKDsJE}:#123')  
        elseif slide == 1 and btn == "Chaussure" then                                      
            TriggerEvent(':{#AKDsJE}:#789')
        elseif slide == 2 and btn == "Chaussure" then                                      
            TriggerEvent(':{#AKDsJE}:#789')
        elseif slide == 1 and btn == "Gilet" then                                      
            TriggerEvent(':{#AKDsJE}:#147')
        elseif slide == 2 and btn == "Gilet" then                                      
            TriggerEvent(':{#AKDsJE}:#147')
        elseif slide == 1 and btn == "Sac" then                                      
            TriggerEvent(':{#AKDsJE}:#159')
        elseif slide == 2 and btn == "Sac" then                                      
            TriggerEvent(':{#AKDsJE}:#159')
        end

        if btn == '👛| Portefeuille' then
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
            ESX.PlayerData = ESX.GetPlayerData()
            RefreshMoney()
            ftest.Menu["👛| portefeuille"].b = {}
            table.insert(ftest.Menu["👛| portefeuille"].b, { name = "Facture" , ask = ">", askX = true})
            table.insert(ftest.Menu["👛| portefeuille"].b, { name = "Liquide :  ~g~" .. ESX.Math.GroupDigits(ESX.PlayerData.money).."$",slidemax = { "Donner  ", "Jeter" } })
            table.insert(ftest.Menu["👛| portefeuille"].b, { name = "Banque :  ~g~" .. ESX.Math.GroupDigits(ESX.PlayerData.accounts[1].money).."$",ask = "" , askX =  true}) 
            table.insert(ftest.Menu["👛| portefeuille"].b, { name = "Argent sale :  ~g~" .. ESX.Math.GroupDigits(ESX.PlayerData.accounts[2].money).."$", slidemax = { "Donner   ", "Jeter" } })
            table.insert(ftest.Menu["👛| portefeuille"].b, { name = "----------------" , ask = "", askX = true})
            table.insert(ftest.Menu["👛| portefeuille"].b, { name = "Métier : " .. ESX.PlayerData.job.label, ask = ESX.PlayerData.job.grade_label, askX = true})
            if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
                table.insert(ftest.Menu["👛| portefeuille"].b, { name = "Gestion Entreprise", ask = ">", askX = true})               
            end
            table.insert(ftest.Menu["👛| portefeuille"].b, { name = "Organisation : " .. ESX.PlayerData.job2.label, ask = ESX.PlayerData.job2.grade_label, askX = true})
            if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.grade_name == 'boss' then
                table.insert(ftest.Menu["👛| portefeuille"].b, { name = "Gestion Organisation", ask = ">", askX = true})               
            end
        end
        if button.slidename == "Donner  " and btn == "Liquide :  ~g~" .. ESX.Math.GroupDigits(ESX.PlayerData.money).."$" then       
            if item == walletMoney then
                local quantity = KeyboardInput("Wizz",'Montant', "", 8)
                if quantity ~= nil then
                    local post = true
                    quantity = tonumber(quantity)
                    if type(quantity) == 'number' then
                        quantity = ESX.Math.Round(quantity)
                        if quantity <= 0 then
                            post = false
                        end
                    end
                    local foundPlayers = false
                    nesky1.closestPlayer, nesky1.closestDistance = ESX.Game.GetClosestPlayer()
                    if nesky1.closestDistance ~= -1 and nesky1.closestDistance <= 3 then
                        foundPlayers = true
                    end
                    if foundPlayers == true then
                        local closestPed = GetPlayerPed(nesky1.closestPlayer)
                        if not IsPedSittingInAnyVehicle(closestPed) then
                            if post == true then
                                if item == walletMoney then
                                    TriggerServerEvent('esx:giveInventoryItem', GetPlayerServerId(nesky1.closestPlayer), 'item_money', 'money', quantity)
                                    TaskPlayAnim(GetPlayerPed(-1), "mp_common", "givetake2_a", 2.0, 2.0, 1000, 51, 0, false, false, false)
                                    CloseMenu()
                                end
                            else
                                ESX.ShowNotification('amount_invalid')
                            end
                        else
                            ESX.ShowNotification('Impossible de donner %s dans un véhicule')
                        end
                    else
                        ESX.ShowNotification('Aucun joueur à proximité')
                    end
                end
            end
        end
        if slide == 2 and btn == "Liquide :  ~g~" .. ESX.Math.GroupDigits(ESX.PlayerData.money).."$" then 
            local quantity = KeyboardInput("Wizz", 'Montant', "", 8)
            if quantity ~= nil then
                local post = true
                quantity = tonumber(quantity)
                if type(quantity) == 'number' then
                    quantity = ESX.Math.Round(quantity)

                    if quantity <= 0 then
                        post = false
                    end
                end
                if not IsPedSittingInAnyVehicle(plyPed) then
                    if post == true then
                        if item == walletMoney then
                            TriggerServerEvent('esx:removeInventoryItem', 'item_money', 'money', quantity)
                            CloseMenu()
                        end
                    else
                        ESX.ShowNotification('Montant invalide')
                    end
                else
                    if item == walletMoney then
                        ESX.ShowNotification('Impossible de jeter %s dans un véhicule')
                    end
                end
            end
        end
        if slide == 1 and btn == "Argent sale :  ~g~" .. ESX.Math.GroupDigits(ESX.PlayerData.accounts[2].money).."$" then
            local quantity = KeyboardInput("Wizz", 'Montant', "", 8)
            if quantity ~= nil then
                local post = true
                quantity = tonumber(quantity)
                if type(quantity) == 'number' then
                    quantity = ESX.Math.Round(quantity)
                    if quantity <= 0 then
                        post = false
                    end
                end
                local foundPlayers = false
                nesky1.closestPlayer, nesky1.closestDistance = ESX.Game.GetClosestPlayer()
                if nesky1.closestDistance ~= -1 and nesky1.closestDistance <= 3 then
                    foundPlayers = true
                end
                if foundPlayers == true then
                    local closestPed = GetPlayerPed(nesky1.closestPlayer)
                    if not IsPedSittingInAnyVehicle(closestPed) then
                        if post == true then               
                            if item == walletdirtyMoney then
                                TriggerServerEvent('esx:giveInventoryItem', GetPlayerServerId(nesky1.closestPlayer), 'item_account', 'black_money', quantity)
                                TaskPlayAnim(GetPlayerPed(-1), "mp_common", "givetake2_a", 2.0, 2.0, 1000, 51, 0, false, false, false)
                                CloseMenu()
                            end
                        else
                            ESX.ShowNotification('Montant invalide')
                        end
                    else
                        ESX.ShowNotification('Impossible de donner %s dans un véhicule')
                    end
                else
                    ESX.ShowNotification('Aucun joueur à proximité')
                end
            end
        end
        if slide == 2 and btn == "Argent sale :  ~g~" .. ESX.Math.GroupDigits(ESX.PlayerData.accounts[2].money).."$" then
            local quantity = KeyboardInput("Wizz", 'Montant', "", 8)
            if quantity ~= nil then
                local post = true
                quantity = tonumber(quantity)
                if type(quantity) == 'number' then
                    quantity = ESX.Math.Round(quantity)
                    if quantity <= 0 then
                        post = false
                    end
                end
                if not IsPedSittingInAnyVehicle(plyPed) then
                    if post == true then
                        if item == walletdirtyMoney then
                            TriggerServerEvent('esx:removeInventoryItem', 'item_account', 'black_money', quantity)
                            CloseMenu()
                        end
                    else
                        ESX.ShowNotification('Montant invalide')
                    end
                else
                    if item == walletdirtyMoney then
                        ESX.ShowNotification('Impossible de jeter %s dans un véhicule', 'de l\'argent sale')
                    end
                end
            end
        end
        if btn == "Administration" then
            if nesky3 ~= nil and (nesky3 == 'mod' or nesky3 == 'admin' or nesky3 == 'superadmin' or nesky3 == 'owner') then
                TriggerEvent('')  --- Mettez un trigger d'un menu admin 
                CloseMenu()        
            end
        elseif btn == "Emotes" then
                TriggerEvent('dp:RecieveMenu')
                self:CloseMenu()
        elseif btn == "Dormir / Se réveillez !" then
            TriggerEvent('Ragdoll')
        elseif btn == "Facture" then
            ftest.Menu["Facture"].b = {}
            ESX.TriggerServerCallback('::{{WlzeMD}}::#17735', function(bills)
                for i = 1, #bills, 1 do
                    local label = bills[i].label
                    local amount = bills[i].amount
                    table.insert(ftest.Menu["Facture"].b, { name = bills[i].label.. ": ~g~$"..ESX.Math.GroupDigits(amount) , ask = "", askX = true})
                end
            end)
            Citizen.Wait(200)
            OpenMenu("Facture")
        end
        if currentMenu == "Facture" then
            ESX.TriggerServerCallback('::{{WlzeMD}}::#17735', function(bills)
                for i = 1, #bills, 1 do
				    local label  = bills[i].label
				    local value = bills[i].id
				    if item == billItem[bills[i].id] then
                        ESX.TriggerServerCallback('esx_billing:payBill', function() -- bills trigger change it
                            CloseMenu()
					    end,bills[i].id)
				    end
                end
            end)
        end
        if btn == "🎒| Inventaire" then
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
            ESX.PlayerData = ESX.GetPlayerData()
            ftest.Menu["🎒| inventaire"].b = {}
            for i=1, #ESX.PlayerData.inventory, 1 do
                local count = ESX.PlayerData.inventory[i].count
                if count >= 1 then 
                    table.insert(ftest.Menu["🎒| inventaire"].b, { name = ESX.PlayerData.inventory[i].label .. "  (".. count ..")"  ,slidemax = {"Utiliser","Donner","Jeter "}})
                end
            end
        end
        if button.slidename == "Utiliser" then
            for i=1, #ESX.PlayerData.inventory, 1 do
                local count = ESX.PlayerData.inventory[i].count
                if ESX.PlayerData.inventory[i].label .. "  (".. count ..")" == btn and count > 0 then
                    if ESX.PlayerData.inventory[i].usable then
                        TriggerServerEvent('esx:useItem', ESX.PlayerData.inventory[i].name)
                        CloseMenu()
                    else
                        ESX.ShowNotification('Pas utilisable', ESX.PlayerData.inventory[i].label)
                    end
                end 
            end
        end
        if button.slidename == "Donner" then
            local quantity = KeyboardInput("Wizz", 'Montant', "", 8)
            for i=1, #ESX.PlayerData.inventory, 1 do
                local count = ESX.PlayerData.inventory[i].count
                if ESX.PlayerData.inventory[i].label .. "  (".. count ..")" == btn and count > 0 then
                    local foundPlayers = false
                    nesky1.closestPlayer, nesky1.closestDistance = ESX.Game.GetClosestPlayer()
                    if nesky1.closestDistance ~= -1 and nesky1.closestDistance <= 3 then
                         foundPlayers = true
                    end
                    if foundPlayers == true then
                        local closestPed = GetPlayerPed(nesky1.closestPlayer)
                        if quantity ~= nil and count > 0 then
                            local post = true
                            quantity = tonumber(quantity)
                            if type(quantity) == 'number' then
                                quantity = ESX.Math.Round(quantity)
                    
                                if quantity <= 0 then
                                    post = false
                                end
                            end
                            TriggerServerEvent('esx:giveInventoryItem', GetPlayerServerId(nesky1.closestPlayer), 'item_standard', ESX.PlayerData.inventory[i].name, quantity)
                            TaskPlayAnim(GetPlayerPed(-1), "mp_common", "givetake2_a", 2.0, 2.0, 1000, 51, 0, false, false, false)
                            CloseMenu() --ez nikmoukouk
                        else
                            ESX.ShowNotification('Montant invalide')
                        end
                    else
                        ESX.ShowNotification('Aucun joueur à proximité')
                    end
                 end
            end
        end
        if button.slidename == "Jeter " then
            local quantity = KeyboardInput("Wizz", 'Montant', "", 8)
            for i=1, #ESX.PlayerData.inventory, 1 do
                local count = ESX.PlayerData.inventory[i].count
                if ESX.PlayerData.inventory[i].label .. "  (".. count ..")" == btn and count > 0 then
                    if not IsPedSittingInAnyVehicle(plyPed) then
                        if quantity ~= nil then
                            local post = true
                            quantity = tonumber(quantity)
                            if type(quantity) == 'number' then
                                quantity = ESX.Math.Round(quantity)
                                if quantity <= 0 then
                                    post = false
                                end
                            end
                            TriggerServerEvent('esx:removeInventoryItem', 'item_standard', ESX.PlayerData.inventory[i].name, quantity)
                            TaskPlayAnim(GetPlayerPed(-1), "random@domestic", "pickup_low", 2.0, 2.0, 1000, 51, 0, false, false, false)
                            CloseMenu()
                            Wait(100)
                            CreateMenu(ftest)
                            Wait(100)
                            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
                            ESX.PlayerData = ESX.GetPlayerData()
                            ftest.Menu["🎒| inventaire"].b = {}
                            for i=1, #ESX.PlayerData.inventory, 1 do
                                local count = ESX.PlayerData.inventory[i].count
                                if count >= 1 then 
                                    table.insert(ftest.Menu["🎒| inventaire"].b, { name = ESX.PlayerData.inventory[i].label .. "  (".. count ..")"  ,slidemax = {"Utiliser","Donner","Jeter "}})
                                end
                            end
                            OpenMenu('🎒| inventaire')
                        else
                            ESX.ShowNotification('Montant invalide')
                        end
                    else
                        ESX.ShowNotification('Impossible de jeter %s dans un véhicule', ESX.PlayerData.inventory[i].label)
                    end
                 end
            end
        end
        if btn == "Gestion Entreprise" then
            ftest.Menu["Gestion Entreprise"].b = {}
            ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
            table.insert(ftest.Menu["Gestion Entreprise"].b, { name = "Argent Société : ~g~$" ..ESX.Math.GroupDigits(money) , ask = "", askX = true}) end, ESX.PlayerData.job.name)
            table.insert(ftest.Menu["Gestion Entreprise"].b, { name = "Recruter", ask = "", askX = true})
            table.insert(ftest.Menu["Gestion Entreprise"].b, { name = "Promouvoir", ask = "", askX = true})
            table.insert(ftest.Menu["Gestion Entreprise"].b, { name = "Destituer" , ask = "", askX = true})
            table.insert(ftest.Menu["Gestion Entreprise"].b, { name = "Virer", ask = "", askX = true})
            Citizen.Wait(200)
            OpenMenu("Gestion Entreprise")
        end 
        if btn == "Recruter" then 
            if ESX.PlayerData.job.grade_name == 'boss'  then
				nesky1.closestPlayer, nesky1.closestDistance = ESX.Game.GetClosestPlayer()
				if nesky1.closestPlayer == -1 or nesky1.closestDistance > 3.0 then
					ESX.ShowNotification('Aucun joueur à proximité')
				else
					TriggerServerEvent('::{{WZiChMD}}::#97842', GetPlayerServerId(nesky1.closestPlayer), ESX.PlayerData.job.name, 0)
				end
			else
				ESX.ShowNotification('Vous n\'avez pas les ~r~droits~w~')
            end
        elseif btn == "Promouvoir" then
            if ESX.PlayerData.job.grade_name == 'boss' then
				nesky1.closestPlayer, nesky1.closestDistance = ESX.Game.GetClosestPlayer()
				if nesky1.closestPlayer == -1 or nesky1.closestDistance > 3.0 then
					ESX.ShowNotification('Aucun joueur à proximité')
				else
					TriggerServerEvent('::{{WZiChMD}}::#91435', GetPlayerServerId(nesky1.closestPlayer))
				end
			else
				ESX.ShowNotification('Vous n\'avez pas les ~r~droits~w~')
            end
        elseif btn == "Virer" then 
            if ESX.PlayerData.job.grade_name == 'boss' or ESX.PlayerData.job.grade_name == 'capitaine' then
				nesky1.closestPlayer, nesky1.closestDistance = ESX.Game.GetClosestPlayer()
				if nesky1.closestPlayer == -1 or nesky1.closestDistance > 3.0 then
					ESX.ShowNotification('Aucun joueur à proximité')
				else
					TriggerServerEvent('::{{WZiChMD}}::#86735', GetPlayerServerId(nesky1.closestPlayer))
				end
			else
				ESX.ShowNotification('Vous n\'avez pas les ~r~droits~w~')
            end
        elseif btn == "Destituer" then 
            if ESX.PlayerData.job.grade_name == 'boss' or ESX.PlayerData.job.grade_name == 'capitaine' then
				nesky1.closestPlayer, nesky1.closestDistance = ESX.Game.GetClosestPlayer()
				if nesky1.closestPlayer == -1 or nesky1.closestDistance > 3.0 then
					ESX.ShowNotification('Aucun joueur à proximité')
				else
					TriggerServerEvent('::{{WZiChMD}}::#87643', GetPlayerServerId(nesky1.closestPlayer))
				end
			else
				ESX.ShowNotification('Vous n\'avez pas les ~r~droits~w~')
            end
        end
        if btn == "Gestion Organisation" then 
            ftest.Menu["Gestion Organisation"].b = {}
            ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
            table.insert(ftest.Menu["Gestion Organisation"].b, { name = "Argent Organisation : ~g~$" ..ESX.Math.GroupDigits(money) , ask = "", askX = true}) end, ESX.PlayerData.job2.name)
            table.insert(ftest.Menu["Gestion Organisation"].b, { name = "Recruter ", ask = "", askX = true})
            table.insert(ftest.Menu["Gestion Organisation"].b, { name = "Promouvoir ", ask = "", askX = true})
            table.insert(ftest.Menu["Gestion Organisation"].b, { name = "Destituer " , ask = "", askX = true})
            table.insert(ftest.Menu["Gestion Organisation"].b, { name = "Virer ", ask = "", askX = true})
            Citizen.Wait(150)
            OpenMenu("Gestion Organisation")
        elseif btn == "Recruter " then
            if ESX.PlayerData.job2.grade_name == 'boss' then
				nesky1.closestPlayer, nesky1.closestDistance = ESX.Game.GetClosestPlayer()

				if nesky1.closestPlayer == -1 or nesky1.closestDistance > 3.0 then
					ESX.ShowNotification("~r~Aucun joueur.")
				else
					TriggerServerEvent('::{{WZiChMD}}::#78145', GetPlayerServerId(nesky1.closestPlayer), ESX.PlayerData.job2.name, 0)
				end
			else
				ESX.ShowNotification('Vous n\'avez pas les ~r~droits~w~')
            end
        elseif btn == "Promouvoir " then
            if ESX.PlayerData.job2.grade_name == 'boss' then
				nesky1.closestPlayer, nesky1.closestDistance = ESX.Game.GetClosestPlayer()
				if nesky1.closestPlayer == -1 or nesky1.closestDistance > 3.0 then
					ESX.ShowNotification("~r~Aucun joueur.")
				else
					TriggerServerEvent('::{{WZiChMD}}::#81346', GetPlayerServerId(nesky1.closestPlayer))
				end
			else
				ESX.ShowNotification('Vous n\'avez pas les ~r~droits~w~')
            end
        elseif btn == "Virer " then
            if ESX.PlayerData.job2.grade_name == 'boss' then
				nesky1.closestPlayer, nesky1.closestDistance = ESX.Game.GetClosestPlayer()
				if nesky1.closestPlayer == -1 or nesky1.closestDistance > 3.0 then
					ESX.ShowNotification("~r~Aucun joueur.")
				else
					TriggerServerEvent('::{{WZiChMD}}::#77495', GetPlayerServerId(nesky1.closestPlayer))
				end
			else
				ESX.ShowNotification('Vous n\'avez pas les ~r~droits~w~')
            end
        elseif btn == "Destituer " then
            if ESX.PlayerData.job2.grade_name == 'boss' then
				nesky1.closestPlayer, nesky1.closestDistance = ESX.Game.GetClosestPlayer()
				if nesky1.closestPlayer == -1 or nesky1.closestDistance > 3.0 then
					ESX.ShowNotification("~r~Aucun joueur.")
				else
					TriggerServerEvent('::{{WZiChMD}}::#79468', GetPlayerServerId(nesky1.closestPlayer))
				end
			else
				ESX.ShowNotification('Vous n\'avez pas les ~r~droits~w~')
            end
        end
        if btn == "🔫| Gestion Armes" then 
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
            ESX.PlayerData = ESX.GetPlayerData()
            ftest.Menu["🔫| Gestion Armes"].b = {}
            for k,v in ipairs(nesky2) do
                table.insert(ftest.Menu["🔫| Gestion Armes"].b, { name = v.label  , slidemax = {"Donner", "Jeter"}})
            end
            OpenMenu("🔫| Gestion Armes")
        end
        if button.slidename == "Donner" then
            for k,v in ipairs(nesky2) do
                if v.label == btn then 
                    local ammo 		= GetAmmoInPedWeapon(plyPed, weaponHash)
                    local value	    = v.name
                    local label	    = v.label
                    local foundPlayers = false
					nesky1.closestPlayer, nesky1.closestDistance = ESX.Game.GetClosestPlayer()
					if nesky1.closestDistance ~= -1 and nesky1.closestDistance <= 3 then
				 		foundPlayers = true
					end
					if foundPlayers == true then
						local closestPed = GetPlayerPed(nesky1.closestPlayer)
						if not IsPedSittingInAnyVehicle(closestPed) then
							TriggerServerEvent('esx:giveInventoryItem', GetPlayerServerId(nesky1.closestPlayer), 'item_weapon', value, ammo)
							CloseMenu()
						else
							ESX.ShowNotification( 'Impossible de donner %s dans un véhicule', label)
						end
					else
						ESX.ShowNotification('Aucun joueur à proximité')
					end
                end
            end
        end 
        if button.slidename == "Jeter"  then
            for k,v in ipairs(nesky2) do
                if v.label == btn then 
                    local value	    = v.name
                    TriggerServerEvent('esx:removeInventoryItem', 'item_weapon', value)
                    CloseMenu()
                end
            end
        end
    end,
    },
	Menu = { 
		["MenuF5 by nesky311"] = { 
			b = { 
                {name = "🎒| Inventaire", ask = ">", askX = true}, 
                {name = "🔫| Gestion Armes", ask = ">", askX = true}, 
                {name = "~b~---------------", ask = "", askX = true}, 
                {name = "👛| Portefeuille", ask = ">", askX = true}, 
                {name = "👔| Gestion Métier", ask = ">", askX = true},
                {name = "💃| Gestion Animations", ask = ">", askX = true},
                {name = "~r~---------------", ask = ">", askX = true}, 
                {name = "🧥| Dressing", ask = ">", askX = true},  
			}
        },
        ["👛| portefeuille"] = { 
			b = {
			}
		},
        ["🧥| Dressing"] = { 
			b = { 
                {name = "🧥 - Vêtements ", ask = ">", askX = true}, 
                {name = "👕 - Accessoires", slidemax = {"Masque","Chapeau", "Lunette", "Montre(s)","Chaine(s)"}}, 
			}
		},
        ["🧥 - vêtements "] = { 
			b = { 
                {name = "Haut", slidemax = vetement}, 
                {name = "Bas", slidemax = vetement}, 	
                {name = "Gilet", slidemax = vetement}, 
                {name = "Chaussure", slidemax = vetement}, 
                {name = "Sac", slidemax = vetement}, 
            }
		},
        ["Facture"] = { 
			b = {
			}
        },
        ["👔| gestion métier"] = {
            b = {
              {name = "Gestion Entreprise", ask = ">", askX = true},
              {name = "Gestion Organisation", ask = ">", askX = true}
            }
        },
        ["🎒| inventaire"] = { 
			b = {
			}
        },
        ["🔫| Gestion Armes"] = { 
			b = {
			}
        },
        ["Gestion Entreprise"] = { 
			b = {
			}
        },
        ["Gestion Organisation"] = { 
			b = {
			}
        },
        ["💃| gestion animations"] = {
            b = {
                {name = "Dormir / Se réveillez !", ask = "", askX = true},
                {name = "Emotes", ask = ">", askX = true},
            }
        },
        ["gérer le moteur"] = {
            b = {
            }
        },
        ["gérer le portes"] = {
            b = {
            }
        }
	}
}

local ragdoll = false
function setRagdoll(flag)
  ragdoll = flag
end
Citizen.CreateThread(function()
  while true do
	Citizen.Wait(0)
	if ragdoll then
	  SetPedToRagdoll(GetPlayerPed(-1), 1000, 1000, 0, 0, 0, 0)
	end
  end
end)

--

RegisterNetEvent('access:masque')
AddEventHandler('access:masque', function()

    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
        TriggerEvent('skinchanger:getSkin', function(skinb)

            local lib, anim = 'clothingspecs', 'try_glasses_positive_a'

            ESX.Streaming.RequestAnimDict(lib, function()
                TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
            end)

            Citizen.Wait(1000)
            ClearPedTasks(PlayerPedId())

            if skina.mask_1 ~= skinb.mask_1 then
                TriggerEvent('skinchanger:loadClothes', skinb, {['mask_1'] = skina.mask_1, ['mask_2'] = skina.mask_2})
                accessmasque = true
            else
                TriggerEvent('skinchanger:loadClothes', skinb, {['mask_1'] = 0, ['mask_2'] = 0})
                accessmasque = false
            end
        end)
    end)
end)


---------------------------------------------------------------------------------------------------------------------------------------------------------------


RegisterNetEvent('access:masque')
AddEventHandler('access:masque', function()

    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
        TriggerEvent('skinchanger:getSkin', function(skinb)

            local lib, anim = 'clothingspecs', 'try_glasses_positive_a'

            ESX.Streaming.RequestAnimDict(lib, function()
                TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
            end)

            Citizen.Wait(1000)
            ClearPedTasks(PlayerPedId())

            if skina.mask_1 ~= skinb.mask_1 then
                TriggerEvent('skinchanger:loadClothes', skinb, {['mask_1'] = skina.mask_1, ['mask_2'] = skina.mask_2})
                accessmasque = true
            else
                TriggerEvent('skinchanger:loadClothes', skinb, {['mask_1'] = 0, ['mask_2'] = 0})
                accessmasque = false
            end
        end)
    end)
end)

---------------------------------------------------------------------------------------------------------------------------------------------------------------


RegisterNetEvent('access:chapeau')
AddEventHandler('access:chapeau', function()

    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
        TriggerEvent('skinchanger:getSkin', function(skinb)

            local lib, anim = 'missfbi4', 'takeoff_mask'

            ESX.Streaming.RequestAnimDict(lib, function()
                TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
            end)

            Citizen.Wait(1000)
            ClearPedTasks(PlayerPedId())

            if skina.helmet_1 ~= skinb.helmet_1 then
                TriggerEvent('skinchanger:loadClothes', skinb, {['helmet_1'] = skina.helmet_1, ['helmet_2'] = skina.helmet_2})
                accesschapeau = true
            else
                TriggerEvent('skinchanger:loadClothes', skinb, {['helmet_1'] = -1, ['helmet_2'] = 0})
                accesschapeau = false
            end
        end)
    end)
end)


---------------------------------------------------------------------------------------------------------------------------------------------------------------

RegisterCommand("tpm", function() 
	ESX.TriggerServerCallback('RubyMenu:getUsergroup', function(group)
		playergroup = group
		if playergroup == 'superadmin' or playergroup == 'owner' then
            admin_tp_marker()
		end
	end)
end)

function admin_tp_marker()
	local WaypointHandle = GetFirstBlipInfoId(8)

	if DoesBlipExist(WaypointHandle) then
		local waypointCoords = GetBlipInfoIdCoord(WaypointHandle)

		for height = 1, 1000 do
			SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)

			local foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords["x"], waypointCoords["y"], height + 0.0)

			if foundGround then
				SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)

				break
			end

			Citizen.Wait(0)
		end

		ESX.ShowNotification("Téléportation ~g~Effectuée")
	else
		ESX.ShowNotification("Aucun ~r~Marqueur")
	end
end

RegisterNetEvent('access:montre')
AddEventHandler('access:montre', function()

    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
        TriggerEvent('skinchanger:getSkin', function(skinb)

            local lib, anim = 'clothingtie', 'try_tie_neutral_a'

            ESX.Streaming.RequestAnimDict(lib, function()
                TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
            end)

            Citizen.Wait(1000)
            ClearPedTasks(PlayerPedId())

            if skina.watches_1 ~= skinb.watches_1 then
                TriggerEvent('skinchanger:loadClothes', skinb, {['watches_1'] = skina.watches_1, ['watches_2'] = skina.watches_2})
                accessmontre = true
            else
                TriggerEvent('skinchanger:loadClothes', skinb, {['watches_1'] = -1, ['watches_2'] = 0})
                accessmontre = false
            end
        end)
    end)
end)


---------------------------------------------------------------------------------------------------------------------------------------------------------------





---------------------------------------------------------------------------------------------------------------------------------------------------------------





---------------------------------------------------------------------------------------------------------------------------------------------------------------


RegisterNetEvent('access:lunette')
AddEventHandler('access:lunette', function()

    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
        TriggerEvent('skinchanger:getSkin', function(skinb)

            local lib, anim = 'clothingspecs', 'try_glasses_positive_a'

            ESX.Streaming.RequestAnimDict(lib, function()
                TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
            end)

            Citizen.Wait(1000)
            ClearPedTasks(PlayerPedId())

            if skina.glasses_1 ~= skinb.glasses_1 then
                TriggerEvent('skinchanger:loadClothes', skinb, {['glasses_1'] = skina.glasses_1, ['glasses_2'] = skina.glasses_2})
                accesslunette = true
            else
                TriggerEvent('skinchanger:loadClothes', skinb, {['glasses_1'] = 0, ['glasses_2'] = 0})
                accesslunette = false
            end
        end)
    end)
end)


---------------------------------------------------------------------------------------------------------------------------------------------------------------


RegisterNetEvent('access:oreille')
AddEventHandler('access:oreille', function()

    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
        TriggerEvent('skinchanger:getSkin', function(skinb)

            local lib, anim = 'clothingspecs', 'try_glasses_positive_a'

            ESX.Streaming.RequestAnimDict(lib, function()
                TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
            end)

            Citizen.Wait(1000)
            ClearPedTasks(PlayerPedId())

            if skina.ears_1 ~= skinb.ears_1 then
                TriggerEvent('skinchanger:loadClothes', skinb, {['ears_1'] = skina.ears_1, ['ears_2'] = skina.ears_2})
                accessoreille = true
            else
                TriggerEvent('skinchanger:loadClothes', skinb, {['ears_1'] = -1, ['ears_2'] = 0})
                accessoreille = false
            end
        end)
    end)
end)

RegisterNetEvent(':{#AKDsJE}:#123')
AddEventHandler(':{#AKDsJE}:#123', function()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
        TriggerEvent('skinchanger:getSkin', function(skinb)
            local lib, anim = 'clothingtie', 'try_tie_neutral_a'
            ESX.Streaming.RequestAnimDict(lib, function()
                TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
            end)
            Citizen.Wait(1000)
            ClearPedTasks(PlayerPedId())

            if skina.torso_1 ~= skinb.torso_1 then
                vethaut = true
                TriggerEvent('skinchanger:loadClothes', skinb, {['torso_1'] = skina.torso_1, ['torso_2'] = skina.torso_2, ['tshirt_1'] = skina.tshirt_1, ['tshirt_2'] = skina.tshirt_2, ['arms'] = skina.arms})
            else
                TriggerEvent('skinchanger:loadClothes', skinb, {['torso_1'] = 15, ['torso_2'] = 0, ['tshirt_1'] = 15, ['tshirt_2'] = 0, ['arms'] = 15})
                vethaut = false
            end
        end)
    end)
end)

RegisterNetEvent(':{#AKDsJE}:#456')
AddEventHandler(':{#AKDsJE}:#456', function()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
        TriggerEvent('skinchanger:getSkin', function(skinb)
            local lib, anim = 'clothingtrousers', 'try_trousers_neutral_c'

            ESX.Streaming.RequestAnimDict(lib, function()
                TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
            end)
            Citizen.Wait(1000)
            ClearPedTasks(PlayerPedId())

            if skina.pants_1 ~= skinb.pants_1 then
                TriggerEvent('skinchanger:loadClothes', skinb, {['pants_1'] = skina.pants_1, ['pants_2'] = skina.pants_2})
                vetbas = true
            else
                vetbas = false
                if skina.sex == 1 then
                    TriggerEvent('skinchanger:loadClothes', skinb, {['pants_1'] = 15, ['pants_2'] = 0})
                else
                    TriggerEvent('skinchanger:loadClothes', skinb, {['pants_1'] = 61, ['pants_2'] = 1})
                end
            end
        end)
    end)
end)

function setUniform(value, plyPed)
	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
		TriggerEvent('skinchanger:getSkin', function(skina)

			if value == 'watches' then
				startAnimAction("clothingtie", "try_tie_positive_a")
				Citizen.Wait(1000)
				ClearPedTasks(plyPed)

				if skin.watches_1 ~= skina.watches_1 then
					TriggerEvent('skinchanger:loadClothes', skina, {['watches_1'] = skin.watches_1, ['watches_2'] = skin.watches_2})
				else
					TriggerEvent('skinchanger:loadClothes', skina, {['watches_1'] = -1, ['watches_2'] = -1})
				end
			elseif value == 'bracelet' then
				startAnimAction("clothingtie", "try_tie_positive_a")
				Citizen.Wait(1000)
				ClearPedTasks(plyPed)

				if skin.bracelets_1 ~= skina.bracelets_1 then
					TriggerEvent('skinchanger:loadClothes', skina, {['bracelets_1'] = skin.bracelets_1})
				else
					TriggerEvent('skinchanger:loadClothes', skina, {['bracelets_1'] = -1})
				end
			elseif value == 'colier' then
				startAnimAction("clothingtie", "try_tie_positive_a")
				Citizen.Wait(1000)
				ClearPedTasks(plyPed)

				if skin.chain_1 ~= skina.chain_1 then
					TriggerEvent('skinchanger:loadClothes', skina, {['chain_1'] = skin.chain_1})
				else
					TriggerEvent('skinchanger:loadClothes', skina, {['chain_1'] = -1})
				end
			end
		end)
	end)
end

RegisterNetEvent(':{#AKDsJE}:#789')
AddEventHandler(':{#AKDsJE}:#789', function()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
        TriggerEvent('skinchanger:getSkin', function(skinb)
            local lib, anim = 'clothingshoes', 'try_shoes_positive_a'
            ESX.Streaming.RequestAnimDict(lib, function()
                TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
            end)
            Citizen.Wait(1000)
            ClearPedTasks(PlayerPedId())
            if skina.shoes_1 ~= skinb.shoes_1 then
                TriggerEvent('skinchanger:loadClothes', skinb, {['shoes_1'] = skina.shoes_1, ['shoes_2'] = skina.shoes_2})
                vetch = true
            else
                vetch = false
                if skina.sex == 1 then
                    TriggerEvent('skinchanger:loadClothes', skinb, {['shoes_1'] = 35, ['shoes_2'] = 0})
                else
                    TriggerEvent('skinchanger:loadClothes', skinb, {['shoes_1'] = 34, ['shoes_2'] = 0})
                end
            end
        end)
    end)
end)

RegisterNetEvent(':{#AKDsJE}:#159')
AddEventHandler(':{#AKDsJE}:#159', function()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
        TriggerEvent('skinchanger:getSkin', function(skinb)
            local lib, anim = 'clothingtie', 'try_tie_neutral_a'
            ESX.Streaming.RequestAnimDict(lib, function()
                TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
            end)
            Citizen.Wait(1000)
            ClearPedTasks(PlayerPedId())
            if skina.bags_1 ~= skinb.bags_1 then
                TriggerEvent('skinchanger:loadClothes', skinb, {['bags_1'] = skina.bags_1, ['bags_2'] = skina.bags_2})
                vetsac = true
            else
                TriggerEvent('skinchanger:loadClothes', skinb, {['bags_1'] = 0, ['bags_2'] = 0})
                vetsac = false
            end
        end)
    end)
end)

RegisterNetEvent(':{#AKDsJE}:#357')
AddEventHandler(':{#AKDsJE}:#357', function()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
        TriggerEvent('skinchanger:getSkin', function(skinb)
            local lib, anim = "clothingtie", "try_tie_positive_a"
            ESX.Streaming.RequestAnimDict(lib, function()
                TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
            end)
            Citizen.Wait(1000)
            ClearPedTasks(PlayerPedId())
            if skina.watches_1 ~= skinb.watches_1 then
                TriggerEvent('skinchanger:loadClothes', skinb, {['watches_1'] = skina.watches_1, ['watches_2'] = skina.watches_2})
                vetmontre = true
            else              
                TriggerEvent('skinchanger:loadClothes', skinb, {['watches_1'] = -1, ['watches_2'] = -1})
                vetmontre = false
            end
        end)
    end)
end)

RegisterNetEvent(':{#AKDsJE}:#753')
AddEventHandler(':{#AKDsJE}:#753', function()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
        TriggerEvent('skinchanger:getSkin', function(skinb)
            local lib, anim = "clothingtie", "try_tie_positive_a"
            ESX.Streaming.RequestAnimDict(lib, function()
                TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
            end)
            Citizen.Wait(1000)
            ClearPedTasks(PlayerPedId())
            if skina.chain_1 ~= skinb.chain_1 then
                TriggerEvent('skinchanger:loadClothes', skinb, {['chain_1'] = skina.chain_1})
                vetchaine= true
            else       
                TriggerEvent('skinchanger:loadClothes', skinb, {['chain_1'] = -1})
                vetchaine = false
            end
        end)
    end)
end)

RegisterNetEvent(':{#AKDsJE}:#951')
AddEventHandler(':{#AKDsJE}:#951', function()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
        TriggerEvent('skinchanger:getSkin', function(skinb)
            local lib, anim = "clothingtie", "try_tie_positive_a"
            ESX.Streaming.RequestAnimDict(lib, function()
                TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
            end)
            Citizen.Wait(1000)
            ClearPedTasks(PlayerPedId())
            if skina.bracelets_1 ~= skinb.bracelets_1 then
                TriggerEvent('skinchanger:loadClothes', skinb, {['bracelets_1'] = skina.bracelets_1})
                vetbracelet= true
            else                             
                TriggerEvent('skinchanger:loadClothes', skinb, {['bracelets_1'] = -1})
                vetbracelet = false
            end
        end)
    end)
end)

RegisterNetEvent(':{#AKDsJE}:#147')
AddEventHandler(':{#AKDsJE}:#147', function()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
        TriggerEvent('skinchanger:getSkin', function(skinb)
            local lib, anim = 'clothingtie', 'try_tie_neutral_a'
            ESX.Streaming.RequestAnimDict(lib, function()
                TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
            end)
            Citizen.Wait(1000)
            ClearPedTasks(PlayerPedId())
            if skina.bproof_1 ~= skinb.bproof_1 then
                TriggerEvent('skinchanger:loadClothes', skinb, {['bproof_1'] = skina.bproof_1, ['bproof_2'] = skina.bproof_2})
                vetgilet = true
            else
                TriggerEvent('skinchanger:loadClothes', skinb, {['bproof_1'] = 0, ['bproof_2'] = 0})
                vetgilet = false
            end
        end)
    end)
end)

RegisterNetEvent(':{#AKDsJE}:#258')
AddEventHandler(':{#AKDsJE}:#258', function(accesstype)
    ESX.TriggerServerCallback('esx_accessories:get', function(eskilaunAccessoires, accessorySkin)
        _accessoire = string.lower(accesstype)
        if eskilaunAccessoires then  
            TriggerEvent('skinchanger:getSkin', function(skin)
                local accessoire = -1
                local couleur = 0
                if _accessoire == "glasses" then
                    accessoire = 0
                    local lib, anim = 'clothingspecs', 'try_glasses_positive_a'
                    ESX.Streaming.RequestAnimDict(lib, function()
                        TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, 1000, 0, 0, false, false, false)
                    end)
                    Citizen.Wait(1000)
                    ClearPedTasks(PlayerPedId())
                elseif _accessoire == "mask" then
                    accessoire = 0
                    local lib, anim = 'missfbi4', 'takeoff_mask'
                    ESX.Streaming.RequestAnimDict(lib, function()
                        TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, 1000, 0, 0, false, false, false)
                    end)
                    Citizen.Wait(850)
					ClearPedTasks(PlayerPedId())
                elseif _accessoire == "helmet" then
                    local lib, anim = 'missfbi4', 'takeoff_mask'
                    ESX.Streaming.RequestAnimDict(lib, function()
                        TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, 1000, 0, 0, false, false, false)
                    end)
                    Citizen.Wait(850)
                    ClearPedTasks(PlayerPedId())
                end
                if skin[_accessoire .. '_1'] == accessoire then
                    accessoire = accessorySkin[_accessoire .. '_1']
                    couleur = accessorySkin[_accessoire .. '_2']
                    if _accessoire == "glasses" then
                        vetlunettes = true
                    elseif _accessoire == "mask" then
                        vetmasque = true
                    elseif _accessoire == "helmet" then
                        vetchapeau = true
                    end
                else
                    if _accessoire == "glasses" then
                        vetlunettes = false
                    elseif _accessoire == "mask" then
                        vetmasque = false
                    elseif _accessoire == "helmet" then
                        vetchapeau = false
                    end
                end
                local accessorySkin = {}
                accessorySkin[_accessoire .. '_1'] = accessoire
                accessorySkin[_accessoire .. '_2'] = couleur
                TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
            end)
        else
            if _accessoire == "glasses" then
                ESX.ShowNotification('Vous n\'avez pas de Chapeaux')
            elseif _accessoire == "mask" then
                ESX.ShowNotification('Vous n\'avez pas de Chapeaux')
            elseif _accessoire == "helmet" then
                ESX.ShowNotification('Vous n\'avez pas de Chapeaux')
            end
        end
    end, accesstype)
end)



Citizen.CreateThread(function()
    while true do
        Wait(1)
        if IsControlJustReleased(0, 166) then
            nesky2 = nil
            ESX.TriggerServerCallback('::{{sLaKOD}}::#64135', function(lAomrMD) nesky2 = lAomrMD end)
            if nesky4 then
                if nesky3 ~= nil and (nesky3 == 'mod' or nesky3 == 'admin' or nesky3 == 'superadmin' or nesky3 == 'owner') then
                    table.insert(ftest.Menu["MenuF5 by nesky311"].b, { name = "Administration", ask = ">", askX = true})   -- change trigger line 312 or implement your admin menu            
                end
                nesky4 = false
            end
            CreateMenu(ftest)
        end  
    end
end)

