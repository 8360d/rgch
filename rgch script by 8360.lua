local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Robojini/Tuturial_UI_Library/main/UI_Template_1"))()
local Window = Library.CreateLib("script by 8360", "RJTheme1")
local Tab = Window:NewTab("main")

-- Delete Portals Section
local Section3 = Tab:NewSection("Delete Portals")
Section3:NewButton("Delete all portals", "Удаляет все порталы", function()
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

local Section3 = Tab:NewSection("dex")
Section3:NewButton("dex", "dex", function()
loadstring(game:HttpGet("https://cdn.wearedevs.net/scripts/Dex%20Explorer.txt"))()
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
