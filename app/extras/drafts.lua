--
-- User: kireevco
-- Date: 2/22/15
-- Time: 1:15 AM
-- To change this template use File | Settings | File Templates.
--

--    uart.write(0,"GET DATA\n")
--
--    uart.on("data", "}",
--      function(json)
--        d = fromJson(json)
--        if (d ~= nil) then
--          -- Assign value to data & exit event
--          data = d
--          uart.on("data")
--        else
--          -- Assign a nil value to data & exit event
--          data = nil
--          uart.on("data")
--        end
--        sendResponse(conn, headers, data)
--      end, 0)

function getDHT11(PIN)
    local data = {}
    local dht11 = require('dht11')
    dht11.read(0)
    data.humidity = dht11.getHumidity()
    data.temperatue_c = dht11.getTemperature()
    data.temperatuedec = dht11.getTemperatureDec()

    data.temperatue_f = (data.temperatue_c*9/5+32)

    print("Humidity:    "..data.humidity.."%")
    print("Temperature: "..data.temperatue_c.." deg C")
    print("Temperature: "..data.temperatue_f.." deg F")

    print("TemperatureDec: "..data.temperatue_f.." deg F")


    --    release module
    --    dht11 = nil
    --    package.loaded["dht11"]=nil

    return data
end

--        local req = httptiny.parseRequest(payload)
--        print(payload) print(node.heap())
--        local args = httptiny.parseUriArgs(req.uri).args
--        print(args)
--        local content = "<h1> Hello, NodeMcu.</h1> <BR />ap="..args.ap..", pw="..args.pw
--        local content = "<h1> Hello, NodeMcu.</h1>"


