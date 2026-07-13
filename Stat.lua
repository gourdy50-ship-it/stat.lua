local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")

local LocalPlayer = Players.LocalPlayer


local hiddenUI = {}

for _, ui in pairs(LocalPlayer.PlayerGui:GetChildren()) do
	if ui:IsA("ScreenGui") then
		hiddenUI[ui] = ui.Enabled
		ui.Enabled = false
	end
end


local Cutscene = Instance.new("ScreenGui")
Cutscene.Name = "STAT_Cutscene"
Cutscene.IgnoreGuiInset = true
Cutscene.ResetOnSpawn = false
Cutscene.Parent = game:GetService("CoreGui")


local Scale = Instance.new("UIScale")
Scale.Parent = Cutscene

if UserInputService.TouchEnabled then
	Scale.Scale = 0.8
else
	Scale.Scale = 1
end


local Background = Instance.new("Frame")
Background.Size = UDim2.fromScale(1,1)
Background.BackgroundColor3 = Color3.fromRGB(0,0,0)
Background.Parent = Cutscene


local Image = Instance.new("ImageLabel")
Image.AnchorPoint = Vector2.new(0.5,0.5)
Image.Position = UDim2.fromScale(0.5,0.4)
Image.Size = UDim2.fromScale(0.35,0.35)
Image.BackgroundTransparency = 1
Image.Image = "rbxthumb://type=Asset&id=16851789345&w=420&h=420"
Image.ScaleType = Enum.ScaleType.Fit
Image.ImageTransparency = 1
Image.Parent = Background


local Title = Instance.new("TextLabel")
Title.AnchorPoint = Vector2.new(0.5,0.5)
Title.Position = UDim2.fromScale(0.5,0.72)
Title.Size = UDim2.fromScale(0.5,0.1)
Title.BackgroundTransparency = 1
Title.Text = "STAT"
Title.Font = Enum.Font.FredokaOne
Title.TextScaled = true
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.TextStrokeTransparency = 0
Title.TextTransparency = 1
Title.Parent = Background


TweenService:Create(Image,TweenInfo.new(1),{
	ImageTransparency = 0
}):Play()

TweenService:Create(Title,TweenInfo.new(1),{
	TextTransparency = 0
}):Play()


task.wait(5)


TweenService:Create(Image,TweenInfo.new(1),{
	ImageTransparency = 1
}):Play()

TweenService:Create(Title,TweenInfo.new(1),{
	TextTransparency = 1
}):Play()


task.wait(1)

Cutscene:Destroy()


for ui,state in pairs(hiddenUI) do
	if ui then
		ui.Enabled = state
	end
end



local WindUI = loadstring(game:HttpGet(
	"https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"
))()


local Window = WindUI:CreateWindow({
	Title = "STAT",
	Icon = "eye",
	Author = "STAT",
	Folder = "STAT"
})


local Main = Window:Tab({
	Title = "Main",
	Icon = "home"
})


local Visual = Window:Tab({
	Title = "Visual",
	Icon = "eye"
})


local Fun = Window:Tab({
	Title = "Fun",
	Icon = "sparkles"
})



local ESPRunning = false


local function SendNotification(title,text,duration)

	pcall(function()
		StarterGui:SetCore("SendNotification",{
			Title = title,
			Text = text,
			Duration = duration
		})
	end)

end



local function StartNPCESP()

	ESPRunning = true

	task.spawn(function()

		while ESPRunning do

			for _,e in pairs(workspace.NPCs:GetChildren()) do


				if e:FindFirstChildOfClass("Highlight") then
					continue
				end


				local h = Instance.new("Highlight")
				h.FillTransparency = 0.85


				local isPatient = e:GetAttribute("IsPatient")
				local skinwalker = e:GetAttribute("Skinwalker")


				if (isPatient == false or isPatient == nil) and skinwalker then

					SendNotification(
						"AnimalHospital — Notification",
						"A skinwalker entered the building, name: "..e.Name,
						10
					)

					h.OutlineColor = Color3.fromRGB(0,0,0)
					h.FillColor = Color3.fromRGB(0,0,0)


				elseif isPatient == true or isPatient == nil then

					SendNotification(
						"AnimalHospital — Notification",
						"A patient entered the building, name: "..e.Name,
						10
					)

					h.OutlineColor = Color3.fromRGB(51,153,51)
					h.FillColor = Color3.fromRGB(0,255,0)


				else

					SendNotification(
						"AnimalHospital — Notification",
						"A visitor entered the building, name: "..e.Name,
						10
					)

					h.OutlineColor = Color3.fromRGB(255,255,255)
					h.FillColor = Color3.fromRGB(255,255,255)

				end


				h.Parent = e

			end


			task.wait(0.1)

		end

	end)

end



Visual:Toggle({
	Title = "NPC ESP",
	Default = false,

	Callback = function(state)

		if state then
			StartNPCESP()
		else
			ESPRunning = false
		end

	end
})
