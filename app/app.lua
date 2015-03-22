function test()
    m=mqtt.Client(config.mqtt.client_id, 120, config.mqtt.username, config.mqtt.password)
    m:connect(config.mqtt.host,config.mqtt.port,0)
    m:publish(config.mqtt.topic,"hello 1232",0,0)
end


function send()
    m:connect(config.mqtt.host, config.mqtt.port, 0,function(conn)
        print("Connected to MQTT: " .. config.mqtt.host .. ":" .. config.mqtt.port .." as " .. config.mqtt.client_id )
        m:publish(config.mqtt.topic, "testing here",0,0, function(conn)
            print ("temp published".."testing here" .. ' to ' .. config.mqtt.topic)
        end)
    end)
end


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