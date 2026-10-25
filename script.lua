-- SANCH HUB v17 | Stable + Animations
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local camera = workspace.CurrentCamera

local oldGui = playerGui:FindFirstChild("SanchHub")
if oldGui then oldGui:Destroy() end

local gui = Instance.new("ScreenGui")
gui.Name = "SanchHub"
gui.ResetOnSpawn = false
gui.Parent = playerGui

-- ================= ГЛАВНОЕ ОКНО =================
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 480, 0, 320)
main.Position = UDim2.new(0.5, -240, 0.5, -160)
main.BackgroundColor3 = Color3.fromRGB(25, 10, 35)
main.BorderSizePixel = 0
main.ClipsDescendants = true
main.Parent = gui

Instance.new("UICorner", main).CornerRadius = UDim.new(0, 16)

local mainGradient = Instance.new("UIGradient")
mainGradient.Color = ColorSequence.new(Color3.fromRGB(35, 15, 50), Color3.fromRGB(15, 5, 25))
mainGradient.Rotation = 45
mainGradient.Parent = main

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(120, 50, 170)
stroke.Thickness = 1.5
stroke.Transparency = 0.3
stroke.Parent = main

-- ================= ЗАГОЛОВОК =================
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 42)
titleBar.BackgroundTransparency = 1
titleBar.Parent = main

-- Невидимая полоса для перетаскивания
local dragArea = Instance.new("Frame")
dragArea.Size = UDim2.new(1, -80, 1, 0)
dragArea.BackgroundTransparency = 0.99
dragArea.Active = true
dragArea.Parent = titleBar

local titleIcon = Instance.new("Frame")
titleIcon.Size = UDim2.new(0, 26, 0, 26)
titleIcon.Position = UDim2.new(0, 16, 0, 8)
titleIcon.BackgroundColor3 = Color3.fromRGB(120, 50, 180)
titleIcon.Parent = titleBar
Instance.new("UICorner", titleIcon).CornerRadius = UDim.new(0, 6)

local titleIconText = Instance.new("TextLabel")
titleIconText.Size = UDim2.new(1, 0, 1, 0)
titleIconText.BackgroundTransparency = 1
titleIconText.Text = "S"
titleIconText.Font = Enum.Font.GothamBlack
titleIconText.TextSize = 15
titleIconText.TextColor3 = Color3.fromRGB(255, 255, 255)
titleIconText.Parent = titleIcon

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -140, 1, 0)
titleLabel.Position = UDim2.new(0, 50, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "SANCH HUB"
titleLabel.TextSize = 17
titleLabel.Font = Enum.Font.GothamBlack
titleLabel.TextColor3 = Color3.fromRGB(230, 200, 255)
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = titleBar

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 28, 0, 28)
closeBtn.Position = UDim2.new(1, -38, 0, 7)
closeBtn.BackgroundColor3 = Color3.fromRGB(60, 15, 25)
closeBtn.Text = "×"
closeBtn.TextSize = 20
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextColor3 = Color3.fromRGB(255, 130, 130)
closeBtn.Parent = titleBar
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)

local minBtn = Instance.new("TextButton")
minBtn.Size = UDim2.new(0, 28, 0, 28)
minBtn.Position = UDim2.new(1, -72, 0, 7)
minBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 55)
minBtn.Text = "−"
minBtn.TextSize = 20
minBtn.Font = Enum.Font.GothamBold
minBtn.TextColor3 = Color3.fromRGB(200, 200, 255)
minBtn.Parent = titleBar
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 6)

-- ================= КНОПКА S (СВЕРНУТО) =================
local expandBtn = Instance.new("TextButton")
expandBtn.Size = UDim2.new(0, 50, 0, 50)
expandBtn.Position = UDim2.new(0, 20, 0, 20)
expandBtn.BackgroundColor3 = Color3.fromRGB(90, 30, 140)
expandBtn.Text = "S"
expandBtn.TextSize = 28
expandBtn.Font = Enum.Font.GothamBlack
expandBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
expandBtn.Visible = false
expandBtn.Parent = gui
Instance.new("UICorner", expandBtn).CornerRadius = UDim.new(0, 14)

