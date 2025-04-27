-- Ultimate Garden Bot v8 (All-in-One)
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local mouse = player:GetMouse()

-- Ожидание загрузки
if not game:IsLoaded() then game.Loaded:Wait() end
task.wait(2)

-- Точки телепортации
local TeleportPoints = {
    ["Shop Seed"] = CFrame.new(59, 3, -27),
    ["Sell"] = CFrame.new(60, 3, 1),
    ["Gear Shop"] = CFrame.new(-260, 3, -27),
    ["Quest"] = CFrame.new(-261, 3, -1)
}

-- Создание GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GardenBotUltimate"
ScreenGui.Parent = game:GetService("CoreGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 350, 0, 300)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(40, 80, 40)
MainFrame.BackgroundTransparency = 0.1
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Text = "🌱"
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Position = UDim2.new(0, 10, 0.5, -25)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(60, 110, 60)
ToggleBtn.TextColor3 = Color3.new(1, 1, 1)
ToggleBtn.TextSize = 24
ToggleBtn.ZIndex = 2
ToggleBtn.Parent = ScreenGui

-- Вкладки
local TabButtons = Instance.new("Frame")
TabButtons.Size = UDim2.new(1, 0, 0, 30)
TabButtons.BackgroundTransparency = 1
TabButtons.Parent = MainFrame

local FarmTabBtn = Instance.new("TextButton")
FarmTabBtn.Text = "Farming"
FarmTabBtn.Size = UDim2.new(0.33, 0, 1, 0)
FarmTabBtn.Position = UDim2.new(0, 0, 0, 0)
FarmTabBtn.BackgroundColor3 = Color3.fromRGB(60, 110, 60)
FarmTabBtn.TextColor3 = Color3.new(1, 1, 1)
FarmTabBtn.Parent = TabButtons

local TeleportTabBtn = Instance.new("TextButton")
TeleportTabBtn.Text = "Teleports"
TeleportTabBtn.Size = UDim2.new(0.33, 0, 1, 0)
TeleportTabBtn.Position = UDim2.new(0.33, 0, 0, 0)
TeleportTabBtn.BackgroundColor3 = Color3.fromRGB(40, 70, 40)
TeleportTabBtn.TextColor3 = Color3.new(1, 1, 1)
TeleportTabBtn.Parent = TabButtons

local MoveTabBtn = Instance.new("TextButton")
MoveTabBtn.Text = "Moveset"
MoveTabBtn.Size = UDim2.new(0.34, 0, 1, 0)
MoveTabBtn.Position = UDim2.new(0.66, 0, 0, 0)
MoveTabBtn.BackgroundColor3 = Color3.fromRGB(40, 70, 40)
MoveTabBtn.TextColor3 = Color3.new(1, 1, 1)
MoveTabBtn.Parent = TabButtons

-- Фреймы вкладок
local FarmFrame = Instance.new("Frame")
FarmFrame.Size = UDim2.new(1, 0, 1, -30)
FarmFrame.Position = UDim2.new(0, 0, 0, 30)
FarmFrame.BackgroundTransparency = 1
FarmFrame.Visible = true
FarmFrame.Parent = MainFrame

local TeleportFrame = Instance.new("Frame")
TeleportFrame.Size = UDim2.new(1, 0, 1, -30)
TeleportFrame.Position = UDim2.new(0, 0, 0, 30)
TeleportFrame.BackgroundTransparency = 1
TeleportFrame.Visible = false
TeleportFrame.Parent = MainFrame

local MoveFrame = Instance.new("Frame")
MoveFrame.Size = UDim2.new(1, 0, 1, -30)
MoveFrame.Position = UDim2.new(0, 0, 0, 30)
MoveFrame.BackgroundTransparency = 1
MoveFrame.Visible = false
MoveFrame.Parent = MainFrame

-- Вкладка Farming
local SeedBox = Instance.new("TextBox")
SeedBox.PlaceholderText = "Seed name (e.g. Carrot Seed)"
SeedBox.Size = UDim2.new(0.9, 0, 0, 30)
SeedBox.Position = UDim2.new(0.05, 0, 0.1, 0)
SeedBox.ClearTextOnFocus = false
SeedBox.TextColor3 = Color3.new(1, 1, 1)
SeedBox.Parent = FarmFrame

local AutoCollectBtn = Instance.new("TextButton")
AutoCollectBtn.Text = "COLLECT: OFF"
AutoCollectBtn.Size = UDim2.new(0.45, 0, 0, 35)
AutoCollectBtn.Position = UDim2.new(0.05, 0, 0.3, 0)
AutoCollectBtn.Name = "AutoCollect"
AutoCollectBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 180)
AutoCollectBtn.TextColor3 = Color3.new(1, 1, 1)
AutoCollectBtn.Font = Enum.Font.SourceSansBold
AutoCollectBtn.Parent = FarmFrame

