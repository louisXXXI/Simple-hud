surface.CreateFont( "yes", {
	font = "Arial", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = true,
	size = 13,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = false,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false ,
	outline = true,
} )


local hud = vgui.Create("DPanel")
hud:SetPos(10, 10)
hud:SetSize(200, 25) 
hud:SetBackgroundColor(Color(31, 31, 31)) 




local speedLabel = vgui.Create("DLabel", hud)
speedLabel:SetPos(125, 5)
speedLabel:SetSize(100, 20) 
speedLabel:SetFont("yes") 
speedLabel:SetColor(Color(255, 255, 255)) 
speedLabel:SetText("0 velocity") 

local healthLabel = vgui.Create("DLabel", hud)
healthLabel:SetPos(10,5) 
healthLabel:SetSize(100, 20)
healthLabel:SetFont("yes") 
healthLabel:SetColor(Color(255, 255, 255)) 
healthLabel:SetText("100hp") 

local armorLabel = vgui.Create("DLabel", hud)
armorLabel:SetPos(50, 5) 
armorLabel:SetSize(100, 20)
armorLabel:SetFont("yes") 
armorLabel:SetColor(Color(255, 255, 255)) 
armorLabel:SetText("0%") 

local ammoLabel = vgui.Create("DLabel", hud)
ammoLabel:SetPos(100, 5) 
ammoLabel:SetSize(100, 20)
ammoLabel:SetFont("yes") 
ammoLabel:SetColor(Color(255, 255, 255)) 
ammoLabel:SetText("0") 

function updateSpeedometer()
    local speed = LocalPlayer():GetVelocity():Length()
    speedLabel:SetText(string.format("%d velocity", speed))
end

hook.Add("Think", "updateSpeedometer", updateSpeedometer)

function updateHealthBar()
  local health = LocalPlayer():Health()
  healthLabel:SetText(string.format("%dhp", health))
end

hook.Add("Think", "updateHealthBar", updateHealthBar)

function updateArmorBar()
  local armor = LocalPlayer():Armor()
  armorLabel:SetText(string.format("%darmor", armor))
end

hook.Add("Think", "updateArmorBar", updateArmorBar)

function updateAmmoBar()

  local weapon = LocalPlayer():GetActiveWeapon()
  
  if (IsValid(weapon)) then

      local ammo = weapon:Clip1()
      
      ammoLabel:SetText(tostring(ammo))
  else
      ammoLabel:SetText("N/A")
  end
end

hook.Add("Think", "updateAmmoBar", updateAmmoBar)


hook.Add("HUDShouldDraw", "HideDefaultHUD", function(name)
  local hide = {
     ["CHudHealth"] = true,
     ["CHudBattery"] = true,
     ["CHudAmmo"] = true,
     ["CHudSecondaryAmmo"] = true
  }
  return not hide[name]
end)
