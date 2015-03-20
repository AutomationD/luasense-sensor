json = require('json')
httptiny = require('httptiny')

headers = {
    "HTTP/1.1 200 OK",
    "Content-Type: application/json; charset=utf-8",
    "Cache-Control: no-cache, no-store, must-revalidate",
    "Pragma: no-cache",
    "Expires: 0",
}


srv=net.createServer(net.TCP,function () 
    print("Starting server")
end,30)

srv:listen(80,function(conn)
    conn:on("receive",function(conn,payload)
    sendResponse(conn, headers, getDHT(0))
    end)
    conn:on("sent",function(conn) conn:close() end)
end)

function getDHT(pin)
--    local dht11 = require('dht11')
--    local data = dht11.getData(0)
    local data = {}
    local dht22 = require("dht22")
    dht22.read(pin)
    local t = dht22.getTemperature()
    local h = dht22.getHumidity()

    dht22 = nil
    package.loaded["dht22"]=nil
    data.temperature = t
    data.humidity = h
    return data
end



function sendResponse (conn,headers,data)
    for key,header in pairs(headers) do
        conn:send(header.."\r\n")
        if (key == table.getn(headers)) then
            conn:send("Connection: close\r\n\r\n")
        end
    end
    if (data ~= nil) then
        conn:send(json.toJson(data))
    else
        conn:send("HTTP/1.1 503 Error")
    end
end
