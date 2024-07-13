local Window            = Library:CreateWindow("Zero - World Zero")
local Folder            = Window:CreateFolder("Farm")
local Folder2           = Window:CreateFolder("MISC")
local Player            = game:GetService("Players").LocalPlayer
local Level             = Player.Data.Level
local UIS               = game:GetService("UserInputService")
local RS                = game:GetService("RunService")
local VU                = game:GetService("VirtualUser")
local TweenService      = game:GetService("TweenService")
local TeleportService   = game:GetService("TeleportService")
local HttpService       = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local replicatedStorage = game:GetService("ReplicatedStorage")
local Collectibles      = replicatedStorage:WaitForChild("Collectibles")
local collectable       = Collectibles:GetChildren()
local Mobs              = replicatedStorage.Mobs
local hum               = Player.Character:WaitForChild("Humanoid")
local ch                = Player.Character
local hroot             = ch:WaitForChild("HumanoidRootPart")
local click             = false
local mobdis            = 20
local chestdis          = 20
local mobval            = false
local chestval          = false
local mobcont           = false
local chestcont         = false
local mobc              = false
local chestc            = false
local val               = false
local savedPos          = nil
local G                 = 5000
local Pause             = false
local MobsCount         = 0

local Udim2 = {
    ["to"] = UDim2.new(0.5, 0, 0.93, 0),
    ["from"] = UDim2.new(0.5, 0, 1, 0)
}

local UpdateTime = 0.1

local function SendNotification(Title, Text, Duration)
    game.StarterGui:SetCore("SendNotification", {
        Title = Title;
        Text = Text;
        Duration = Duration or 5;
    })
end

local function SetPlayerPosition(position)
    local tween = TweenService:Create(hroot, TweenInfo.new(0.1), {CFrame = position})
    tween:Play()
    tween.Completed:Wait()
end

local function GetClosestMob()
    local closestDistance = math.huge
    local closestMob = nil

    for _, mob in pairs(Mobs:GetChildren()) do
        local mobHumanoid = mob:FindFirstChildOfClass("Humanoid")
        local mobRootPart = mob:FindFirstChild("HumanoidRootPart")

        if mobHumanoid and mobRootPart and mobHumanoid.Health > 0 then
            local distance = (mobRootPart.Position - hroot.Position).magnitude
            if distance < closestDistance then
                closestDistance = distance
                closestMob = mob
            end
        end
    end

    return closestMob
end

Folder:Toggle("Auto Farm",function(bool)
    val = bool
    click = bool
end)

RS.RenderStepped:Connect(function()
    if val then
        if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            if not Pause then
                local mob = GetClosestMob()

                if mob then
                    SetPlayerPosition(mob.HumanoidRootPart.CFrame)
                end
            end
        end
    end
end)

Folder2:Button("Rejoin", function()
    TeleportService:Teleport(game.PlaceId, Player)
end)

Folder2:Button("Save Position", function()
    savedPos = hroot.CFrame
    SendNotification("Position", "Position Saved", 3)
end)

Folder2:Button("Load Position", function()
    if savedPos then
        SetPlayerPosition(savedPos)
    end
end)
