-- uart.setup(0,115200,8,0,1)
print('init.lua ver 1.2')
wifi.setmode(wifi.STATION)

print('MAC: ',wifi.sta.getmac())
print('chip: ',node.chipid())
print('heap: ',node.heap())

dofile('config.lua')

print('set mode=STATION (mode='..wifi.getmode()..')')

wifi.sta.config(config.ap,config.pw)
-- wifi config end

tmr.alarm(0,1000, 1, function ()
     if wifi.sta.getip()==nil then
          print("Waiting for IP...")
     else 
          currentIp=wifi.sta.getip()
          print("IP: "..currentIp)
          tmr.stop(0)
     end
end)

------------------
------------------

function run ()
  dofile("app.lua")
end

function restart ()
  node.restart()
end