local AutoPlantBtn = Instance.new("TextButton")
AutoPlantBtn.Text = "PLANT: OFF"
AutoPlantBtn.Size = UDim2.new(0.45, 0, 0, 35)
AutoPlantBtn.Position = UDim2.new(0.5, 0, 0.3, 0)
AutoPlantBtn.Name = "AutoPlant"
AutoPlantBtn.BackgroundColor3 = Color3.fromRGB(80, 180, 80)
AutoPlantBtn.TextColor3 = Color3.new(1, 1, 1)
AutoPlantBtn.Font = Enum.Font.SourceSansBold
AutoPlantBtn.Parent = FarmFrame

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Text = "READY"
StatusLabel.Size = UDim2.new(0.9, 0, 0, 20)
StatusLabel.Position = UDim2.new(0.05, 0, 0.9, 0)
StatusLabel.BackgroundTransparency = 1
StatusLabel.TextColor3 = Color3.new(0.8, 1, 0.8)
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.Font = Enum.Font.SourceSansSemibold
StatusLabel.Parent = FarmFrame

-- Вкладка Teleports
local TpToolBtn = Instance.new("TextButton")
TpToolBtn.Text = "Enable Teleport Tool"
TpToolBtn.Size = UDim2.new(0.9, 0, 0, 40)
TpToolBtn.Position = UDim2.new(0.05, 0, 0.05, 0)
TpToolBtn.BackgroundColor3 = Color3.fromRGB(120, 80, 180)
TpToolBtn.TextColor3 = Color3.new(1, 1, 1)
TpToolBtn.Parent = TeleportFrame

local yPos = 0.15
for name, _ in pairs(TeleportPoints) do
    local btn = Instance.new("TextButton")
    btn.Text = name
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.Position = UDim2.new(0.05, 0, yPos, 0)
    btn.BackgroundColor3 = Color3.fromRGB(70, 120, 70)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Parent = TeleportFrame
    yPos = yPos + 0.12
end

-- Вкладка Moveset
local SpeedSlider = Instance.new("TextBox")
SpeedSlider.PlaceholderText = "Walk Speed (16-1000)"
SpeedSlider.Size = UDim2.new(0.9, 0, 0, 30)
SpeedSlider.Position = UDim2.new(0.05, 0, 0.1, 0)
SpeedSlider.Text = "16"
SpeedSlider.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
SpeedSlider.TextColor3 = Color3.new(1, 1, 1)
SpeedSlider.Parent = MoveFrame

local JumpSlider = Instance.new("TextBox")
JumpSlider.PlaceholderText = "Jump Power (50-1000)"
JumpSlider.Size = UDim2.new(0.9, 0, 0, 30)
JumpSlider.Position = UDim2.new(0.05, 0, 0.25, 0)
JumpSlider.Text = "50"
JumpSlider.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
JumpSlider.TextColor3 = Color3.new(1, 1, 1)
JumpSlider.Parent = MoveFrame

local NoclipToggle = Instance.new("TextButton")
NoclipToggle.Text = "Noclip: OFF"
NoclipToggle.Size = UDim2.new(0.9, 0, 0, 35)
NoclipToggle.Position = UDim2.new(0.05, 0, 0.4, 0)
NoclipToggle.BackgroundColor3 = Color3.fromRGB(180, 80, 80)
NoclipToggle.TextColor3 = Color3.new(1, 1, 1)
NoclipToggle.Parent = MoveFrame