-- ================= КОНТЕНТ =================
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -25, 1, -55)
contentFrame.Position = UDim2.new(0, 12, 0, 48)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = main

local tabs = Instance.new("Frame")
tabs.Size = UDim2.new(0, 100, 1, 0)
tabs.BackgroundTransparency = 1
tabs.Parent = contentFrame

local pageHolder = Instance.new("Frame")
pageHolder.Size = UDim2.new(1, -110, 1, 0)
pageHolder.Position = UDim2.new(0, 110, 0, 0)
pageHolder.BackgroundColor3 = Color3.fromRGB(30, 12, 42)
pageHolder.ClipsDescendants = true
pageHolder.Parent = contentFrame
Instance.new("UICorner", pageHolder).CornerRadius = UDim.new(0, 10)

-- ================= СТРАНИЦЫ =================
local pages = {}
local function makePage(name)
    local page = Instance.new("Frame")
    page.Name = name
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.Visible = false
    page.Parent = pageHolder
    pages[name] = page
    return page
end

local function addTitle(parent, text, y)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, -20, 0, 20)
    l.Position = UDim2.new(0, 12, 0, y)
    l.BackgroundTransparency = 1
    l.Text = text
    l.Font = Enum.Font.GothamBlack
    l.TextColor3 = Color3.fromRGB(180, 130, 230)
    l.TextSize = 12
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = parent
    return l
end

local function makeToggle(parent, text, y, callback, activeColor)
    activeColor = activeColor or Color3.fromRGB(120, 40, 180)
    local isOn = false
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -24, 0, 36)
    b.Position = UDim2.new(0, 12, 0, y)
    b.BackgroundColor3 = Color3.fromRGB(45, 20, 60)
    b.TextColor3 = Color3.fromRGB(220, 190, 255)
    b.Text = text .. ": OFF"
    b.TextSize = 13
    b.Font = Enum.Font.GothamBold
    b.Parent = parent
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 7)

    b.MouseButton1Click:Connect(function()
        isOn = not isOn
        b.Text = text .. ": " .. (isOn and "ON" or "OFF")
        
        -- Анимация переключения цвета
        TweenService:Create(b, TweenInfo.new(0.2), {
            BackgroundColor3 = isOn and activeColor or Color3.fromRGB(45, 20, 60)
        }):Play()
        
        callback(isOn)
    end)
    return b
end

