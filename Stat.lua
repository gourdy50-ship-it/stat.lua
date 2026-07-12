local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer

-- Hide all existing UI
local hiddenUI = {}

for _, ui in pairs(player.PlayerGui:GetChildren()) do
	if ui:IsA("ScreenGui") then
		hiddenUI[ui] = ui.Enabled
		ui.Enabled = false
	end
end

-- Create cutscene UI
local gui = Instance.new("ScreenGui")
gui.Name = "STAT_Cutscene"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.Parent = game:GetService("CoreGui")

-- Device scaling
local scale = Instance.new("UIScale")
scale.Parent = gui

local viewport = workspace.CurrentCamera.ViewportSize

if UserInputService.TouchEnabled then
	scale.Scale = math.clamp(viewport.X / 900, 0.7, 1)
else
	scale.Scale = math.clamp(viewport.X / 1200, 0.8, 1.2)
end

-- Background
local bg = Instance.new("Frame")
bg.Size = UDim2.fromScale(1,1)
bg.BackgroundColor3 = Color3.fromRGB(0,0,0)
bg.Parent = gui

-- Image
local img = Instance.new("ImageLabel")
img.AnchorPoint = Vector2.new(0.5,0.5)
img.Size = UDim2.fromScale(0.35,0.35)
img.Position = UDim2.fromScale(0.5,0.4)
img.BackgroundTransparency = 1

-- Stats Leaderboard Bars Icon
img.Image = "rbxthumb://type=Asset&id=16851789345&w=420&h=420"

img.ImageTransparency = 1
img.ScaleType = Enum.ScaleType.Fit
img.Parent = bg

-- STAT Text
local title = Instance.new("TextLabel")
title.AnchorPoint = Vector2.new(0.5,0.5)
title.Size = UDim2.fromScale(0.5,0.1)
title.Position = UDim2.fromScale(0.5,0.72)
title.BackgroundTransparency = 1
title.Text = "STAT"
title.Font = Enum.Font.FredokaOne
title.TextScaled = true
title.TextColor3 = Color3.fromRGB(255,255,255)
title.TextStrokeTransparency = 0.2
title.TextStrokeColor3 = Color3.fromRGB(0,0,0)
title.TextTransparency = 1
title.Parent = bg

-- Fade in
TweenService:Create(img, TweenInfo.new(1), {
	ImageTransparency = 0
}):Play()

TweenService:Create(title, TweenInfo.new(1), {
	TextTransparency = 0
}):Play()

-- Hold for 5 seconds
task.wait(5)

-- Fade out
TweenService:Create(img, TweenInfo.new(1), {
	ImageTransparency = 1
}):Play()

TweenService:Create(title, TweenInfo.new(1), {
	TextTransparency = 1
}):Play()

TweenService:Create(bg, TweenInfo.new(1), {
	BackgroundTransparency = 1
}):Play()

task.wait(1)

-- Remove cutscene
gui:Destroy()

-- Restore UI
for ui, state in pairs(hiddenUI) do
	if ui then
		ui.Enabled = state
	end
end
