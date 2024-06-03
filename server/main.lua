VORP = exports.vorp_inventory:vorp_inventoryApi()

-- item for short weapon
Citizen.CreateThread(function()
	Citizen.Wait(2000)
	for k,v in pairs(Config.items) do
		print("Succesfully added ",Config.items[k].dbname," item")
		VORP.RegisterUsableItem(Config.items[k].dbname, function(data)
			local _source = source
			TriggerClientEvent('cleaning:startcleaningshort', data.source, cleaning)
			VORP.subItem(data.source,Config.items[k].dbname, 1)
		end)
	end
end)