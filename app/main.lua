-- uart.setup(0,115200,8,0,1)
--require 'cli'
--status()
--f = assert(loadfile('config.lua'))
if file.open('config.lua') == nil then
    require 'setup'
else
    file.close() -- close handle after testing file
    require 'config'
    wifi.setmode(wifi.STATION)
    wifi.sta.config(config.ap,config.pw)
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
    dofile("app.lua")
end