local znx = {}
local znx_show = true

znx.carhud = function()
    local znx_player_id = PlayerPedId()

    if IsPedInAnyVehicle(znx_player_id) and znx_show then
        local znx_vehicle = GetVehiclePedIsUsing(znx_player_id)
        local znx_speed = (GetEntitySpeed(znx_vehicle) * 2.6)
        local znx_rpm = GetVehicleCurrentRpm(znx_vehicle) * 10000
        local znx_coord = GetEntityCoords(znx_vehicle)
        local znx_var = GetStreetNameAtCoord(znx_coord.x, znx_coord.y, znx_coord.z)
        local znx_street_name = GetStreetNameFromHashKey(znx_var)
        local znx_data = { znx_speed = znx_speed, znx_rpm = znx_rpm, znx_street_name = znx_street_name }
        
        SendNUIMessage({ action = 'znx_on_carhud', znx_data = znx_data })
        DisplayRadar(true)
    else
        SendNUIMessage({ action = 'znx_off_carhud' })
        DisplayRadar(false)
    end
end

znx.hud = function()
    AddTextEntry('FE_THDR_GTAO', Zenix.TextEntry)
    ReplaceHudColourWithRgba(142, 3, 150, 252, 255)

    while true do        
        Wait(100)

        if IsPauseMenuActive() then
            if znx_show then
                znx_show = false

                SendNUIMessage({ action = 'znx_off_hud' })
            end
        else
            if not znx_show then
                znx_show = true

                SendNUIMessage({ action = 'znx_on_hud' })
            end
        end
        
        local znx_player = PlayerId()
        local znx_player_id = PlayerPedId()
        local znx_state = NetworkIsPlayerTalking(znx_player)
        local znx_health = GetEntityHealth(znx_player_id) - 100
        local znx_armor = GetPedArmour(znx_player_id)
        local znx_data = { znx_health = znx_health, znx_voice = znx_voice, znx_armor = znx_armor }

        SendNUIMessage({ action = 'znx_hud_status', znx_data = znx_data, znx_state = true })
        SendNUIMessage({ action = 'znx_hud_voice', znx_data = { znx_volume = 'LocalPlayer.state.proximity.mode', znx_state = znx_state }})

        znx.carhud()
    end
end

znx.hud()

znx.fixmap = function()
	SetMapZoomDataLevel(0, 0.96, 0.9, 0.08, 0.0, 0.0)
    SetMapZoomDataLevel(1, 1.6, 0.9, 0.08, 0.0, 0.0)
    SetMapZoomDataLevel(2, 8.6, 0.9, 0.08, 0.0, 0.0)
    SetMapZoomDataLevel(3, 12.3, 0.9, 0.08, 0.0, 0.0)
	SetMapZoomDataLevel(4, 22.3, 0.9, 0.08, 0.0, 0.0)
	
    while true do
		Wait(1000)
        
		if IsPedOnFoot(GetPlayerPed(-1)) then 
			SetRadarZoom(1100)
		elseif IsPedInAnyVehicle(GetPlayerPed(-1), true) then
			SetRadarZoom(1100)
		end
    end
end

znx.fixmap()