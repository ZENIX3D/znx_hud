local znx = {}
local znx_show = true

znx.CarHud = function()
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

znx.Hud = function()
    if Zenix.TextEntryEnable == true then
        AddTextEntry('FE_THDR_GTAO', Zenix.TextEntry)
    end

    ReplaceHudColourWithRgba(142, 3, 150, 252, 255)

    while true do        
        Wait(100)

        TriggerEvent('esx_status:getStatus', 'hunger', function(status)
            znx_hunger = status.getPercent()
        end)

        TriggerEvent('esx_status:getStatus', 'thirst', function(status)
            znx_thirst = status.getPercent()
        end)
        
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
        local znx_data = { znx_health = znx_health, znx_voice = znx_voice, znx_armor = znx_armor, znx_hunger = znx_hunger, znx_thirst = znx_thirst }

        SendNUIMessage({ action = 'znx_hud_status', znx_data = znx_data, znx_state = true })
        SendNUIMessage({ action = 'znx_hud_voice', znx_data = { znx_volume = LocalPlayer.state.proximity.mode, znx_state = znx_state }})

        znx.CarHud()
    end
end

znx.Hud()
