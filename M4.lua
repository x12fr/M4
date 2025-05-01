-- // M4 GUI v1 - c00lkidd inspired, with tabs, FPS, toggle, and organized structure

-- [[ MAIN GUI SETUP ]]
local plr = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", plr:WaitForChild("PlayerGui"))
gui.Name = "M4_GUI"
gui.ResetOnSpawn = false

-- [[ FRAME SETUP ]]
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 240, 0, 280)
frame.Position = UDim2.new(0.5, -120, 0.5, -140)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BorderColor3 = Color3.fromRGB(0, 162, 255)
frame.BorderSizePixel = 2
frame.Active = true
frame.Draggable = true
frame.Visible = true

-- [[ TITLE BAR ]]
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, -50, 0, 30)
title.Position = UDim2.new(0, 5, 0, 0)
title.Text = "M4 GUI"
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
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
closeBtn.BorderColor3 = Color3.fromRGB(0, 162, 255)

-- [[ TOGGLE BUTTON (BOTTOM RIGHT) ]]
local toggleBtn = Instance.new("TextButton", gui)
toggleBtn.Size = UDim2.new(0, 80, 0, 30)
toggleBtn.Position = UDim2.new(1, -90, 1, -40)
toggleBtn.Text = "Open M4"
toggleBtn.Font = Enum.Font.SourceSansBold
toggleBtn.TextSize = 16
toggleBtn.TextColor3 = Color3.new(1,1,1)
toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
toggleBtn.BorderColor3 = Color3.fromRGB(0, 162, 255)

-- Close / Open Logic
closeBtn.MouseButton1Click:Connect(function()
	frame.Visible = false
	toggleBtn.Visible = true
end)

toggleBtn.MouseButton1Click:Connect(function()
	frame.Visible = true
	toggleBtn.Visible = false
end)

-- [[ TAB SETUP ]]
local tabs = { "Main", "Fun", "Misc" }
local pages = {}
local currentTab = "Main"

for i, name in pairs(tabs) do
	local btn = Instance.new("TextButton", frame)
	btn.Size = UDim2.new(0, 70, 0, 25)
	btn.Position = UDim2.new(0, 5 + (i - 1) * 75, 0, 35)
	btn.Text = name
	btn.Font = Enum.Font.SourceSansBold
	btn.TextSize = 16
	btn.TextColor3 = Color3.new(1,1,1)
	btn.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
	btn.BorderColor3 = Color3.fromRGB(0, 162, 255)

	btn.MouseButton1Click:Connect(function()
		currentTab = name
		for tabName, tabFrame in pairs(pages) do
			tabFrame.Visible = (tabName == name)
		end
	end)
end

-- [[ PAGES SETUP ]]
for _, name in pairs(tabs) do
	local page = Instance.new("Frame", frame)
	page.Name = name
	page.Size = UDim2.new(1, -10, 1, -80)
	page.Position = UDim2.new(0, 5, 0, 65)
	page.BackgroundTransparency = 1
	page.Visible = (name == currentTab)
	pages[name] = page
end

-- [[ BUTTON FUNCTION TEMPLATE ]]
local function createButton(parent, label, callback, row, col)
	local btn = Instance.new("TextButton", parent)
	btn.Size = UDim2.new(0, 100, 0, 30)
	btn.Position = UDim2.new(0, (col - 1) * 110, 0, (row - 1) * 40)
	btn.Text = label
	btn.Font = Enum.Font.SourceSans
	btn.TextSize = 18
	btn.TextColor3 = Color3.new(1,1,1)
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

createButton(pages["Main"], "Weird esp", function()
	for _, plr in pairs(Players:GetPlayers()) do
				if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
					local root = plr.Character.HumanoidRootPart
					local billboard = Instance.new("BillboardGui")
					billboard.Name = "CornerESP"
					billboard.Adornee = root
					billboard.Size = UDim2.new(0, 100, 0, 100)
					billboard.AlwaysOnTop = true
					billboard.Parent = root

					local function makeCorner(x, y)
						local corner = Instance.new("Frame")
						corner.Size = UDim2.new(0, 10, 0, 10)
						corner.Position = UDim2.new(0, x, 0, y)
						corner.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
						corner.BorderSizePixel = 0
						corner.Parent = billboard
					end

					makeCorner(0, 0)
					makeCorner(90, 0)
					makeCorner(0, 90)
					makeCorner(90, 90)
				end
			end
end, 1, 2)

createButton(pages["Main"], "Inf Jump", function()
	local UIS = game:GetService("UserInputService")
			_G.infiniteJump = true
			UIS.JumpRequest:Connect(function()
				if _G.infiniteJump then
					player.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
				end
			end)
end, 2, 1)

createButton(pages["Main"], "Kill All [FE]", function()
	-- Example of exploiting a RemoteEvent
for _, player in pairs(game:GetService("Players"):GetPlayers()) do
    if player ~= game.Players.LocalPlayer then
        -- Replace 'KillRemote' with the actual RemoteEvent used by the game
        game:GetService("ReplicatedStorage").KillRemote:FireServer(player)
    end
end

end, 2, 2)

-- [[ FUN TAB BUTTONS ]]
createButton(pages["Fun"], "Spin", function()
	print("Spin fun!")
end, 1, 1)

createButton(pages["Fun"], "Rainbow", function()
	print("Rainbow effect here.")
end, 1, 2)

-- [[ MISC TAB BUTTONS ]]
createButton(pages["Misc"], "ESP", function()
	print("ESP activated.")
end, 1, 1)

createButton(pages["Misc"], "Anti-AFK", function()
	print("Anti-AFK script.")
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
local last = tick()
local frames = 0
RS.RenderStepped:Connect(function()
	frames += 1
	if tick() - last >= 1 then
		fpsLabel.Text = "FPS: " .. frames
		frames = 0
		last = tick()
	end
end)
