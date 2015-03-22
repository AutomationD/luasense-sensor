function cat(file_name)
    file.open(file_name, "r")
    print(file.read())
    file.close()
end

function ls()
    for k,v in pairs(file.list()) do
        print("name:"..k..", size:"..v)
    end
end

function rm(file_name)
    file.remove(file_name)
    if file.open(file_name, "r") then
        print("Error. File still exists")
        file.close()
    end
end


function reboot()
    node.restart()
end

function status()
    print('Luasense ver 0.0.5')
    print('Chip: ' .. node.chipid())
    print('Heap: ' .. node.heap() .. 'b')
--    print('Flashid: ' .. node.flashid())
--    print('Power: ' .. node.readvdd33().. 'mV')


    if wifi.getmode() == 1 then --if Station mode
--        local wifi_sta=wifi.sta
        print('Mode: STATION')
        print('MAC: ' .. wifi.sta.getmac())

        if wifi.sta.getip() ~= nil then
            local ip,nm,gw = wifi.sta.getip()
            print('Ip: '.. ip )
            print('Netmask: '.. nm )
            print('Gateway: '.. gw )


            print('Broadcast: ' .. wifi.sta.getbroadcast())
            print('Station status: ' .. wifi.sta.status())
        else
            print('Ip: n/a')
            print('Broadcast: n/a')
        end
    elseif wifi.getmode() == 2 then --if AP mode
        local wifi_ap=wifi.ap
        print('Mode: AP')
        print('MAC: ' .. wifi_ap.getmac())
        print('Ip: '.. wifi_ap.getip())
--        print('broadcast: ' .. wifi.ap.getbroadcast)
    end
end