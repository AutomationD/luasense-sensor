print('heap: ' .. node.heap() .. 'b')
local ap_config = {
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
---
print('testtest')
wifi.ap.config(ap_config.wifi)
wifi.ap.setip(ap_config.network)

wifi.setmode(wifi.SOFTAP)

print('AP ip: '..ap_config.network.ip)
srv=net.createServer(net.TCP)
local httptiny = require('httptiny')
local savedOK = false
srv:listen(80,function(conn)
    conn:on("receive",function(conn,payload)
        local content = ''
        local uri = httptiny.parseRequest(payload).uri
        local args = httptiny.parseUriArgs(uri)        
        if args.mode == 'config' and args.action == 'save' and args.ap ~= nil and args.pw ~=nil then
            local config = {ap = args.ap, pw = args.pw}
            if saveConfig(config) then
                savedOK = true
            end
            content = "<h1> Hello, NodeMcu.</h1>"
                    .."<BR />"..args.pw
            if savedOk then
                content = content .. "saved"
            end
            conn:send(content)
        else
            conn:send("HTTP/1.1 503 Error")
        end
        
    end)
    conn:on("sent",function(conn)
        conn:close()
        if savedOK then
            srv:close()
        end
    end)
    
end)



------------
------------
function saveConfig(config)
    file.open("config.lua", "w+")
    file.write('config = {')
    file.write("ap = '"..config.ap.."', ")
    file.write("pw = '"..config.pw.."'")
    file.write('}')
    file.flush()
    file.close()
end


print('heap: ' .. node.heap() .. 'b')