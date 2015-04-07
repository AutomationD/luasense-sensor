local moduleName = ...
local M = {}
_G[moduleName] = M

local humidity
local temperature
local checksum
local checksumTest

function M.saveConfig(config)
    file.open("config.lua", "w+")
    file.write('config = {')
        file.write('wifi = {')
            file.write("ap = '"..config.ap.."', ")
            file.write("pw = '"..config.pw.."'")
        file.write('}')
    file.write('}')
    file.flush()
    file.close()
    if file.open('config.lua') == nil and file.open('config.lc') == nil then
        return false
    else
        return true
    end
end

return M