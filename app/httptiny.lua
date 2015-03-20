-- httptiny
-- Minimalistic module to manage request, uri parsing
local moduleName = ...
local M = {}
_G[moduleName] = M
    function M.parseRequest(request)
        local e = request:find("\r\n", 1, true)
        if not e then return nil end
        local line = request:sub(1, e - 1)
        local r = {}
        _, i, r.method, r.uri = line:find("^([A-Z]+) (.-) HTTP/[1-9]+.[1-9]+$")
        return r
    end

    function M.parseUriArgs(uri)
        local r = {}
        for k,v in uri:gmatch('([^&=?]-)=([^&=?]+)' ) do
            r[ k ] = v
        end
        return r
    end
return M