Citizen.CreateThread(function()
    if Config.Ped then 
        for _,v in pairs(Config.Npc) do
            RequestModel(v[7])
            while not HasModelLoaded(v[7]) do
                Wait(1)
            end

            ped =  CreatePed(4, v[7],v[1],v[2],v[3]-1, 3374176, false, true)
            SetEntityHeading(ped, v[5])
            FreezeEntityPosition(ped, true)
            SetEntityInvincible(ped, true)

            SetBlockingOfNonTemporaryEvents(ped, true)
        end
        
        for k, verarbeiter in pairs(Config.verarbeiter) do
            if verarbeiter.blip.enabled then
                local blip = AddBlipForCoord(verarbeiter.coords)
                SetBlipSprite(blip, verarbeiter.blip.sprite)
                SetBlipScale(blip, verarbeiter.blip.scale)
                SetBlipColour(blip, verarbeiter.blip.color)
                SetBlipDisplay(blip, verarbeiter.blip.display)
                SetBlipAsShortRange(blip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(verarbeiter.blip.text)
                EndTextCommandSetBlipName(blip)
            end
        end
    end
end)





function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end

notification = false
verarbeiter = false

Citizen.CreateThread(function()
    while true do
        local sleep = 250
        local ped = PlayerPedId()
        local pc = GetEntityCoords(ped)
       
        for k, v in pairs(Config.verarbeiter) do 
            local distance = #(pc - v.coords)
            if distance <= 1 then 
                sleep = 0
                if not notification then 
                    notification = true
                    ESX.ShowHelpNotification('Drücke ~g~E~w~, um zu Verarbeiten')
                end
                if IsControlJustReleased(0, 38) and IsPedOnFoot(PlayerPedId()) then
                    ESX.TriggerServerCallback('fabian_verarbeiter:check', function(cb)
                        if cb then
                            if not IsFullInventory() then -- Check if the inventory is full
                                verarbeiter = true
                                itembekommensoll = v.itemverarbeitet
                                itemcheck = v.item
                                loadAnimDict('mini@repair')
                    
                                TaskPlayAnim(PlayerPedId(), 'mini@repair', 'fixing_a_ped', 8.0, -8.0, -1, 1, 1.0, false, false, false)
                            else
                                TriggerEvent('nimmersatt:notify', 2, 'ERROR', 'Dein Rucksack ist voll!!', 5000)
                                notification = false
                                ClearPedTasks(ped) 
                            end
                        else
                            TriggerEvent('nimmersatt:notify', 2, 'ERROR', 'Du hast nicht genug Materialien', 5000)
                            notification = false
                            ClearPedTasks(ped) 
                        end
                    end, v.item)
                elseif IsControlJustPressed(0 , 73) then 
                    verarbeiter = false
                    ClearPedTasks(ped)
                end
            else
                notification = false
            end
        end
        Wait(sleep)
    end
end)

function IsFullInventory()
    local playerInventory = ESX.GetPlayerData().inventory
    local inventorySlots = ESX.GetPlayerData().maxWeight
    local currentWeight = 0
    
    for i=1, #playerInventory, 1 do
        if playerInventory[i].count > 0 then
            currentWeight = currentWeight + (playerInventory[i].weight * playerInventory[i].count)
        end
    end
    
    return currentWeight >= inventorySlots
end


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if verarbeiter then
            DisableControlAction(0, 140, true)
            DisableControlAction(0, 2, true) 
            DisableControlAction(0, 263, true) 
            DisableControlAction(0, 45, true) 
            DisableControlAction(0, 22, true) 
            DisableControlAction(0, 44, true) 
            DisableControlAction(0, 37, true) 
            DisableControlAction(0, 288, true) 
            DisableControlAction(0, 289, true) 
            DisableControlAction(0, 170, true) 
            DisableControlAction(0, 167, true) 
            DisableControlAction(1, 254, true)
            DisableControlAction(0, 47, true)  
            DisableControlAction(0, 20, true) 
            DisableControlAction(0, 170, true)  
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(2000)
        if verarbeiter then
            ESX.TriggerServerCallback('fabian_verarbeiter:check', function(cb)
                if cb then
                    TriggerServerEvent('fabian_verarbeiter:check', itembekommensoll, itemcheck)
                else
                    TriggerEvent('nimmersatt:notify', 2, 'ERROR', 'Du hast nicht genug Materialien', 5000)
                    ClearPedTasks(PlayerPedId())
                    verarbeiter = false
                end
            end, itemcheck)
        end
    end
end)
