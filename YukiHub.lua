--[[
    YUKI HUB - Cyan Mobile UI
    Safe Roblox Studio interface template.
    This is a UI/demo template; buttons do not automate or exploit Blox Fruits.

    Place this LocalScript in StarterPlayerScripts or StarterGui in your own Roblox experience.
]]

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local old = playerGui:FindFirstChild("YukiHub")
if old then old:Destroy() end

local CYAN = Color3.fromRGB(24, 198, 213)
local CYAN_DARK = Color3.fromRGB(12, 135, 150)
local PANEL = Color3.fromRGB(235, 250, 251)
local DARK = Color3.fromRGB(55, 68, 75)
local WHITE = Color3.fromRGB(255, 255, 255)
local MUTED = Color3.fromRGB(105, 125, 132)

local gui = Instance.new("ScreenGui")
gui.Name = "YukiHub"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = false
gui.Parent = playerGui

local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.fromOffset(330, 390)
main.Position = UDim2.new(0.5, -165, 0.5, -195)
main.BackgroundColor3 = CYAN
main.BorderSizePixel = 0
main.Parent = gui
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 16)

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = CYAN_DARK
mainStroke.Thickness = 1.5
mainStroke.Parent = main

local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 58)
header.BackgroundTransparency = 1
header.Parent = main

local title = Instance.new("TextLabel")
title.BackgroundTransparency = 1
title.Position = UDim2.fromOffset(16, 7)
title.Size = UDim2.new(1, -110, 0, 27)
title.Font = Enum.Font.GothamBold
title.Text = "YUKI HUB"
title.TextColor3 = WHITE
title.TextSize = 22
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

local subtitle = Instance.new("TextLabel")
subtitle.BackgroundTransparency = 1
subtitle.Position = UDim2.fromOffset(17, 33)
subtitle.Size = UDim2.new(1, -110, 0, 16)
subtitle.Font = Enum.Font.Gotham
subtitle.Text = "BLOX FRUITS • MOBILE UI"
subtitle.TextColor3 = WHITE
subtitle.TextTransparency = 0.12
subtitle.TextSize = 10
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.Parent = header

local minimize = Instance.new("TextButton")
minimize.Size = UDim2.fromOffset(34, 30)
minimize.Position = UDim2.new(1, -82, 0, 13)
minimize.BackgroundColor3 = DARK
minimize.Text = "—"
minimize.TextColor3 = WHITE
minimize.Font = Enum.Font.GothamBold
minimize.TextSize = 18
minimize.Parent = header
Instance.new("UICorner", minimize).CornerRadius = UDim.new(0, 8)

local close = Instance.new("TextButton")
close.Size = UDim2.fromOffset(34, 30)
close.Position = UDim2.new(1, -42, 0, 13)
close.BackgroundColor3 = DARK
close.Text = "×"
close.TextColor3 = WHITE
close.Font = Enum.Font.GothamBold
close.TextSize = 20
close.Parent = header
Instance.new("UICorner", close).CornerRadius = UDim.new(0, 8)

local body = Instance.new("Frame")
body.Position = UDim2.fromOffset(10, 58)
body.Size = UDim2.new(1, -20, 1, -68)
body.BackgroundColor3 = PANEL
body.BorderSizePixel = 0
body.Parent = main
Instance.new("UICorner", body).CornerRadius = UDim.new(0, 12)

local tabs = Instance.new("Frame")
tabs.Position = UDim2.fromOffset(9, 9)
tabs.Size = UDim2.new(1, -18, 0, 34)
tabs.BackgroundTransparency = 1
tabs.Parent = body

local tabLayout = Instance.new("UIListLayout")
tabLayout.FillDirection = Enum.FillDirection.Horizontal
tabLayout.Padding = UDim.new(0, 5)
tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
tabLayout.Parent = tabs

local content = Instance.new("ScrollingFrame")
content.Position = UDim2.fromOffset(9, 51)
content.Size = UDim2.new(1, -18, 1, -60)
content.BackgroundTransparency = 1
content.BorderSizePixel = 0
content.ScrollBarThickness = 3
content.ScrollBarImageColor3 = CYAN_DARK
content.CanvasSize = UDim2.new(0, 0, 0, 0)
content.Parent = body

local list = Instance.new("UIListLayout")
list.Padding = UDim.new(0, 7)
list.SortOrder = Enum.SortOrder.LayoutOrder
list.Parent = content

