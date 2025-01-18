local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Robojini/Tuturial_UI_Library/main/UI_Template_1"))()
local Window = Library.CreateLib("8360 script", "RJTheme1")
local Tab = Window:NewTab("main")

-- Ragdoll Section
local Section1 = Tab:NewSection("mods")
Section1:NewButton("Anti Ragdoll", "выключает ragdoll", function()
game:GetService("ReplicatedStorage").LocalRagdollEvent:Destroy()
local player = game.Players.LocalPlayer

local function killCharacter()
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:FindFirstChild("Humanoid")
    if humanoid then
        humanoid.Health = 0
        print("Персонаж убит.")
    else
        print("Humanoid не найден.")
    end
end

-- Если персонаж уже загружен, убить его сразу
if player.Character then
    killCharacter()
end
end)


-- Delete Portals Section
Section1:NewButton("Delete all portals", "Удаляет все порталы", function()
    local portals = {
        workspace.Portals:FindFirstChild("PyaterochkaPortal"),
        workspace.Portals:FindFirstChild("Samokat_RussiaChat"),
        workspace.Portals:FindFirstChild("Dixy_RussiaChat"),
        workspace.Portals:FindFirstChild("Portal")
    }

    for _, portal in pairs(portals) do
        if portal and portal:FindFirstChild("Teleport") then
            portal.Teleport:Destroy()
            print("Удалён Teleport в портале:", portal.Name)
        else
            warn("Teleport не найден в портале или портал отсутствует:", portal and portal.Name or "Unknown")
        end
    end
end)

local Tab = Window:NewTab("misc")
local Section1 = Tab:NewSection("jerk")
Section1:NewButton("jerking", "jerk", function()
loadstring(game:HttpGet("https://pastefy.app/YZoglOyJ/raw"))()
end)
local Section1 = Tab:NewSection("infinite yield")
Section1:NewButton("infinite yield", "infinite yield", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
end)
local Section1 = Tab:NewSection("orca hub")
Section1:NewButton("orca hub", "orca hub", function()
loadstring(game:HttpGetAsync('https://raw.githubusercontent.com/richie0866/orca/master/public/latest.lua'))()
end)
local Section1 = Tab:NewSection("canon")
Section1:NewButton("canon", "canon", function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/GhostPlayer352/Test4/main/Cannon%20Ball'))()
end)
local Section1 = Tab:NewSection("eazvy hub")
Section1:NewButton("eazvy hub", "eazvy hub", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Eazvy/public-scripts/main/Universal_Animations_Emotes.lua"))()
end)
local Section1 = Tab:NewSection("system broken")
Section1:NewButton("system broken", "system broken", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/H20CalibreYT/SystemBroken/main/script"))()
end)
