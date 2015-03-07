-- ***************************************************************************
-- DHT11 module for ESP8266 with nodeMCU
--
-- Originally Written by Javier Yanez
-- Current version modified by Dmitry Kireev
-- Based on a script of Pigs Fly from ESP8266.com forum
--
-- MIT license, http://opensource.org/licenses/MIT
-- ***************************************************************************

local moduleName = ...

local M = {}
_G[moduleName] = M


function M.getData(pin)
    local data = {}
    local humidity = 0
    local temperature = 0
    local checksum = 0
    local checksumTest

    -- Use Markus Gritsch trick to speed up read/write on GPIO
    local gpio_read = gpio.read
    local gpio_write=gpio.write
    
    local bitStream = {}
    for j = 1, 40, 1 do
        bitStream[j] = 0
    end
    local bitlength = 0

    gpio.mode(pin, gpio.OUTPUT)
    gpio_write(pin, gpio.LOW)
    tmr.delay(20000)
    gpio.mode(pin, gpio.INPUT)

    -- Step 2:  DHT11 send response signal
    --bus will always let up eventually, don't bother with timeout
    while (gpio_read(pin) == 0 ) do end
    local c=0
    while (gpio_read(pin) == 1 and c < 500) do c = c + 1 end
    -- bus will always let up eventually, don't bother with timeout
    while (gpio_read(pin) == 0 ) do end
    c=0
    while (gpio_read(pin) == 1 and c < 500) do c = c + 1 end

    -- Step 3: DHT11 send data
    for j = 1, 40, 1 do
        while (gpio_read(pin) == 1 and bitlength < 10 ) do
            bitlength = bitlength + 1
        end
        bitStream[j] = bitlength
        bitlength = 0
        -- bus will always let up eventually, don't bother with timeout
        while (gpio_read(pin) == 0) do end
    end
    
    --DHT data acquired, process.
    for i = 1, 8, 1 do
        if (bitStream[i+0] > 2) then
            humidity = humidity+2^(8-i)
        end
    end
    for i = 1, 8, 1 do
        if (bitStream[i+16] > 2) then
            temperature = temperature+2^(8-i)
        end
    end
    for i = 1, 8, 1 do
        if (bitStream[i+32] > 2) then
            checksum = checksum+2^(8-i)
        end
    end

--    checksumTest=(humidity+temperature) % 0xFF

    data.temperature = (temperature)
    data.humidity = (humidity)
    return data
    
end
return M