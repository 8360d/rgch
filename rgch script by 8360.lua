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

Section1:NewButton("particle fling", "particle fling", function()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")

local angle = 1
local radius = 10
local blackHoleActive = false
local cursorAttractionActive = false
local cursorPosition = Vector3.new()

local function getCursorPosition()
    local mouseLocation = UserInputService:GetMouseLocation()
    local camera = Workspace.CurrentCamera
    local ray = camera:ScreenPointToRay(mouseLocation.X, mouseLocation.Y)
    local raycastResult = Workspace:Raycast(ray.Origin, ray.Direction * 1000)
    if raycastResult then
        return raycastResult.Position
    else
        return ray.Origin + ray.Direction * 1000
    end
end

local function setupPlayer()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

    local Folder = Instance.new("Folder", Workspace)
    local Part = Instance.new("Part", Folder)
    local Attachment1 = Instance.new("Attachment", Part)
    Part.Anchored = true
    Part.CanCollide = false
    Part.Transparency = 1

    return humanoidRootPart, Attachment1
end

local humanoidRootPart, Attachment1 = setupPlayer()

if not getgenv().Network then
    getgenv().Network = {
        BaseParts = {},
        Velocity = Vector3.new(14.46262424, 14.46262424, 14.46262424)
    }

    Network.RetainPart = function(part)
        if typeof(part) == "Instance" and part:IsA("BasePart") and part:IsDescendantOf(Workspace) then
            table.insert(Network.BaseParts, part)
            part.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
            part.CanCollide = false
        end
    end

    local function EnablePartControl()
        LocalPlayer.ReplicationFocus = Workspace
        RunService.Heartbeat:Connect(function()
            sethiddenproperty(LocalPlayer, "SimulationRadius", math.huge)
            for _, part in pairs(Network.BaseParts) do
                if part:IsDescendantOf(Workspace) then
                    part.Velocity = Network.Velocity
                end
            end
        end)
    end

    EnablePartControl()
end

local function ForcePart(v)
    if v:IsA("Part") and not v.Anchored and not v.Parent:FindFirstChild("Humanoid") and not v.Parent:FindFirstChild("Head") and v.Name ~= "Handle" then
        for _, x in next, v:GetChildren() do
            if x:IsA("BodyAngularVelocity") or x:IsA("BodyForce") or x:IsA("BodyGyro") or x:IsA("BodyPosition") or x:IsA("BodyThrust") or x:IsA("BodyVelocity") or x:IsA("RocketPropulsion") then
                x:Destroy()
            end
        end
        if v:FindFirstChild("Attachment") then
            v:FindFirstChild("Attachment"):Destroy()
        end
        if v:FindFirstChild("AlignPosition") then
            v:FindFirstChild("AlignPosition"):Destroy()
        end
        if v:FindFirstChild("Torque") then
            v:FindFirstChild("Torque"):Destroy()
        end
        v.CanCollide = false

        local Torque = Instance.new("Torque", v)
        Torque.Torque = Vector3.new(1000000, 1000000, 1000000)
        local AlignPosition = Instance.new("AlignPosition", v)
        local Attachment2 = Instance.new("Attachment", v)
        Torque.Attachment0 = Attachment2
        AlignPosition.MaxForce = math.huge
        AlignPosition.MaxVelocity = math.huge
        AlignPosition.Responsiveness = 500
        AlignPosition.Attachment0 = Attachment2
        AlignPosition.Attachment1 = Attachment1
    end
end

local function toggleBlackHole()
    blackHoleActive = not blackHoleActive
    if blackHoleActive then
        for _, v in next, Workspace:GetDescendants() do
            ForcePart(v)
        end

        Workspace.DescendantAdded:Connect(function(v)
            if blackHoleActive then
                ForcePart(v)
            end
        end)

        spawn(function()
            while blackHoleActive and RunService.RenderStepped:Wait() do
                if cursorAttractionActive then
                    cursorPosition = getCursorPosition()
                    Attachment1.WorldCFrame = CFrame.new(cursorPosition)
                else
                    angle = angle + math.rad(2)
                    local offsetX = math.cos(angle) * radius
                    local offsetZ = math.sin(angle) * radius
                    Attachment1.WorldCFrame = humanoidRootPart.CFrame * CFrame.new(offsetX, 0, offsetZ)
                end
            end
        end)
    else
        Attachment1.WorldCFrame = CFrame.new(0, -1000, 0)
    end
end

LocalPlayer.CharacterAdded:Connect(function()
    humanoidRootPart, Attachment1 = setupPlayer()
    if blackHoleActive then
        toggleBlackHole()
    end
end)

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/miroeramaa/TurtleLib/main/TurtleUiLib.lua"))()
local window = library:Window("8360")

window:Slider("Radius Blackhole",1,100,10, function(Value)
   radius = Value
end)

window:Toggle("Blackhole", true, function(Value)
       if Value then
            toggleBlackHole()
        else
            blackHoleActive = false
        end
end)

window:Toggle("Cursor Attraction", false, function(Value)
    cursorAttractionActive = Value
end)

spawn(function()
    while true do
        RunService.RenderStepped:Wait()
    end
end)

toggleBlackHole()
end)


