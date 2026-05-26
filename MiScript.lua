-- MM2 Trade Visual Menu
-- Force Accept + Freeze Trade
-- uses original MM2 UI, no fake labels

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local lp = Players.LocalPlayer
local gui = lp:WaitForChild("PlayerGui")

--------------------------------------------------
-- FORCE ACCEPT FUNCTION (твоя, рабочая)
--------------------------------------------------

local function forceAccept()
	for _, v in ipairs(gui:GetDescendants()) do
		if v:IsA("Frame") and v.Name == "Accepted" then
			local label = v:FindFirstChildWhichIsA("TextLabel")
			if label and label.Text:upper():find("OTHER PLAYER HAS ACCEPTED") then
				v.Visible = true
				label.Visible = true
				label.Text = "OTHER PLAYER HAS ACCEPTED."
				warn("[MM2 UI] Force accept shown")
				return
			end
		end
	end
	warn("[MM2 UI] Accepted frame not found (open trade)")
end

--------------------------------------------------
-- FREEZE TRADE (визуально)
--------------------------------------------------

local frozen = false
local function freezeTrade()
	frozen = not frozen
	for _, v in ipairs(gui:GetDescendants()) do
		if v:IsA("TextButton") and (v.Text == "ACCEPT" or v.Text == "DECLINE") then
			v.Active = not frozen
			v.AutoButtonColor = not frozen
		end
	end
end

--------------------------------------------------
-- GUI CREATION
--------------------------------------------------

local screen = Instance.new("ScreenGui")
screen.Name = "MM2_TradeMenu"
screen.ResetOnSpawn = false
screen.Parent = game:GetService("CoreGui")



local main = Instance.new("Frame")
main.Parent = screen
main.Size = UDim2.fromScale(0.22, 0.22)
main.Position = UDim2.fromScale(0.12, 0.55)
main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true

local corner = Instance.new("UICorner", main)
corner.CornerRadius = UDim.new(0, 14)

--------------------------------------------------
-- TITLE
--------------------------------------------------

local title = Instance.new("TextLabel")
title.Parent = main
title.Size = UDim2.fromScale(1, 0.2)
title.BackgroundTransparency = 1
title.Text = "MM2 Trade Menu"
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextColor3 = Color3.fromRGB(255,255,255)
title.TextXAlignment = Enum.TextXAlignment.Center
title.TextYAlignment = Enum.TextYAlignment.Center

--------------------------------------------------
-- BUTTON CREATOR
--------------------------------------------------

local function makeButton(text, posY, color)
	local btn = Instance.new("TextButton")
	btn.Parent = main
	btn.Size = UDim2.fromScale(0.85, 0.18)
	btn.Position = UDim2.fromScale(0.075, posY)
	btn.Text = text
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 14
	btn.TextColor3 = Color3.fromRGB(255,255,255)
	btn.BackgroundColor3 = color
	btn.AutoButtonColor = false
	btn.TextXAlignment = Enum.TextXAlignment.Center
	btn.TextYAlignment = Enum.TextYAlignment.Center

	local c = Instance.new("UICorner", btn)
	c.CornerRadius = UDim.new(0, 10)

	-- hover animation
	btn.MouseEnter:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.15), {
			BackgroundColor3 = color:Lerp(Color3.new(1,1,1), 0.15)
		}):Play()
	end)

	btn.MouseLeave:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.15), {
			BackgroundColor3 = color
		}):Play()
	end)

	return btn
end

--------------------------------------------------
-- BUTTONS
--------------------------------------------------

local forceBtn = makeButton("FORCE ACCEPT", 0.28, Color3.fromRGB(0, 170, 0))
forceBtn.MouseButton1Click:Connect(forceAccept)

local status = Instance.new("TextLabel")
status.Parent = main
status.Size = UDim2.fromScale(0.85, 0.12)
status.Position = UDim2.fromScale(0.075, 0.48)
status.BackgroundTransparency = 1
status.Text = "OTHER PLAYER HAS ACCEPTED."
status.Font = Enum.Font.Gotham
status.TextSize = 13
status.TextColor3 = Color3.fromRGB(0, 255, 0)
status.TextXAlignment = Enum.TextXAlignment.Center
status.TextYAlignment = Enum.TextYAlignment.Center
status.Visible = false

forceBtn.MouseButton1Click:Connect(function()
	status.Visible = true
end)

local freezeBtn = makeButton("FREEZE TRADE", 0.64, Color3.fromRGB(90, 90, 90))
freezeBtn.MouseButton1Click:Connect(function()
	freezeTrade()
	freezeBtn.Text = frozen and "TRADE FROZEN" or "FREEZE TRADE"
end)

--------------------------------------------------
warn("[MM2 Trade Menu] Loaded successfully")
--------------------------------------------------

