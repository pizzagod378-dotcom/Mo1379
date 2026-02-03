local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local ContextActionService = game:GetService("ContextActionService")

local player = Players.LocalPlayer
local gui = player:WaitForChild("PlayerGui")

-- Functie om kick te triggeren
local function doKick()
    player:Kick("You got kicked because you pressed leave.")
end

-- Discord watermark functie
local function createWatermark(parent, yPos)
    local watermark = Instance.new("TextLabel")
    watermark.Size = UDim2.new(1, 0, 0, 15)
    watermark.Position = UDim2.new(0, 0, 0, yPos)
    watermark.BackgroundTransparency = 1
    watermark.Text = "Discord: iliketrustles"
    watermark.Font = Enum.Font.Gotham
    watermark.TextSize = 12
    watermark.TextColor3 = Color3.fromRGB(220,220,220)
    watermark.TextXAlignment = Enum.TextXAlignment.Center
    watermark.Parent = parent
end

-- Detect platform
if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled then
    -- MOBIEL UI
    local frame = Instance.new("Frame")
    frame.Size = UDim2.fromOffset(150, 50)
    frame.Position = UDim2.fromScale(0.5, 0.85)
    frame.AnchorPoint = Vector2.new(0.5,0.5)
    frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
    frame.BorderSizePixel = 0
    frame.Parent = gui

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.fromScale(1,1)
    btn.Position = UDim2.new(0,0,0,0)
    btn.BackgroundColor3 = Color3.fromRGB(45,45,45)
    btn.Text = "Leave"
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Parent = frame

    btn.MouseButton1Click:Connect(doKick)

    createWatermark(frame, 52) -- Discord onder knop

else
    -- PC UI
    local leaveKey = Enum.KeyCode.L
    local waitingForKey = false

    local frame = Instance.new("Frame")
    frame.Size = UDim2.fromOffset(180,85)
    frame.Position = UDim2.fromScale(0.7,0.5)
    frame.AnchorPoint = Vector2.new(0.5,0.5)
    frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
    frame.BorderSizePixel = 0
    frame.Active = true
    frame.Draggable = true
    frame.Parent = gui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0,12)
    corner.Parent = frame

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1,0,0,22)
    title.Position = UDim2.new(0,0,0,2)
    title.BackgroundTransparency = 1
    title.Text = "Leave Key"
    title.Font = Enum.Font.GothamBold
    title.TextSize = 14
    title.TextColor3 = Color3.fromRGB(255,255,255)
    title.Parent = frame

    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1,-20,0,30)
    button.Position = UDim2.new(0,10,0,24)
    button.BackgroundColor3 = Color3.fromRGB(45,45,45)
    button.Text = leaveKey.Name
    button.Font = Enum.Font.Gotham
    button.TextSize = 14
    button.TextColor3 = Color3.fromRGB(255,255,255)
    button.Parent = frame

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0,8)
    btnCorner.Parent = button

    createWatermark(frame, 56)

    button.MouseButton1Click:Connect(function()
        waitingForKey = true
        button.Text = "Press key..."
    end)

    local function leaveAction(_, state)
        if state == Enum.UserInputState.Begin then
            doKick()
        end
    end

    ContextActionService:BindActionAtPriority(
        "InstantLeave",
        leaveAction,
        false,
        Enum.ContextActionPriority.High.Value,
        leaveKey
    )

    UserInputService.InputBegan:Connect(function(input,gp)
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
end
