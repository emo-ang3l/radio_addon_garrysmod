-- Перехват обычного чата, если PTT включён
hook.Add("PlayerSay", "Radio_Chat", function(ply, text, team)
    local wep = ply:GetActiveWeapon()
    if not IsValid(wep) or wep:GetClass() ~= "weapon_radio" then return end

    if wep:GetPTT() then
        local channel = wep:GetChannel()

        -- Отправляем сообщение всем на этом канале
        for _, p in ipairs(player.GetAll()) do
            if p == ply then
                p:ChatPrint("[РАДИО " .. channel .. "] Ты: " .. text)
            elseif p:GetActiveWeapon():GetClass() == "weapon_radio" and p:GetActiveWeapon():GetChannel() == channel then
                p:ChatPrint("[РАДИО " .. channel .. "] " .. ply:Nick() .. ": " .. text)
            end
        end

        return ""  -- блокируем обычный чат
    end
end)