local InfJumpToggle = Instance.new("TextButton")
InfJumpToggle.Text = "Infinite Jump: OFF"
InfJumpToggle.Size = UDim2.new(0.9, 0, 0, 35)
InfJumpToggle.Position = UDim2.new(0.05, 0, 0.55, 0)
InfJumpToggle.BackgroundColor3 = Color3.fromRGB(80, 180, 80)
InfJumpToggle.TextColor3 = Color3.new(1, 1, 1)
InfJumpToggle.Parent = MoveFrame

-- Состояние бота
local bot = {
    collect = {
        active = false,
        keypress = false,
        cooldown = 0.3
    },
    plant = {
        active = false,
        lastAction = 0,
        cooldown = 1.5,
        seed = nil
    },
    tpTool = false,
    moveset = {
        speed = 16,
        jump = 50,
        noclip = false,
        infJump = false
    }
}

-- Обновление статуса
local function updateStatus(msg, color)
    StatusLabel.Text = msg
    StatusLabel.TextColor3 = color or Color3.new(0.8, 1, 0.8)
end

-- Поиск семени с улучшенной логикой
local function findSeed()
    local seedName = SeedBox.Text:gsub("%[.+%]", ""):match("%S.+"):gsub("%s+$", "")
    if not seedName or seedName == "" then return nil end
    
    -- Проверка экипированного инструмента
    local character = player.Character
    if character then
        for _, tool in ipairs(character:GetChildren()) do
            if tool:IsA("Tool") then
                local toolName = tool.Name:gsub("%[.+%]", ""):match("%S.+"):gsub("%s+$", "")
                if toolName == seedName then
                    return tool
                end
            end
        end
    end
    
    -- Поиск в инвентаре
    local backpack = player:FindFirstChild("Backpack")
    if backpack then
        for _, item in ipairs(backpack:GetChildren()) do
            local itemName = item.Name:gsub("%[.+%]", ""):match("%S.+"):gsub("%s+$", "")
            if itemName == seedName then
                return item
            end
        end
    end
    
    return nil
end

-- Авто-сбор (спам E)
local function autoCollect()
    if not bot.collect.active then return end
    
    if not bot.collect.keypress then
        bot.collect.keypress = true
        game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.E, false, game)
        task.delay(0.1, function()
            game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.E, false, game)
            bot.collect.keypress = false
        end)
    end
end

-- Улучшенный авто-посев
local function autoPlant()
    if not bot.plant.active or tick() - bot.plant.lastAction < bot.plant.cooldown then return end
    
    local seedTool = findSeed()
    if not seedTool then
        updateStatus("SEED NOT FOUND", Color3.new(1, 0.6, 0.6))
        return
    end
    
    local character = player.Character
    if not character then return end
    
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid then return end
    
    local root = character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    -- Экипировка с проверкой
    if not character:FindFirstChild(seedTool.Name) then
        humanoid:EquipTool(seedTool)
        bot.plant.lastAction = tick()
        task.wait(0.8) -- Увеличенное время для экипировки
        
        if not character:FindFirstChild(seedTool.Name) then
            updateStatus("EQUIP FAILED", Color3.new(1, 0.6, 0.6))
            return
        end
    end
    
    -- Позиция для посадки (2 блока вперед)
    local lookVector = root.CFrame.LookVector
    local plantPos = root.Position + (lookVector * 6) - Vector3.new(0, 2.5, 0)
    
    -- Имитация клика
    mouse.TargetFilter = workspace
    mouse.TargetSurface = Enum.NormalId.Top
    mouse.Hit = CFrame.new(plantPos)
    
    -- Активация с несколькими попытками
    local tool = character:FindFirstChild(seedTool.Name)
    if tool then
        for i = 1, 3 do
            tool:Activate()
            task.wait(0.1)
        end
        updateStatus("PLANTING "..seedTool.Name:gsub("%[.+%]", ""), Color3.new(0.6, 1, 0.8))
        bot.plant.lastAction = tick()
    else
        updateStatus("TOOL LOST", Color3.new(1, 0.6, 0.6))
    end
