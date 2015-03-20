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
    print('Luasense ver 0.0.3')
    print('chip: ' .. node.chipid())
    print('heap: ' .. node.heap() .. 'b')
    print('flashid: ' .. node.flashid())
    print('power: ' .. node.readvdd33() .. 'mV')

    if wifi.getmode() == 1 then --if Station mode
        local wifi_sta=wifi.sta
        print('mode: STATION')
        print('MAC: ' .. wifi_sta.getmac())

        if wifi.sta.getip() ~= nil then
            print('AP connected: ' .. wifi_sta.getap())
            print('ip: '.. wifi_sta.getip())
            print('broadcast: ' .. wifi_sta.getbroadcast())            
            print('status: ' .. wifi_sta.status())
        else
            print('ip: n/a')
            print('broadcast: n/a')
        end
    elseif wifi.getmode() == 2 then --if AP mode
        local wifi_ap=wifi.ap
        print('mode: AP')
        print('MAC: ' .. wifi_ap.getmac())
        print('ip: '.. wifi_ap.getip())
--        print('broadcast: ' .. wifi.ap.getbroadcast)
    end
end