local function makeSlider(parent, text, min, max, default, y, callback)
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Size = UDim2.new(1, -24, 0, 42)
    sliderFrame.Position = UDim2.new(0, 12, 0, y)
    sliderFrame.BackgroundColor3 = Color3.fromRGB(38, 16, 52)
    sliderFrame.Parent = parent
    Instance.new("UICorner", sliderFrame).CornerRadius = UDim.new(0, 7)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -15, 0, 16)
    label.Position = UDim2.new(0, 8, 0, 3)
    label.BackgroundTransparency = 1
    label.Text = text .. ": " .. default
    label.Font = Enum.Font.GothamBold
    label.TextColor3 = Color3.fromRGB(210, 170, 250)
    label.TextSize = 11
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = sliderFrame

    local bar = Instance.new("Frame")
    bar.Size = UDim2.new(1, -16, 0, 6)
    bar.Position = UDim2.new(0, 8, 0, 26)
    bar.BackgroundColor3 = Color3.fromRGB(20, 8, 30)
    bar.Parent = sliderFrame
    Instance.new("UICorner", bar).CornerRadius = UDim.new(0, 3)

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new(0, 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(160, 60, 220)
    fill.Parent = bar
    Instance.new("UICorner", fill).CornerRadius = UDim.new(0, 3)

    local knob = Instance.new("TextButton")
    knob.Size = UDim2.new(0, 12, 0, 12)
    knob.Position = UDim2.new(0, 0, 0.5, -6)
    knob.BackgroundColor3 = Color3.fromRGB(230, 170, 255)
    knob.Text = ""
    knob.Parent = bar
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

    local value = default
    local isDragging = false

    local function update(percent)
        percent = math.clamp(percent, 0, 1)
        fill.Size = UDim2.new(percent, 0, 1, 0)
        knob.Position = UDim2.new(percent, -6, 0.5, -6)
        value = math.floor(min + (max - min) * percent + 0.5)
        label.Text = text .. ": " .. value
        callback(value)
    end

    update((default - min) / (max - min))

    knob.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isDragging = true
        end
    end)

    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isDragging = false
        end
    end)

    bar.InputChanged:Connect(function(input)
        if not isDragging then return end
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            local relative = (input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X
            update(relative)
        end
    end)
    
    bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            local relative = (input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X
            update(relative)
            isDragging = true
        end
    end)
end

-- ================= ПОЛЁТ =================
local flyPage = makePage("Fly")
addTitle(flyPage, "FLY SETTINGS", 8)

local flying = false
local flySpeed = 50
local flyConn
local bv, bg

makeToggle(flyPage, "Fly", 32, function(state)
    flying = state
    local char = player.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    
    if flying then
        if not hrp or not hum then return end
        bv = Instance.new("BodyVelocity")
        bv.MaxForce = Vector3.new(1e6, 1e6, 1e6)
        bv.Velocity = Vector3.zero
        bv.Parent = hrp

        bg = Instance.new("BodyGyro")
        bg.MaxTorque = Vector3.new(1e6, 1e6, 1e6)
        bg.P = 5000
        bg.Parent = hrp
        
        hum.PlatformStand = true

        flyConn = RunService.RenderStepped:Connect(function()
            if not flying or not hrp.Parent then return end
            local moveDir = Vector3.zero
            if UIS:IsKeyDown(Enum.KeyCode.W) then moveDir += camera.CFrame.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.S) then moveDir -= camera.CFrame.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.A) then moveDir -= camera.CFrame.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.D) then moveDir += camera.CFrame.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.Space) then moveDir += Vector3.yAxis end
            if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then moveDir -= Vector3.yAxis end
            
            if hum and hum.MoveDirection.Magnitude > 0 then
                local camCFrame = camera.CFrame
                local localLR = camCFrame.RightVector:Dot(hum.MoveDirection)
                local localFB = camCFrame.LookVector:Dot(hum.MoveDirection)
                moveDir = (camCFrame.RightVector * localLR) + (camCFrame.LookVector * localFB)
            end

            if moveDir.Magnitude > 0 then
                bv.Velocity = moveDir.Unit * flySpeed
            else
                bv.Velocity = Vector3.zero
            end
            bg.CFrame = camera.CFrame
        end)
    else
        if flyConn then flyConn:Disconnect() end
        if bv then bv:Destroy() end
        if bg then bg:Destroy() end
        if hum then hum.PlatformStand = false end
    end
end, Color3.fromRGB(180, 40, 60))

makeSlider(flyPage, "Fly Speed", 10, 300, 50, 78, function(v) flySpeed = v end)

-- ================= СКОРОСТЬ =================
local speedPage = makePage("Speed")
addTitle(speedPage, "SPEED BOOST", 8)

local speedEnabled = false
local speedVal = 16

makeSlider(speedPage, "Speed", 16, 300, 16, 32, function(v)
    speedVal = v
    if speedEnabled then
        local char = player.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then hum.WalkSpeed = v end
        end
    end
end)

makeToggle(speedPage, "Speed Boost", 80, function(state)
    speedEnabled = state
    local char = player.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.WalkSpeed = state and speedVal or 16
        end
    end
end, Color3.fromRGB(40, 100, 200))

-- ================= ПРЫЖОК =================
local jumpPage = makePage("Jump")
addTitle(jumpPage, "JUMP BOOST", 8)

local jumpEnabled = false
local jumpVal = 50

makeSlider(jumpPage, "Jump Power", 50, 500, 50, 32, function(v)
    jumpVal = v
    if jumpEnabled then
        local char = player.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then
                hum.UseJumpPower = true
                hum.JumpPower = v
            end
        end
    end
end)

makeToggle(jumpPage, "Jump Boost", 80, function(state)
    jumpEnabled = state
    local char = player.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.UseJumpPower = true
            hum.JumpPower = state and jumpVal or 50
        end
    end
end, Color3.fromRGB(40, 160, 80))

local infConn
makeToggle(jumpPage, "Infinite Jump", 128, function(state)
    if state then
        infConn = UIS.JumpRequest:Connect(function()
            local char = player.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
            end
        end)
    else
        if infConn then
            infConn:Disconnect()
            infConn = nil
        end
    end
end, Color3.fromRGB(200, 100, 40))

