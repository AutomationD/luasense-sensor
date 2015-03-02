-- This is a poor man json serializer. Tested with number values (int/float)
function fromJson(MSG)
    local hashMap = {}
    for k,v in string.gmatch(MSG,'"(%w+)":"?([%d%xexp.+-]+)"?,') do
        hashMap[k] = v;
    end

    for k,v in string.gmatch(MSG,'"(%w+)":"?([%d%xexp.+-]+)"?}') do
        hashMap[k] = v;
    end
    return hashMap
end

function toJson(MAP)
    local outMsg = "{"
    for k,v in pairs(MAP) do
        outMsg = outMsg..'"'..k..'":'..v..','
    end
    return string.sub(outMsg,0,-2)..'}'
end

