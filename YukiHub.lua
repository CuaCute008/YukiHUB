    button.TextSize = 12
    button.Activated:Connect(callback)
end

local function showPage(name)
    currentTab = name
    clearPage()

    for tabName, button in pairs(tabButtons) do
        button.BackgroundColor3 = tabName == name and C.cyanDark or C.dark
    end

    if name == "Main" then
        addInfo("Các công tắc bên dưới là mẫu giao diện. Chúng chưa tự động chơi hoặc tác động vào Blox Fruits.")
        for _, item in ipairs(pages.Main) do addToggle(item .. " (demo)") end
    elseif name == "Visual" then
        addInfo("Mục minh họa giao diện hiển thị. Chỉ triển khai ESP trong trải nghiệm Roblox do bạn sở hữu hoặc được phép chỉnh sửa.")
        for _, item in ipairs(pages.Visual) do addToggle(item) end
    elseif name == "Teleport" then
        addInfo("Các nút vị trí là mẫu. Có thể nối với các điểm dịch chuyển được thiết kế trong trải nghiệm Roblox của bạn.")
        addAction("Save current position (demo)", function()
            local character = player.Character
            local root = character and character:FindFirstChild("HumanoidRootPart")
            if root then
                player:SetAttribute("YukiSavedX", root.Position.X)
                player:SetAttribute("YukiSavedY", root.Position.Y)
                player:SetAttribute("YukiSavedZ", root.Position.Z)
            end
        end)
        addAction("Return to saved position (demo)", function()
            local x, y, z = player:GetAttribute("YukiSavedX"), player:GetAttribute("YukiSavedY"), player:GetAttribute("YukiSavedZ")
            local character = player.Character
            local root = character and character:FindFirstChild("HumanoidRootPart")
            if root and x and y and z then
                root.CFrame = CFrame.new(x, y, z)
            end
        end)
        addAction("Island list (demo)", function() end)
    elseif name == "Settings" then
        addInfo("Tùy chỉnh cửa sổ YUKI HUB.")
        addAction("Toggle compact size", function()
            compact = not compact
            main.Size = compact and UDim2.fromOffset(310, 350) or UDim2.fromOffset(350, 420)
        end)
        addAction("Toggle panel transparency", function()
            body.BackgroundTransparency = body.BackgroundTransparency == 0 and 0.18 or 0
        end)
        addAction("Reset window position", function()
            main.Position = UDim2.new(0.5, 0, 0.5, 0)
        end)
    end

    updateCanvas()
end

for index, name in ipairs({"Main", "Visual", "Teleport", "Settings"}) do
    local tab = makeButton(tabBar, name, UDim2.new(0.25, -4, 1, 0), UDim2.new(), C.dark)
    tab.Name = name .. "Tab"
    tab.TextSize = 10
    tab.LayoutOrder = index
    tabButtons[name] = tab
    tab.Activated:Connect(function() showPage(name) end)
end

local reopen = makeButton(gui, "YUKI", UDim2.fromOffset(92, 38), UDim2.new(0, 14, 0.5, -19), C.cyan)
reopen.Name = "ReopenButton"
reopen.Visible = false
reopen.TextSize = 13

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

-- Drag the window by touching/clicking the cyan title bar.
local dragging = false
local dragStart
local startPosition

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
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

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(
            startPosition.X.Scale, startPosition.X.Offset + delta.X,
            startPosition.Y.Scale, startPosition.Y.Offset + delta.Y
        )
    end
end)

showPage("Main")