-- ================= ЭМОЦИИ =================
local emotePage = makePage("Emotes")
addTitle(emotePage, "EMOTES", 8)

local emotes = {
    {"Wave", "/e wave"}, {"Cheer", "/e cheer"}, {"Laugh", "/e laugh"},
    {"Dance 1", "/e dance1"}, {"Dance 2", "/e dance2"}, {"Dance 3", "/e dance3"}
}

for i, data in ipairs(emotes) do
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -24, 0, 28)
    b.Position = UDim2.new(0, 12, 0, 32 + (i - 1) * 32)
    b.BackgroundColor3 = Color3.fromRGB(45, 20, 60)
    b.TextColor3 = Color3.fromRGB(220, 190, 255)
    b.Text = data[1]
    b.TextSize = 12
    b.Font = Enum.Font.GothamBold
    b.Parent = emotePage
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 7)

    b.MouseButton1Click:Connect(function()
        local char = player.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then
                game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(data[2], "All")
            end
        end
    end)
end

-- ================= ИНФО =================
local infoPage = makePage("Info")
addTitle(infoPage, "SANCH HUB", 12)
addTitle(infoPage, "v17 - Animations", 38)

-- ================= ВКЛАДКИ С АНИМАЦИЕЙ =================
local function addTab(name, y)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, 0, 0, 30)
    b.Position = UDim2.new(0, 0, 0, y)
    b.BackgroundTransparency = 1
    b.Text = name
    b.TextSize = 14
    b.Font = Enum.Font.GothamBlack
    b.TextColor3 = Color3.fromRGB(140, 80, 190)
    b.TextXAlignment = Enum.TextXAlignment.Left
    b.Parent = tabs

    local ind = Instance.new("Frame")
    ind.Size = UDim2.new(0, 3, 0, 16)
    ind.Position = UDim2.new(0, -8, 0.5, -8)
    ind.BackgroundColor3 = Color3.fromRGB(200, 120, 255)
    ind.BorderSizePixel = 0
    ind.Visible = false
    ind.Parent = b
    Instance.new("UICorner", ind).CornerRadius = UDim.new(1, 0)

    b.MouseButton1Click:Connect(function()
        -- Скрываем все страницы
        for _, page in pairs(pages) do
            page.Visible = false
        end
        
        -- Показываем нужную с анимацией
        local target = pages[name]
        target.Visible = true
        target.Position = UDim2.new(0, 15, 0, 0) -- Начинаем со смещением
        
        -- Плавно возвращаем на место
        TweenService:Create(target, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Position = UDim2.new(0, 0, 0, 0)
        }):Play()
        
        -- Обновляем вкладки
        for _, child in pairs(tabs:GetChildren()) do
            if child:IsA("TextButton") then
                child.TextColor3 = Color3.fromRGB(140, 80, 190)
                local i = child:FindFirstChildOfClass("Frame")
                if i and i ~= ind then i.Visible = false end
            end
        end
        b.TextColor3 = Color3.fromRGB(230, 180, 255)
        ind.Visible = true
    end)
    return b, ind
end

local tFly, iFly = addTab("Fly", 0)
addTab("Speed", 34)
addTab("Jump", 68)
addTab("Emotes", 102)
addTab("Info", 136)

pages.Fly.Visible = true
tFly.TextColor3 = Color3.fromRGB(230, 180, 255)
iFly.Visible = true

-- ================= СВОРАЧИВАНИЕ С АНИМАЦИЕЙ =================
minBtn.MouseButton1Click:Connect(function()
    TweenService:Create(main, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 0, 0, 0)
    }):Play()
    
    task.wait(0.2)
    main.Visible = false
    expandBtn.Visible = true
end)

expandBtn.MouseButton1Click:Connect(function()
    expandBtn.Visible = false
    main.Visible = true
    main.Size = UDim2.new(0, 0, 0, 0)
    
    TweenService:Create(main, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 480, 0, 320)
    }):Play()
end)

closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- ================= ПЕРЕТАСКИВАНИЕ =================
local dragging, dragStart, startPos

dragArea.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = main.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)
