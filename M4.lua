-- // M4 GUI v1 - Inspired by c00lkidd | Organized Tabs, FPS Counter, Toggle System

-- [[ SETUP ]]
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "M4_GUI"
gui.ResetOnSpawn = false

-- [[ MAIN FRAME ]]
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 240, 0, 280)
frame.Position = UDim2.new(0.5, -120, 0.5, -140)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BorderColor3 = Color3.fromRGB(0, 162, 255)
frame.BorderSizePixel = 2
frame.Active = true
frame.Draggable = true

-- [[ TITLE BAR ]]
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, -50, 0, 30)
title.Position = UDim2.new(0, 5, 0, 0)
title.Text = "Syk1vz Client"
title.Font = Enum.Font.SourceSansBold
title.TextSize = 22
title.TextColor3 = Color3.fromRGB(0, 162, 255)
title.BackgroundTransparency = 1

-- [[ CLOSE BUTTON ]]
local closeBtn = Instance.new("TextButton", frame)
closeBtn.Size = UDim2.new(0, 40, 0, 25)
closeBtn.Position = UDim2.new(1, -45, 0, 3)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.SourceSansBold
closeBtn.TextSize = 18
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
closeBtn.BorderColor3 = Color3.fromRGB(0, 162, 255)

-- [[ TOGGLE BUTTON ]]
local toggleBtn = Instance.new("TextButton", gui)
toggleBtn.Size = UDim2.new(0, 80, 0, 30)
toggleBtn.Position = UDim2.new(1, -90, 1, -40)
toggleBtn.Text = "Open M4"
toggleBtn.Font = Enum.Font.SourceSansBold
toggleBtn.TextSize = 16
toggleBtn.TextColor3 = Color3.new(1, 1, 1)
toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
toggleBtn.BorderColor3 = Color3.fromRGB(0, 162, 255)
toggleBtn.Visible = false

-- [[ Toggle Logic ]]
closeBtn.MouseButton1Click:Connect(function()
	frame.Visible = false
	toggleBtn.Visible = true
end)

toggleBtn.MouseButton1Click:Connect(function()
	frame.Visible = true
	toggleBtn.Visible = false
end)

-- [[ TAB SYSTEM ]]
local tabs = { "Main", "Fun", "Misc" }
local pages = {}
local currentTab = "Main"

for i, name in ipairs(tabs) do
	local tabBtn = Instance.new("TextButton", frame)
	tabBtn.Size = UDim2.new(0, 70, 0, 25)
	tabBtn.Position = UDim2.new(0, 5 + (i - 1) * 75, 0, 35)
	tabBtn.Text = name
	tabBtn.Font = Enum.Font.SourceSansBold
	tabBtn.TextSize = 16
	tabBtn.TextColor3 = Color3.new(1, 1, 1)
	tabBtn.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
	tabBtn.BorderColor3 = Color3.fromRGB(0, 162, 255)

	tabBtn.MouseButton1Click:Connect(function()
		currentTab = name
		for tabName, page in pairs(pages) do
			page.Visible = (tabName == name)
		end
	end)
end

for _, name in ipairs(tabs) do
	local page = Instance.new("Frame", frame)
	page.Name = name
	page.Size = UDim2.new(1, -10, 1, -80)
	page.Position = UDim2.new(0, 5, 0, 65)
	page.BackgroundTransparency = 1
	page.Visible = (name == currentTab)
	pages[name] = page
end

-- [[ BUTTON GENERATOR ]]
local function createButton(parent, label, callback, row, col)
	local btn = Instance.new("TextButton", parent)
	btn.Size = UDim2.new(0, 100, 0, 30)
	btn.Position = UDim2.new(0, (col - 1) * 110, 0, (row - 1) * 40)
	btn.Text = label
	btn.Font = Enum.Font.SourceSans
	btn.TextSize = 18
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
	btn.BorderColor3 = Color3.fromRGB(0, 162, 255)
	btn.MouseButton1Click:Connect(callback)
end

-- [[ MAIN TAB BUTTONS ]]
createButton(pages["Main"], "Faster walkSpeed", function()
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid.WalkSpeed = 32
	end
end, 1, 1)

createButton(pages["Main"], "Weird ESP", function()
	for _, plr in pairs(Players:GetPlayers()) do
		if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
			local root = plr.Character.HumanoidRootPart
			if not root:FindFirstChild("CornerESP") then
				local billboard = Instance.new("BillboardGui")
				billboard.Name = "CornerESP"
				billboard.Adornee = root
				billboard.Size = UDim2.new(0, 100, 0, 100)
				billboard.AlwaysOnTop = true
				billboard.Parent = root

				for _, pos in ipairs({{0,0},{90,0},{0,90},{90,90}}) do
					local corner = Instance.new("Frame")
					corner.Size = UDim2.new(0, 10, 0, 10)
					corner.Position = UDim2.new(0, pos[1], 0, pos[2])
					corner.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
					corner.BorderSizePixel = 0
					corner.Parent = billboard
				end
			end
		end
	end
end, 1, 2)

createButton(pages["Main"], "Inf Jump", function()
	local UIS = game:GetService("UserInputService")
	_G.infiniteJump = true
	UIS.JumpRequest:Connect(function()
		if _G.infiniteJump and player.Character then
			local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
			if humanoid then
				humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
			end
		end
	end)
end, 2, 1)

createButton(pages["Main"], "Kill All [FE]", function()
	local remote = game:GetService("ReplicatedStorage"):FindFirstChild("KillRemote")
	if remote then
		for _, plr in pairs(Players:GetPlayers()) do
			if plr ~= player then
				remote:FireServer(plr)
			end
		end
	else
		warn("KillRemote not found in ReplicatedStorage.")
	end
end, 2, 2)

-- [[ FUN TAB BUTTONS ]]
createButton(pages["Fun"], "Spin", function()
	print("Spin effect here.")
end, 1, 1)

createButton(pages["Fun"], "Rainbow", function()
	print("Rainbow effect placeholder.")
end, 1, 2)

-- [[ MISC TAB BUTTONS ]]
createButton(pages["Misc"], "ESP", function()
	print("ESP activated.")
end, 1, 1)

createButton(pages["Misc"], "Anti-AFK", function()
	print("Anti-AFK enabled.")
end, 1, 2)

-- [[ FPS COUNTER ]]
local fpsLabel = Instance.new("TextLabel", gui)
fpsLabel.Size = UDim2.new(0, 80, 0, 25)
fpsLabel.Position = UDim2.new(1, -85, 0, 10)
fpsLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
fpsLabel.BorderColor3 = Color3.fromRGB(0, 162, 255)
fpsLabel.BorderSizePixel = 2
fpsLabel.TextColor3 = Color3.new(1, 1, 1)
fpsLabel.Font = Enum.Font.SourceSansBold
fpsLabel.TextSize = 16
fpsLabel.Text = "FPS: ..."
fpsLabel.TextXAlignment = Enum.TextXAlignment.Left

local RS = game:GetService("RunService")
local lastTick = tick()
local frames = 0
RS.RenderStepped:Connect(function()
	frames += 1
	if tick() - lastTick >= 1 then
		fpsLabel.Text = "FPS: " .. frames
		frames = 0
		lastTick = tick()
	end
end)
