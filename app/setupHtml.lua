-- Executes when Luasense receives request in setup mode
local moduleName = ...
local M = {}
_G[moduleName] = M

local humidity
local temperature
local checksum
local checksumTest

function M.configSaved (config)
    return {
        '<html>',
        '<head>',
        '<script language="javascript" type="text/javascript">',
        'function restart() {',
        'if(confirm("Restart?")) document.location = "/?mode=node&action=restart";',
        '}',
        '</script>',
        '</head>',
        '<h1>Config Saved:</h1>',
        '<BR />Access Point: '..config.ap,
        '<BR />Password: '..config.pw,
        '<BR /><a href="#" onclick="javascript:restart()">Reset device</a>',
        '</html>',
    }
end

function M.redirect(url)
    return {
        '<html>',
        '<head>',
        '<script language="javascript" type="text/javascript">',
        'document.location = "'..url .. '"',
        '</script>',
        '</head>',
        '</html>',
    }
end

function M.error(message)
    return {
        "Error: "..message,
    }
end

M.configPage = {
    '<h1>Luasense Setup</h1>',
    '<form method="get" action="/">',
    '<input type="text" name="ap" value="jaaba">',
    '<input type="text" name="pw" value="bratislava123">',
    '<input type="submit" value="submit">',
    '<input type="hidden" name="mode" value="config">',
    '<input type="hidden" name="action" value="save">',
    '</form>',
}

return M