print('Setup loading. Heap: ' .. node.heap() .. 'b')
local httptiny = require('httptiny')

local setupWifi = require('setupWifi')
local savedOK = {}

setupWifi.setupWifi()

srv=net.createServer(net.TCP)
srv:listen(80,function(conn)
    conn:on("receive",function(conn,payload)
        print("Connection opened.")
        local args = {}
        local setupHtml = require('setupHtml')
        local saveConfig = require('saveConfig')
        local uri = httptiny.parseRequest(payload).uri
        args = httptiny.parseUriArgs(uri)
        print("uri="..uri)

        if args.mode == 'config' then
            if args.action == 'save' and args.ap ~= nil and args.pw ~=nil then
                local config = {ap = args.ap, pw = args.pw }
                print("config:save")

                savedOK = saveConfig.saveConfig(config)
                if savedOK then
                    print("savedOK")
                    conn:send(table.concat(setupHtml.configSaved(config),"\n"))

                else
                    print("saved Not OK")
                    conn:send(table.concat(setupHtml.error("Can't save config"),"\n"))
                end
            else
                conn:send(table.concat(setupHtml.error("unknown action."),"\n"))
            end

        elseif args.mode == 'node' then
            if args.action == 'restart' then
                print("node:restart")
                print("mode="..args.mode)
                conn:send(table.concat(setupHtml.redirect("http://www.google.com/"),"\n"))
                -- TODO: Add this action to a normal mode, so it will show something after restart
                node.restart()
            else
                conn:send(table.concat(setupHtml.error("unknown action."),"\n"))
            end
        else
            conn:send(table.concat(setupHtml.configPage,"\n"))
        end
    end)

    conn:on("sent",function(conn, s)
        print("Connection closed.")
        conn:close()
    end)
end)


print('Setup loaded. Heap: ' .. node.heap() .. 'b')