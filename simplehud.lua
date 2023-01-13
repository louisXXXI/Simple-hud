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


local textColorConVar = CreateClientConVar("speed_color", "255 255 255", true, false)

cvars.AddChangeCallback("speed_color", function()
    
    local textColor = textColorConVar:GetString()
    
    local r, g, b = string.match(textColor, "(%d+) (%d+) (%d+)")
    
    r = tonumber(r)
    g = tonumber(g)
    b = tonumber(b)
    
    speedLabel:SetColor(Color(r, g, b))
end)


local textColorConVar = CreateClientConVar("health_color", "255 255 255", true, false)

cvars.AddChangeCallback("health_color", function()
    
    local textColor = textColorConVar:GetString()
    
    local r, g, b = string.match(textColor, "(%d+) (%d+) (%d+)")
    
    r = tonumber(r)
    g = tonumber(g)
    b = tonumber(b)
    
    healthLabel:SetColor(Color(r, g, b))
end)

local textColorConVar = CreateClientConVar("armor_color", "255 255 255", true, false)

cvars.AddChangeCallback("armor_color", function()
    
    local textColor = textColorConVar:GetString()
    
    local r, g, b = string.match(textColor, "(%d+) (%d+) (%d+)")
    
    r = tonumber(r)
    g = tonumber(g)
    b = tonumber(b)
    
    armorLabel:SetColor(Color(r, g, b))
end)

local textColorConVar = CreateClientConVar("ammo_color", "255 255 255", true, false)

cvars.AddChangeCallback("ammo_color", function()
    
    local textColor = textColorConVar:GetString()

    local r, g, b = string.match(textColor, "(%d+) (%d+) (%d+)")
    
    r = tonumber(r)
    g = tonumber(g)
    b = tonumber(b)
    
    ammoLabel:SetColor(Color(r, g, b))
end)

local positionConVar = CreateClientConVar("hud_position", "0 0", true, false)

cvars.AddChangeCallback("hud_position", function()
    local position = positionConVar:GetString()
    
    local x, y = string.match(position, "(%-?%d+) (%-?%d+)")
    
    x = tonumber(x)
    y = tonumber(y)
    
    hud:SetPos(x, y)
end)


local opacityConVar = CreateClientConVar("hud_opacity", "255", true, false)

cvars.AddChangeCallback("hud_opacity", function()
    local opacity = opacityConVar:GetInt()
    hud:SetAlpha(opacity)
end)

local colorConVar = CreateClientConVar("hud_color", "31 31 31", true, false)

cvars.AddChangeCallback("hud_color", function()
    local color = colorConVar:GetString()
    
    local r, g, b = string.match(color, "(%d+) (%d+) (%d+)")
    
    r = tonumber(r)
    g = tonumber(g)
    b = tonumber(b)
    
    hud:SetBackgroundColor(Color(r, g, b))
end)


// remove hud when the player die
hook.Add("Think", "hidePanelOnDeath", function()
    if (LocalPlayer():Alive() == false) then
        hud:SetVisible(false)
    else
        hud:SetVisible(true)
    end
end)

// remove default hud elements
hook.Add("HUDShouldDraw", "HideDefaultHUD", function(name)
    local hide = {
       ["CHudHealth"] = true,
       ["CHudBattery"] = true,
       ["CHudAmmo"] = true,
       ["CHudSecondaryAmmo"] = true
    }
    return not hide[name]
  end)

  // reset hud color and position
  local function reset_hud()
    RunConsoleCommand( "health_color", "255 255 255" )
    RunConsoleCommand( "armor_color", "255 255 255" )
    RunConsoleCommand( "speed_color", "255 255 255" )
    RunConsoleCommand( "ammo_color", "255 255 255" )
    RunConsoleCommand( "hud_color", "31 31 31" )
    RunConsoleCommand( "hud_opacity", "255" )
    RunConsoleCommand( "hud_position", "10 10" )
end

concommand.Add( "reset", reset_hud_color )




