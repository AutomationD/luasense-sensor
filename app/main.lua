-- uart.setup(0,115200,8,0,1)
--require 'cli'
--status()
--f = assert(loadfile('config.lua'))
if file.open('config.lua') == nil and file.open('config.lc') == nil then
    require 'setup'
else
--    file.close() -- close handle after testing file
    require 'config'
    wifi.setmode(wifi.STATION)
    print("configuring with "..config.wifi.ap.." & "..config.wifi.pw)
    wifi.sta.config(config.wifi.ap,config.wifi.pw)
    wifi.sta.connect()
    tmr.alarm(0,1000, 1, function ()
        local currentIp = wifi.sta.getip()
        if currentIp==nil then
            -- Keep trying
        else
            -- Connected
            tmr.stop(0)
        end
    end)
end
------------------
------------------
function run ()
    require 'app'
end