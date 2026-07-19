local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local RainbowFrame = Instance.new("Frame") 
local TitleLabel = Instance.new("TextLabel")
local SubLabel = Instance.new("TextLabel")
local ToggleButton = Instance.new("TextButton")
local SpeedInput = Instance.new("TextBox")
local EspButton = Instance.new("TextButton")
local SimpleEspButton = Instance.new("TextButton")
local AimbotButton = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 250, 0, 400)
MainFrame.Position = UDim2.new(0.5, -125, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0

RainbowFrame.Parent = MainFrame
RainbowFrame.Size = UDim2.new(1, 2, 1, 2)
RainbowFrame.Position = UDim2.new(0, -1, 0, -1)
RainbowFrame.ZIndex = 0
RainbowFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

spawn(function()
    while true do
        for i = 0, 1, 0.01 do
            RainbowFrame.BackgroundColor3 = Color3.fromHSV(i, 1, 1)
            wait(0.05)
        end
    end
end)

local UserInputService = game:GetService("UserInputService")
local dragging, dragStart, startPos

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

TitleLabel.Parent = MainFrame
TitleLabel.Size = UDim2.new(1, 0, 0, 40)
TitleLabel.Text = "Arsenal Script"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.TextSize = 32

ToggleButton.Parent = MainFrame
ToggleButton.Size = UDim2.new(0.8, 0, 0, 30)
ToggleButton.Position = UDim2.new(0.1, 0, 0.12, 0)
ToggleButton.Text = "Hitbox: OFF"
ToggleButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.BorderSizePixel = 0
ToggleButton.TextSize = 18

EspButton.Parent = MainFrame
EspButton.Size = UDim2.new(0.8, 0, 0, 30)
EspButton.Position = UDim2.new(0.1, 0, 0.22, 0)
EspButton.Text = "ESP Tracers: OFF"
EspButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
EspButton.TextColor3 = Color3.fromRGB(255, 255, 255)
EspButton.BorderSizePixel = 0
EspButton.TextSize = 18

SimpleEspButton.Parent = MainFrame
SimpleEspButton.Size = UDim2.new(0.8, 0, 0, 30)
SimpleEspButton.Position = UDim2.new(0.1, 0, 0.32, 0)
SimpleEspButton.Text = "Simple ESP: OFF"
SimpleEspButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
SimpleEspButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SimpleEspButton.BorderSizePixel = 0
SimpleEspButton.TextSize = 18

AimbotButton.Parent = MainFrame
AimbotButton.Size = UDim2.new(0.8, 0, 0, 30)
AimbotButton.Position = UDim2.new(0.1, 0, 0.42, 0)
AimbotButton.Text = "Aimbot: OFF"
AimbotButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
AimbotButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AimbotButton.BorderSizePixel = 0
AimbotButton.TextSize = 18

SpeedInput.Parent = MainFrame
SpeedInput.Size = UDim2.new(0.8, 0, 0, 30)
SpeedInput.Position = UDim2.new(0.1, 0, 0.52, 0)
SpeedInput.PlaceholderText = "Walk Speed"
SpeedInput.Text = ""
SpeedInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
SpeedInput.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedInput.BorderSizePixel = 0
SpeedInput.TextSize = 18

SubLabel.Parent = MainFrame
SubLabel.Size = UDim2.new(1, 0, 0, 30)
SubLabel.Position = UDim2.new(0, 0, 0.9, 0)
SubLabel.Text = "YT: icansowtoyou"
SubLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
SubLabel.BackgroundTransparency = 1
SubLabel.TextSize = 14

local EnabledHit, EnabledEsp, EnabledSimpleEsp, EnabledAimbot = false, false, false, false
local players = game:GetService("Players")
local localPlayer = players.LocalPlayer
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

local FOVCircle = Drawing.new("Circle")
FOVCircle.Visible = false
FOVCircle.Radius = 150
FOVCircle.Thickness = 1
FOVCircle.Color = Color3.fromRGB(255, 255, 255)

RunService.RenderStepped:Connect(function()
    FOVCircle.Position = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
    FOVCircle.Visible = EnabledAimbot
    
    if EnabledAimbot and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
        local closestTarget = nil
        local shortestDist = 150
        for _, v in pairs(players:GetPlayers()) do
            if v ~= localPlayer and v.Team ~= localPlayer.Team and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
                local head = v.Character:FindFirstChild("Head")
                if head then
                    local pos, onScreen = Camera:WorldToViewportPoint(head.Position)
                    local dist = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                    local ray = Ray.new(Camera.CFrame.Position, (head.Position - Camera.CFrame.Position).Unit * 500)
                    local hit = workspace:FindPartOnRay(ray, localPlayer.Character)
                    if onScreen and dist < shortestDist and (hit and hit:IsDescendantOf(v.Character)) then
                        shortestDist = dist
                        closestTarget = head
                    end
                end
            end
        end
        if closestTarget then Camera.CFrame = CFrame.new(Camera.CFrame.Position, closestTarget.Position) end
    end
end)

RunService.Heartbeat:Connect(function()
    local speedVal = tonumber(SpeedInput.Text)
    if speedVal and localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
        local hum = localPlayer.Character.Humanoid
        if hum.WalkSpeed ~= speedVal then hum.WalkSpeed = speedVal end
    end
end)

RunService.RenderStepped:Connect(function()
    if EnabledEsp then
        for _, v in pairs(players:GetPlayers()) do
            if v ~= localPlayer and v.Team ~= localPlayer.Team and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                local root = v.Character.HumanoidRootPart
                local screenPos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(root.Position)
                if onScreen then
                    local line = Drawing.new("Line")
                    line.From = Vector2.new(workspace.CurrentCamera.ViewportSize.X/2, workspace.CurrentCamera.ViewportSize.Y)
                    line.To = Vector2.new(screenPos.X, screenPos.Y)
                    line.Color = Color3.fromRGB(255, 255, 255)
                    line.Visible = true
                    task.wait()
                    line:Remove()
                end
            end
        end
    end
end)

RunService.RenderStepped:Connect(function()
    if EnabledSimpleEsp then
        for _, v in pairs(players:GetPlayers()) do
            if v ~= localPlayer and v.Team ~= localPlayer.Team and v.Character and not v.Character:FindFirstChild("Highlight") then
                local h = Instance.new("Highlight")
                h.Parent = v.Character
                h.FillColor = Color3.fromRGB(255, 255, 255)
                h.FillTransparency = 0.5
                h.OutlineTransparency = 0
            end
        end
    else
        for _, v in pairs(players:GetPlayers()) do
            if v.Character and v.Character:FindFirstChild("Highlight") then v.Character.Highlight:Destroy() end
        end
    end
end)

ToggleButton.MouseButton1Click:Connect(function()
    EnabledHit = not EnabledHit
    ToggleButton.Text = EnabledHit and "Hitbox: ON" or "Hitbox: OFF"
    if EnabledHit then
        spawn(function()
            while EnabledHit do
                for _, v in pairs(players:GetPlayers()) do
                    if v ~= localPlayer and v.Team ~= localPlayer.Team and v.Character then
                        for _, name in pairs({"HeadHB", "HumanoidRootPart"}) do
                            local p = v.Character:FindFirstChild(name)
                            if p then p.Size = Vector3.new(13, 13, 13) p.Transparency = 10 end
                        end
                    end
                end
                wait(1)
            end
        end)
    end
end)

EspButton.MouseButton1Click:Connect(function() EnabledEsp = not EnabledEsp; EspButton.Text = EnabledEsp and "ESP Tracers: ON" or "ESP Tracers: OFF" end)
SimpleEspButton.MouseButton1Click:Connect(function() EnabledSimpleEsp = not EnabledSimpleEsp; SimpleEspButton.Text = EnabledSimpleEsp and "Simple ESP: ON" or "Simple ESP: OFF" end)
AimbotButton.MouseButton1Click:Connect(function() EnabledAimbot = not EnabledAimbot; AimbotButton.Text = EnabledAimbot and "Aimbot: ON" or "Aimbot: OFF" end)