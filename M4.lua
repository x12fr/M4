--// GUI Setup and Password Prompt //--
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "FakeCoolkiddGUI"
screenGui.ResetOnSpawn = false

local password = "letmein"
local passwordFrame = Instance.new("Frame", screenGui)
passwordFrame.Size = UDim2.new(0.8, 0, 0.3, 0)
passwordFrame.Position = UDim2.new(0.1, 0, 0.35, 0)
passwordFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
passwordFrame.BorderSizePixel = 0

local pwLabel = Instance.new("TextLabel", passwordFrame)
pwLabel.Size = UDim2.new(1, 0, 0.4, 0)
pwLabel.Text = "Enter Password"
pwLabel.TextScaled = true
pwLabel.TextColor3 = Color3.fromRGB(255,255,255)
pwLabel.BackgroundTransparency = 1

local pwBox = Instance.new("TextBox", passwordFrame)
pwBox.Size = UDim2.new(0.9, 0, 0.3, 0)
pwBox.Position = UDim2.new(0.05, 0, 0.45, 0)
pwBox.PlaceholderText = "Password..."
pwBox.TextScaled = true
pwBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
pwBox.TextColor3 = Color3.new(1,1,1)

local submit = Instance.new("TextButton", passwordFrame)
submit.Size = UDim2.new(0.5, 0, 0.2, 0)
submit.Position = UDim2.new(0.25, 0, 0.8, 0)
submit.Text = "Enter"
submit.TextScaled = true
submit.BackgroundColor3 = Color3.fromRGB(0, 150, 255)

submit.MouseButton1Click:Connect(function()
	if pwBox.Text == password then
		passwordFrame.Visible = false
	else
		pwBox.Text = "Wrong!"
	end
end)

--// Page & Button Setup //--
local currentPage = 1
local totalPages = 3
local pages = {}

