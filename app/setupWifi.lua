-- Executes when Luasense receives request in setup mode
local moduleName = ...
local M = {}
_G[moduleName] = M

local humidity
local temperature
local checksum
local checksumTest

M.ap_config = {
    wifi = {
        ssid="Luasense",
        pwd="Luasense"
    },
    network = {
        ip="192.168.1.1",
        netmask ="255.255.255.0",
        gateway="192.168.1.1"
    }
}

function M.setupWifi ()
    wifi.ap.config(M.ap_config.wifi)
    wifi.ap.setip(M.ap_config.network)
    wifi.setmode(wifi.SOFTAP)
    print('AP ip: '..M.ap_config.network.ip)
    return true
end

return M