end

-- Телепорт инструмент
local function setupTpTool()
    if bot.tpTool then
        updateStatus("EXECUTING TP TOOL...", Color3.new(0.8, 0.8, 1))
        
        -- Удаление старого инструмента
        local backpack = player:FindFirstChild("Backpack")
        if backpack then
            local oldTool = backpack:FindFirstChild("TpTool")
            if oldTool then oldTool:Destroy() end
        end
        
        -- Создание нового инструмента
        local tool = Instance.new("Tool")
        tool.Name = "TpTool"
        tool.RequiresHandle = false
        tool.Parent = player.Backpack
        
        tool.Activated:Connect(function()
            local pos = mouse.Hit + Vector3.new(0, 2.5, 0)
            pos = CFrame.new(pos.X, pos.Y, pos.Z)
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.CFrame = pos
            end
        end)
    else
        local backpack = player:FindFirstChild("Backpack")
        if backpack then
            local tool = backpack:FindFirstChild("TpTool")
            if tool then tool:Destroy() end
        end
        updateStatus("TP TOOL DISABLED", Color3.new(1, 0.6, 0.6))
    end
end

-- Телепорт к точкам
local function teleportToPoint(pointName)
    local cf = TeleportPoints[pointName]
    if cf and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = cf
        updateStatus("Teleported to "..pointName, Color3.new(0.8, 1, 0.8))
    end
end

-- Обновление характеристик
local function updateMoveset()
    local character = player.Character
    if not character then return end
    
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid then return end
    
    humanoid.WalkSpeed = bot.moveset.speed
    humanoid.JumpPower = bot.moveset.jump
    
    if bot.moveset.noclip then
        for _, part in ipairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end

-- Настройка бесконечных прыжков
local function setupInfJump()
    if bot.moveset.infJump then
        UIS.JumpRequest:Connect(function()
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid:ChangeState("Jumping")
            end
        end)
    end
end

-- Обработчики кнопок
ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
    ToggleBtn.Text = MainFrame.Visible and "✕" or "🌱"
end)

-- Переключение вкладок
FarmTabBtn.MouseButton1Click:Connect(function()
    FarmFrame.Visible = true
    TeleportFrame.Visible = false
    MoveFrame.Visible = false
    FarmTabBtn.BackgroundColor3 = Color3.fromRGB(60, 110, 60)
    TeleportTabBtn.BackgroundColor3 = Color3.fromRGB(40, 70, 40)
    MoveTabBtn.BackgroundColor3 = Color3.fromRGB(40, 70, 40)
end)

TeleportTabBtn.MouseButton1Click:Connect(function()
    FarmFrame.Visible = false
    TeleportFrame.Visible = true
    MoveFrame.Visible = false
    FarmTabBtn.BackgroundColor3 = Color3.fromRGB(40, 70, 40)
    TeleportTabBtn.BackgroundColor3 = Color3.fromRGB(60, 110, 60)
    MoveTabBtn.BackgroundColor3 = Color3.fromRGB(40, 70, 40)
end)

MoveTabBtn.MouseButton1Click:Connect(function()
    FarmFrame.Visible = false
    TeleportFrame.Visible = false
    MoveFrame.Visible = true
    FarmTabBtn.BackgroundColor3 = Color3.fromRGB(40, 70, 40)
    TeleportTabBtn.BackgroundColor3 = Color3.fromRGB(40, 70, 40)
    MoveTabBtn.BackgroundColor3 = Color3.fromRGB(60, 110, 60)
end)

AutoCollectBtn.MouseButton1Click:Connect(function()
    bot.collect.active = not bot.collect.active
    AutoCollectBtn.Text = "COLLECT: " .. (bot.collect.active and "ON" or "OFF")
    AutoCollectBtn.BackgroundColor3 = bot.collect.active and Color3.fromRGB(60, 140, 255) or Color3.fromRGB(80, 80, 180)
    updateStatus(bot.collect.active and "COLLECTING (E SPAM)" or "READY")
end)

