include("shared.lua")

-- HUD
local font = "DermaDefault"

hook.Add("HUDPaint", "Radio_HUD", function()
    local ply = LocalPlayer()
    local wep = ply:GetActiveWeapon()

    if not IsValid(wep) or wep:GetClass() ~= "weapon_radio" then return end

    local channel = wep:GetChannel()
    local ptt = wep:GetPTT()

    draw.SimpleTextOutlined(
        "Рация • Канал: " .. channel,
        font, 20, ScrH() - 100,
        color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM,
        1, color_black
    )

    draw.SimpleTextOutlined(
        ptt and "PTT: ВКЛ (говори в чат!)" or "PTT: ВЫКЛ",
        font, 20, ScrH() - 70,
        ptt and Color(50,255,50) or Color(255,80,80),
        TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM,
        1, color_black
    )
end)

-- Иконка в меню выбора оружия
function SWEP:DrawWeaponSelection(x, y, wide, tall, alpha)
    draw.SimpleText("Рация", "DermaLarge", x + wide/2, y + tall*0.3, Color(220,220,255,alpha), TEXT_ALIGN_CENTER)
    draw.SimpleText("Каналы 1-10", "DermaDefault", x + wide/2, y + tall*0.6, Color(180,180,255,alpha), TEXT_ALIGN_CENTER)
end