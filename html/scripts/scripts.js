window.addEventListener('message', function(znx_event) {
    switch (znx_event.data.action) {
        case 'znx_hud_status':

            $('#znx_health').html(`<stop offset="` + znx_event.data.znx_data.znx_health + `%" style="stop-color: var(--znx_szef);stop-opacity:1" /><stop offset="` + znx_event.data.znx_data.znx_health + `%" style="stop-color:rgb(255, 255, 255);stop-opacity:1"/>`)
            
            if (znx_event.data.znx_data.armour > 0) {
                $('#znx_armor_item').css('display', 'flex')
                $('#znx_armor').html(`<stop offset="` + znx_event.data.znx_data.znx_armor + `%" style="stop-color: var(--znx_szef);stop-opacity:1" /><stop offset="` + znx_event.data.znx_data.znx_armor + `%" style="stop-color:rgb(255, 255, 255);stop-opacity:1"/>`)
            }
            
            else {
                $('#znx_armor_item').css('display', 'none')
            }
        break;

        case 'znx_hud_voice':
            if (znx_event.data.znx_data.znx_volume == 'Whisper' && znx_event.data.znx_data.znx_state == false) {
                $('#znx_voice').html(`<stop offset="25%" style="stop-color: var(--znx_szef);stop-opacity:1" /><stop offset="25%" style="stop-color:rgb(255, 255, 255);stop-opacity:1"/>`)
            }

            else if (znx_event.data.znx_data.znx_volume == 'Normal' && znx_event.data.znx_data.znx_state == false) {
                $('#znx_voice').html(`<stop offset="50%" style="stop-color: var(--znx_szef);stop-opacity:1" /><stop offset="50%" style="stop-color:rgb(255, 255, 255);stop-opacity:1"/>`)
            }

            else if (znx_event.data.znx_data.znx_volume == 'Shouting' && znx_event.data.znx_data.znx_state == false) {
                $('#znx_voice').html(`<stop offset="100%" style="stop-color: var(--znx_szef);stop-opacity:1" /><stop offset="100%" style="stop-color:rgb(255, 255, 255);stop-opacity:1"/>`)
            }
        break;

        case 'znx_on_carhud':
            $('#znx_car_hud').css({'display': `flex`})

            let znx_speeds = Math.round(znx_event.data.znx_data.znx_speed).toString()
            let znx_rpm_percent = Math.min(Math.round((znx_event.data.znx_data.znx_rpm / 10000) * 100), 100);

            $("#znx_speed").html(znx_speeds.padStart(3, '0') + '<span> KMH</span>')
            $("#znx_street").html(znx_event.data.znx_data.znx_street_name)

            $("#znx_speed_2").css({'width': `${znx_rpm_percent}%`})
        break;

        case 'znx_off_carhud':
            $('#znx_car_hud').css({'display': `none`})
        break;

        case 'znx_off_hud':
            $('#znx_hud_container').css({'display': `none`})
        break;

        case 'znx_on_hud':
            $('#znx_hud_container').css({'display': `block`})
        break;
    }
})