Section1:NewButton("spy", "spy", function()
enabled = true
--if true will xhexk your messages too
spyOnMyself = true
--if true will xhat the logs publikly (fun, risky)
public = false
--if true will use /me to stand out
publicItalics = false
--KUSTOMIZE private logs
privateProperties = {
Color = Color3.fromRGB(0,255,255); 
Font = Enum.Font.SourceSansBold;
TextSize = 18;
}
--////////////////////////////////////////////////////////////////
local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")
local player = Players.LocalPlayer or Players:GetPropertyChangedSignal("LocalPlayer"):Wait() or Players.LocalPlayer
local saymsg = game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest")
local getmsg = game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("OnMessageDoneFiltering")
local instance = (_G.chatSpyInstance or 0) + 1
_G.chatSpyInstance = instance

local function onChatted(p,msg)
if _G.chatSpyInstance == instance then
if p==player and msg:lower():sub(1,6)==".lu" then
enabled = not enabled
wait(0.3)
privateProperties.Text = "{LOLLYPOP SPY "..(enabled and "EN" or "DIS").."ABLED}"
StarterGui:SetCore("ChatMakeSystemMessage",privateProperties)
elseif enabled and (spyOnMyself==true or p~=player) then
msg = msg:gsub("[\n\r]",''):gsub("\t",' '):gsub("[ ]+",' ')
local hidden = true
local conn = getmsg.OnClientEvent:Connect(function(packet,channel)
if packet.SpeakerUserId==p.UserId and packet.Message==msg:sub(#msg-#packet.Message+1) and (channel=="All" or (channel=="Team" and public==false and p.Team==player.Team)) then
hidden = false
end
end)
wait(1)
conn:Disconnect()
if hidden and enabled then
if public then
saymsg:FireServer((publicItalics and "/me " or '').."{SPY} [".. p.Name .."]: "..msg,"All")
else
privateProperties.Text = "{SPY} [".. p.Name .."]: "..msg
StarterGui:SetCore("ChatMakeSystemMessage",privateProperties)
end
end
end
end
end

for _,p in ipairs(Players:GetPlayers()) do
p.Chatted:Connect(function(msg) onChatted(p,msg) end)
end
Players.PlayerAdded:Connect(function(p)
p.Chatted:Connect(function(msg) onChatted(p,msg) end)
end)
privateProperties.Text = "{LOLLYPOP SPY "..(enabled and "EN" or "DIS").."ABLED}"
player:WaitForChild("PlayerGui"):WaitForChild("Chat")
StarterGui:SetCore("ChatMakeSystemMessage",privateProperties)
wait(3)
local chatFrame = player.PlayerGui.Chat.Frame
chatFrame.ChatChannelParentFrame.Visible = true
chatFrame.ChatBarParentFrame.Position = chatFrame.ChatChannelParentFrame.Position+UDim2.new(UDim.new(),chatFrame.ChatChannelParentFrame.Size.Y)
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
local Section1 = Tab:NewSection("emotes")
Section1:NewButton("emotes", "emotes", function()
loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Gi7331/scripts/main/Emote.lua"))()
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