AutoPlantBtn.MouseButton1Click:Connect(function()
    bot.plant.active = not bot.plant.active
    AutoPlantBtn.Text = "PLANT: " .. (bot.plant.active and "ON" or "OFF")
    AutoPlantBtn.BackgroundColor3 = bot.plant.active and Color3.fromRGB(60, 255, 100) or Color3.fromRGB(80, 180, 80)
    bot.plant.seed = nil
    updateStatus(bot.plant.active and "PLANTING MODE" or "READY")
end)

TpToolBtn.MouseButton1Click:Connect(function()
    bot.tpTool = not bot.tpTool
    TpToolBtn.Text = bot.tpTool and "Disable Teleport Tool" or "Enable Teleport Tool"
    TpToolBtn.BackgroundColor3 = bot.tpTool and Color3.fromRGB(180, 80, 180) or Color3.fromRGB(120, 80, 180)
    setupTpTool()
end)

-- Обработчики телепортов
for _, btn in ipairs(TeleportFrame:GetChildren()) do
    if btn:IsA("TextButton") and btn ~= TpToolBtn then
        btn.MouseButton1Click:Connect(function()
            teleportToPoint(btn.Text)
        end)
    end
end

-- Обработчики Moveset
SpeedSlider.FocusLost:Connect(function()
    local num = tonumber(SpeedSlider.Text)
    if num and num >= 16 and num <= 1000 then
        bot.moveset.speed = num
        updateMoveset()
        updateStatus("Speed set to "..num, Color3.new(0.8, 1, 0.8))
    else
        SpeedSlider.Text = tostring(bot.moveset.speed)
    end
end)

JumpSlider.FocusLost:Connect(function()
    local num = tonumber(JumpSlider.Text)
    if num and num >= 50 and num <= 1000 then
        bot.moveset.jump = num
        updateMoveset()
        updateStatus("Jump power set to "..num, Color3.new(0.8, 1, 0.8))
    else
        JumpSlider.Text = tostring(bot.moveset.jump)
    end
end)

NoclipToggle.MouseButton1Click:Connect(function()
    bot.moveset.noclip = not bot.moveset.noclip
    NoclipToggle.Text = "Noclip: " .. (bot.moveset.noclip and "ON" or "OFF")
    NoclipToggle.BackgroundColor3 = bot.moveset.noclip and Color3.fromRGB(255, 80, 80) or Color3.fromRGB(180, 80, 80)
    updateMoveset()
    updateStatus("Noclip "..(bot.moveset.noclip and "enabled" or "disabled"), bot.moveset.noclip and Color3.new(1, 0.6, 0.6) or Color3.new(0.8, 1, 0.8))
end)

InfJumpToggle.MouseButton1Click:Connect(function()
    bot.moveset.infJump = not bot.moveset.infJump
    InfJumpToggle.Text = "Infinite Jump: " .. (bot.moveset.infJump and "ON" or "OFF")
    InfJumpToggle.BackgroundColor3 = bot.moveset.infJump and Color3.fromRGB(80, 255, 80) or Color3.fromRGB(80, 180, 80)
    setupInfJump()
    updateStatus("Infinite Jump "..(bot.moveset.infJump and "enabled" or "disabled"), bot.moveset.infJump and Color3.new(0.6, 1, 0.6) or Color3.new(0.8, 1, 0.8))
end)

-- Главный цикл
RunService.Heartbeat:Connect(function()
    autoCollect()
    autoPlant()
    
    -- Постоянное обновление NoClip
    if bot.moveset.noclip and player.Character then
        for _, part in ipairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

-- Авто-выключение при смерти
player.CharacterAdded:Connect(function(character)
    local humanoid = character:WaitForChild("Humanoid")
    humanoid.Died:Connect(function()
        bot.collect.active = false
        bot.plant.active = false
        AutoCollectBtn.Text = "COLLECT: OFF"
        AutoPlantBtn.Text = "PLANT: OFF"
        updateStatus("DIED - PAUSED", Color3.new(1, 0.4, 0.4))
    end)
    
    -- Применяем настройки к новому персонажу
    updateMoveset()
end)

-- Инициализация
updateMoveset()
setupInfJump()

print("Garden Bot Ultimate v8 loaded!")