local function createPage(name, index)
	local page = Instance.new("Frame", screenGui)
	page.Name = name
	page.Size = UDim2.new(1, 0, 1, 0)
	page.Position = UDim2.new(0, 0, 0, 0)
	page.BackgroundTransparency = 1
	page.Visible = (index == 1)

	local title = Instance.new("TextLabel", page)
	title.Size = UDim2.new(1, 0, 0.1, 0)
	title.Text = "M4 GUI - " .. name
	title.TextColor3 = Color3.new(1,1,1)
	title.TextScaled = true
	title.BackgroundColor3 = Color3.fromRGB(0, 0, 255)

	local category = Instance.new("TextLabel", page)
	category.Size = UDim2.new(1, 0, 0.05, 0)
	category.Position = UDim2.new(0, 0, 0.1, 0)
	category.Text = "Category: " .. name
	category.TextColor3 = Color3.new(1,1,1)
	category.TextScaled = true
	category.BackgroundColor3 = Color3.fromRGB(0, 0, 120)

	local function createButton(buttonText, posY, scriptFunction)
		local button = Instance.new("TextButton", page)
		button.Size = UDim2.new(0.9, 0, 0.08, 0)
		button.Position = UDim2.new(0.05, 0, posY, 0)
		button.Text = buttonText
		button.TextScaled = true
		button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		button.TextColor3 = Color3.new(1,1,1)

		button.MouseButton1Click:Connect(function()
			print("[" .. name .. "] Clicked: " .. buttonText)
			scriptFunction()
		end)
	end

	--// PAGE BUTTONS HERE --
	if name == "Page1" then
		createButton("Faster walkSpeed", 0.17, function()
			local character = player.Character or player.CharacterAdded:Wait()
			local humanoid = character:FindFirstChildOfClass("Humanoid")
			if humanoid then
				humanoid.WalkSpeed = 32
			end
		end)

		createButton("Corners ESP", 0.27, function()
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
		end)

		createButton("Infinite Jump", 0.37, function()
			local UIS = game:GetService("UserInputService")
			_G.infiniteJump = true
			UIS.JumpRequest:Connect(function()
				if _G.infiniteJump then
					player.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
				end
			end)
		end)

		createButton("Invis Tool", 0.47, function()
	local Players = game:GetService("Players")
	local player = Players.LocalPlayer
	local character = player.Character or player.CharacterAdded:Wait()

	-- Create Tool
	local tool = Instance.new("Tool")
	tool.RequiresHandle = false
	tool.Name = "InvisToggleTool"

	local invisible = false

	-- Toggle invisibility function
	local function toggleInvisibility()
		invisible = not invisible
		for _, part in pairs(character:GetDescendants()) do
			if part:IsA("BasePart") then
				part.LocalTransparencyModifier = invisible and 1 or 0
				part.CanCollide = not invisible
			elseif part:IsA("Decal") then
				part.Transparency = invisible and 1 or 0
			end
		end
	end

	-- On activate (click)
	tool.Activated:Connect(toggleInvisibility)

	-- Give the tool to the player
	tool.Parent = player.Backpack
end)


		createButton("Lock On", 0.57, function()
	local Players = game:GetService("Players")
	local LocalPlayer = Players.LocalPlayer
	local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
	local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
	
	local closestPlayer = nil
	local shortestDistance = math.huge

	for _, player in pairs(Players:GetPlayers()) do
		if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			local distance = (player.Character.HumanoidRootPart.Position - HumanoidRootPart.Position).magnitude
			if distance < shortestDistance then
				shortestDistance = distance
				closestPlayer = player
			end
		end
	end

	if closestPlayer then
		print("Locked on to:", closestPlayer.Name)
		-- Optional: highlight or follow
		local highlight = Instance.new("Highlight")
		highlight.Name = "LockOnHighlight"
		highlight.FillColor = Color3.fromRGB(255, 0, 0)
		highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
		highlight.Adornee = closestPlayer.Character
		highlight.Parent = closestPlayer.Character
	end
end)


	elseif name == "Page2" then
		createButton("Bigger Hitbox", 0.17, function()
	for _, player in pairs(game.Players:GetPlayers()) do
		if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			local hrp = player.Character.HumanoidRootPart
			hrp.Size = Vector3.new(50, 50, 50) -- MASSIVE hitbox
			hrp.Transparency = 0.7
			hrp.CanCollide = false
			hrp.Massless = true

			if not hrp:FindFirstChild("HitboxBox") then
				local box = Instance.new("BoxHandleAdornment")
				box.Name = "HitboxBox"
				box.Size = hrp.Size
				box.Color3 = Color3.fromRGB(0, 170, 255)
				box.Transparency = 0.5
				box.AlwaysOnTop = true
				box.ZIndex = 5
				box.Adornee = hrp
				box.Parent = hrp
			end
		end
	end
end)


		createButton("Rainbow Character", 0.27, function()
			-- 🔧 INSERT rainbow effect script
		end)

		createButton("Invisible Character", 0.37, function()
			-- 🔧 INSERT invisibility toggle here
		end)

		createButton("Anti-Chat Logger", 0.47, function()
			-- 🔧 INSERT anti-logger script
		end)

		createButton("Click TP Tool", 0.57, function()
			-- 🔧 INSERT teleport tool script
		end)

	elseif name == "Page3" then
		createButton("FE Kill All (R6 only)", 0.17, function()
			-- 🔧 INSERT kill all script
		end)

		createButton("Play Sound for All", 0.27, function()
			-- 🔧 INSERT sound broadcaster script
		end)

		createButton("Loop Message Chat", 0.37, function()
			-- 🔧 INSERT loop message function
		end)

		createButton("Crash Server (⚠️)", 0.47, function()
			-- 🔧 INSERT crash logic (if permitted)
		end)

		createButton("Reset Character", 0.57, function()
			player:LoadCharacter()
		end)
	end

	return page
end

--// Generate Pages --//
for i = 1, totalPages do
	pages[i] = createPage("Page" .. i, i)
end

--// Navigation Buttons --//
local navFrame = Instance.new("Frame", screenGui)
navFrame.Size = UDim2.new(1, 0, 0.07, 0)
navFrame.Position = UDim2.new(0, 0, 0.93, 0)
navFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)

local leftBtn = Instance.new("TextButton", navFrame)
leftBtn.Size = UDim2.new(0.2, 0, 1, 0)
leftBtn.Position = UDim2.new(0.15, 0, 0, 0)
leftBtn.Text = "<"
leftBtn.TextScaled = true
leftBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
leftBtn.TextColor3 = Color3.new(1,1,1)

local rightBtn = Instance.new("TextButton", navFrame)
rightBtn.Size = UDim2.new(0.2, 0, 1, 0)
rightBtn.Position = UDim2.new(0.65, 0, 0, 0)
rightBtn.Text = ">"
rightBtn.TextScaled = true
rightBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
rightBtn.TextColor3 = Color3.new(1,1,1)

local function showPage(index)
	for i, page in ipairs(pages) do
		page.Visible = (i == index)
	end
end

leftBtn.MouseButton1Click:Connect(function()
	currentPage = currentPage - 1
	if currentPage < 1 then currentPage = totalPages end
	showPage(currentPage)
end)

rightBtn.MouseButton1Click:Connect(function()
	currentPage = currentPage + 1
	if currentPage > totalPages then currentPage = 1 end
	showPage(currentPage)
end)
