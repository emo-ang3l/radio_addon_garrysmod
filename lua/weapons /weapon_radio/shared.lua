SWEP.PrintName          = "Рация"
SWEP.Author             = "emo-ang3l"
SWEP.Instructions       = "ЛКМ — вкл/выкл PTT\nПКМ — сменить канал (1-10)"
SWEP.Category           = "Рации"

SWEP.Spawnable          = true
SWEP.AdminOnly          = false

SWEP.Primary.ClipSize   = -1
SWEP.Primary.DefaultClip= -1
SWEP.Primary.Automatic  = false
SWEP.Primary.Ammo       = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo     = "none"

SWEP.Weight             = 5
SWEP.AutoSwitchTo       = false
SWEP.AutoSwitchFrom     = false

SWEP.Slot               = 0
SWEP.SlotPos            = 4

SWEP.ViewModel          = "models/weapons/v_pistol.mdl"   -- можно поменять позже
SWEP.WorldModel         = "models/props_lab/reciever01a.mdl"  -- простая модель рации
SWEP.HoldType           = "slam"

SWEP.Channel            = 1     -- канал по умолчанию
SWEP.PTT                = false -- push-to-talk

if SERVER then
    AddCSLuaFile()
end

function SWEP:Initialize()
    self:SetHoldType(self.HoldType)
end

function SWEP:PrimaryAttack()  -- ЛКМ — toggle PTT
    if not IsFirstTimePredicted() then return end

    self.PTT = not self.PTT
    self:SetNextPrimaryFire(CurTime() + 0.3)

    if CLIENT then
        surface.PlaySound(self.PTT and "buttons/button9.wav" or "buttons/button8.wav")
    end
end

function SWEP:SecondaryAttack()  -- ПКМ — следующий канал
    if not IsFirstTimePredicted() then return end

    self.Channel = (self.Channel % 10) + 1
    self:SetNextSecondaryFire(CurTime() + 0.3)

    if CLIENT then
        surface.PlaySound("buttons/button15.wav")
    end
end

-- Передаём сетевые переменные клиенту
function SWEP:SetupDataTables()
    self:NetworkVar("Int", 0, "Channel")
    self:NetworkVar("Bool", 0, "PTT")
end