local pages = {
    Main = {"Auto Farm (demo)", "Auto Quest (demo)", "Auto Raid (demo)"},
    Visual = {"ESP Player (demo)", "Fruit Finder (demo)"},
    Travel = {"Teleport Island (demo)"},
    Info = {"YUKI HUB", "UI template for your own Roblox experience"}
}

local activeTab = nil
local tabButtons = {}

local function clearContent()
    for _, child in ipairs(content:GetChildren()) do
        if child ~= list then child:Destroy() end
    end
end

local function updateCanvas()
    content.CanvasSize = UDim2.new(0, 0, 0, list.AbsoluteContentSize.Y + 8)
end
list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateCanvas)

local function showPage(tabName)
    activeTab = tabName
    clearContent()

    for name, button in pairs(tabButtons) do
        button.BackgroundColor3 = (name == tabName) and CYAN_DARK or DARK
    end

    for _, labelText in ipairs(pages[tabName]) do
        local row = Instance.new("Frame")
        row.Size = UDim2.new(1, -2, 0, 48)
        row.BackgroundColor3 = DARK
        row.BorderSizePixel = 0
        row.Parent = content
        Instance.new("UICorner", row).CornerRadius = UDim.new(0, 9)

        local label = Instance.new("TextLabel")
        label.BackgroundTransparency = 1
        label.Position = UDim2.fromOffset(12, 0)
        label.Size = UDim2.new(1, -95, 1, 0)
        label.Font = Enum.Font.GothamMedium
        label.Text = labelText
        label.TextColor3 = WHITE
        label.TextSize = 13
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = row

        local toggle = Instance.new("TextButton")
        toggle.Size = UDim2.fromOffset(62, 28)
        toggle.Position = UDim2.new(1, -72, 0.5, -14)
        toggle.BackgroundColor3 = Color3.fromRGB(105, 119, 125)
        toggle.Text = "OFF"
        toggle.TextColor3 = WHITE
        toggle.TextSize = 11
        toggle.Font = Enum.Font.GothamBold
        toggle.Parent = row
        Instance.new("UICorner", toggle).CornerRadius = UDim.new(0, 7)

        local enabled = false
        toggle.Activated:Connect(function()
            enabled = not enabled
            toggle.Text = enabled and "ON" or "OFF"
            toggle.BackgroundColor3 = enabled and CYAN or Color3.fromRGB(105, 119, 125)
            -- Demo only: no game automation or exploit action is attached.
        end)
    end
    updateCanvas()
end

for index, tabName in ipairs({"Main", "Visual", "Travel", "Info"}) do
    local button = Instance.new("TextButton")
    button.Name = tabName .. "Tab"
    button.Size = UDim2.new(0.25, -4, 1, 0)
    button.BackgroundColor3 = DARK
    button.Text = tabName
    button.TextColor3 = WHITE
    button.TextSize = 11
    button.Font = Enum.Font.GothamBold
    button.LayoutOrder = index
    button.Parent = tabs
    Instance.new("UICorner", button).CornerRadius = UDim.new(0, 7)
    tabButtons[tabName] = button
    button.Activated:Connect(function() showPage(tabName) end)
end

local reopen = Instance.new("TextButton")
reopen.Name = "Reopen"
reopen.Size = UDim2.fromOffset(112, 40)
reopen.Position = UDim2.new(0, 16, 0.5, -20)
reopen.BackgroundColor3 = CYAN
reopen.Text = "YUKI HUB"
reopen.TextColor3 = WHITE
reopen.TextSize = 14
reopen.Font = Enum.Font.GothamBold
reopen.Visible = false
reopen.Parent = gui
Instance.new("UICorner", reopen).CornerRadius = UDim.new(0, 10)

minimize.Activated:Connect(function()
    main.Visible = false
    reopen.Visible = true
end)
reopen.Activated:Connect(function()
    main.Visible = true
    reopen.Visible = false
end)
close.Activated:Connect(function()
    gui:Destroy()
end)

-- Drag the hub by its header; touch and mouse are supported.
local dragging = false
local dragInput, dragStart, startPosition

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPosition = main.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

header.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input == dragInput or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(
            startPosition.X.Scale, startPosition.X.Offset + delta.X,
            startPosition.Y.Scale, startPosition.Y.Offset + delta.Y
        )
    end
end)

showPage("Main")
