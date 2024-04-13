ESX.RegisterServerCallback('fabian_verarbeiter:check', function(src, cb, item)
    local xPlayer = ESX.GetPlayerFromId(src)
    local item = xPlayer.hasItem(item)
    if item then 
        cb(true)
    else
        cb(false)
    end
end)


RegisterServerEvent("fabian_verarbeiter:check")
AddEventHandler("fabian_verarbeiter:check", function(item2, itemm)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local item = xPlayer.getInventoryItem(itemm).count

    if xPlayer.canCarryItem(itemm, 1) then 
        if item >= 1 then

            xPlayer.removeInventoryItem(itemm, 1)
            xPlayer.addInventoryItem(item2, 1)
        else
           xPlayer.showNotification('Du hast das Item nicht dabei')
        end
    else
        xPlayer.showNotification('Du hast max Limit von dein Inventar erreicht')
    end
    
end)  