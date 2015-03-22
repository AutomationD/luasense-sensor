--json = require('json')
----httptiny = require('httptiny')
------
------headers = {
------    "HTTP/1.1 200 OK",
------    "Content-Type: application/json; charset=utf-8",
------    "Cache-Control: no-cache, no-store, must-revalidate",
------    "Pragma: no-cache",
------    "Expires: 0",
------}
------

--srv=net.createServer(net.TCP,function ()
--    print("Starting server")
--end,30)
--
--srv:listen(80,function(conn)
--    conn:on("receive",function(conn,payload)
--    sendResponse(conn, headers, getDHT(0))
--    end)
--    conn:on("sent",function(conn) conn:close() end)
--end)
dummy_data = {a=5,b=6 }

--m:connect( config.mqtt.host , config.mqtt.port, 0, function(conn) print('connected') end)
--m:publish(config.mqtt.topic, cjson.encode(dummy_data),0,0, function(conn) print('sent') end)
--m = mqtt.Client(config.mqtt.port.client_id, 120, config.mqtt.port.username, config.mqtt.port.password)

function test()
    m=mqtt.Client(config.mqtt.client_id, 120, config.mqtt.username, config.mqtt.password)
    m:connect(config.mqtt.host,config.mqtt.port,0)
    m:publish(config.mqtt.topic,"hello 1232",0,0)
end


function send()
    m:connect(config.mqtt.host, config.mqtt.port, 0,function(conn)
        print("Connected to MQTT: " .. config.mqtt.host .. ":" .. config.mqtt.port .." as " .. config.mqtt.client_id )
        tmr.alarm(2, 5000, 1, function(conn)
            m:publish(config.mqtt.topic, "testing here",0,0, function(conn)
                print ("temp published".."testing here" .. ' to ' .. config.mqtt.topic)
            end)
        end)


    end)
end
--
--m:on("offline", function(con)
--    print ("reconnecting...")s
--    print(node.heap())
--    tmr.alarm(1, 10000, 0, function()
--        m:connect( config.mqtt.host , config.mqtt.port, 0)
--    end)
--end)








--    m:on("connect", function(con)
--        print ("connected")
--
--    end)
--    m:on("offline", function(con) print ("offline") end)
--
--    -- on publish message receive event
--    m:on("message", function(conn, topic, data)
--        print(topic .. ":" )
--        if data ~= nil then
--            print(data)
--        end
--    end)
--
--    -- for secure: m:connect("192.168.11.118", 1880, 1)
--    print ("Configuring host: "..config.mqtt.host)
--
--    m:connect(config.mqtt.host, 1883, 0, function(conn)
--        print("connected")
--        print ("Subscribing to "..config.mqtt.topic)
--        -- subscribe topic with qos = 0
--        m:subscribe(config.mqtt.topic,0, function(conn) print("subscribe success") end)
--
--        print ("Publishing "..cjson.encode(dummy_data).. " to "..config.mqtt.topic)
--        -- publish a message with data = hello, QoS = 0, retain = 0
--        m:publish(config.mqtt.topic,cjson.encode(dummy_data),0,0, function(conn) print("sent") end)
--        m:close();
--    end)
--


    -- you can call m:connect again




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


--
--function sendResponse (conn,headers,data)
--    for key,header in pairs(headers) do
--        conn:send(header.."\r\n")
--        if (key == table.getn(headers)) then
--            conn:send("Connection: close\r\n\r\n")
--        end
--    end
--    if (data ~= nil) then
--        conn:send(json.toJson(data))
--    else
--        conn:send("HTTP/1.1 503 Error")
--    end
--end
