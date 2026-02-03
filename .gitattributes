-- Services
local Players = game:GetService("Players")
local ContextActionService = game:GetService("ContextActionService")

local player = Players.LocalPlayer

local leaveKey = Enum.KeyCode.L
local waitingForKey = false

-- GUI
local gui = Instance.new("ScreenGui")
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.fromOffset(170, 65)
frame.Position = UDim2.fromScale(0.5, 0.5)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 22)
title.BackgroundTransparency = 1
title.Text = "Leave Key"
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Parent = frame

local button = Instance.new("TextButton")
button.Size = UDim2.new(1, -20, 0, 30)
button.Position = UDim2.new(0, 10, 0, 28)
button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
button.Text = leaveKey.Name
button.Font = Enum.Font.Gotham
button.TextSize = 14
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Parent = frame

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 8)
btnCorner.Parent = button

-- Key select
button.MouseButton1Click:Connect(function()
	waitingForKey = true
	button.Text = "Press key..."
end)

-- Action
local function leaveAction(_, state)
	if state == Enum.UserInputState.Begin then
		player:Kick("You got kicked because you pressed leave.")
	end
end

-- Input binding
ContextActionService:BindActionAtPriority(
	"InstantLeave",
	leaveAction,
	false,
	Enum.ContextActionPriority.High.Value,
	leaveKey
)

-- Rebind when key changes
local UserInputService = game:GetService("UserInputService")
UserInputService.InputBegan:Connect(function(input, gp)
	if gp or not waitingForKey then return end
	if input.KeyCode == Enum.KeyCode.Unknown then return end

	ContextActionService:UnbindAction("InstantLeave")
	leaveKey = input.KeyCode
	button.Text = leaveKey.Name
	waitingForKey = false

	ContextActionService:BindActionAtPriority(
		"InstantLeave",
		leaveAction,
		false,
		Enum.ContextActionPriority.High.Value,
		leaveKey
	)
end)
