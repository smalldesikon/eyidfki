-- 加载动画
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local ContentProvider = game:GetService("ContentProvider")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local CONFIG = {
    LOAD_TIME = 5,
    PRIMARY_COLOR = Color3.fromRGB(0, 150, 255),  -- 改回蓝色主题
    SECONDARY_COLOR = Color3.fromRGB(0, 120, 220),
    GLOW_INTENSITY = 0.6,
    LOGO_IMAGE = "rbxassetid://6954167216",
    LOGO_TEXT = "作者：皮炎 司空",
    BORDER_COLOR = Color3.fromRGB(0, 100, 200),
    BORDER_THICKNESS = 2,
    TEXT_BG_COLOR = Color3.fromRGB(240, 245, 255),
    TEXT_BG_TRANSPARENCY = 0.85,
    SHADOW_COLOR = Color3.fromRGB(0, 80, 160),
    SHADOW_TRANSPARENCY = 0.8,
    MAIN_BG_COLOR = Color3.fromRGB(240, 248, 255),
    MAIN_BG_TRANSPARENCY = 0.9,
    MAIN_BORDER_COLOR = Color3.fromRGB(0, 120, 255),
    MAIN_BORDER_THICKNESS = 3,
    GLOW_COLOR = Color3.fromRGB(0, 100, 255),
    PULSE_SPEED = 3,
    PARTICLE_COUNT = 20,
    LOGO_SCALE = 0.8,
    LOGO_PADDING = 0.05,
    BG_PARTICLE_COUNT = 8
}

ContentProvider:PreloadAsync({
    CONFIG.LOGO_IMAGE,
    "rbxassetid://5028857084"
})

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BlueBorderLoadingScreen"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local mainContainer = Instance.new("Frame")
mainContainer.Name = "MainContainer"
mainContainer.Size = UDim2.new(0.75, 0, 0.65, 0)
mainContainer.Position = UDim2.new(0.125, 0, 0.175, 0)
mainContainer.BackgroundTransparency = 1
mainContainer.ZIndex = 10
mainContainer.Parent = screenGui

local mainBackground = Instance.new("Frame")
mainBackground.Name = "MainBackground"
mainBackground.Size = UDim2.new(1, 0, 1, 0)
mainBackground.BackgroundColor3 = CONFIG.MAIN_BG_COLOR
mainBackground.BackgroundTransparency = 1
mainBackground.ZIndex = 1
mainBackground.Parent = mainContainer

local mainBgCorner = Instance.new("UICorner")
mainBgCorner.CornerRadius = UDim.new(0.05, 0)
mainBgCorner.Parent = mainBackground

local mainBorder = Instance.new("Frame")
mainBorder.Name = "MainBorder"
mainBorder.Size = UDim2.new(1, 0, 1, 0)
mainBorder.BackgroundTransparency = 1
mainBorder.ZIndex = 2
mainBorder.Parent = mainContainer

local mainBorderStroke = Instance.new("UIStroke")
mainBorderStroke.Color = CONFIG.MAIN_BORDER_COLOR
mainBorderStroke.Thickness = 0
mainBorderStroke.Transparency = 0
mainBorderStroke.Parent = mainBorder

local mainBorderCorner = Instance.new("UICorner")
mainBorderCorner.CornerRadius = UDim.new(0.05, 0)
mainBorderCorner.Parent = mainBorder

local mainBorderGlow = Instance.new("UIStroke")
mainBorderGlow.Color = CONFIG.GLOW_COLOR
mainBorderGlow.Thickness = 0
mainBorderGlow.Transparency = 0.5
mainBorderGlow.Parent = mainBorder

local innerGlowEffect = Instance.new("ImageLabel")
innerGlowEffect.Name = "InnerGlowEffect"
innerGlowEffect.Size = UDim2.new(1.05, 0, 1.05, 0)
innerGlowEffect.Position = UDim2.new(0.5, 0, 0.5, 0)
innerGlowEffect.AnchorPoint = Vector2.new(0.5, 0.5)
innerGlowEffect.BackgroundTransparency = 1
innerGlowEffect.Image = "rbxassetid://5028857084"
innerGlowEffect.ImageColor3 = CONFIG.GLOW_COLOR
innerGlowEffect.ScaleType = Enum.ScaleType.Slice
innerGlowEffect.SliceCenter = Rect.new(100, 100, 100, 100)
innerGlowEffect.ImageTransparency = 1
innerGlowEffect.ZIndex = 0
innerGlowEffect.Parent = mainBorder

local particles = Instance.new("Frame")
particles.Name = "Particles"
particles.Size = UDim2.new(1, 0, 1, 0)
particles.BackgroundTransparency = 1
particles.ZIndex = 3
particles.Parent = mainBorder

local bgParticles = Instance.new("Frame")
bgParticles.Name = "BackgroundParticles"
bgParticles.Size = UDim2.new(1, 0, 1, 0)
bgParticles.BackgroundTransparency = 1
bgParticles.ZIndex = 0
bgParticles.Parent = mainBackground

local leftPanel = Instance.new("Frame")
leftPanel.Name = "LeftPanel"
leftPanel.Size = UDim2.new(0.35, 0, 0.9, 0)
leftPanel.Position = UDim2.new(0.05, 0, 0.05, 0)
leftPanel.BackgroundTransparency = 1
leftPanel.ZIndex = 11
leftPanel.Parent = mainContainer

local logoText = Instance.new("TextLabel")
logoText.Name = "LogoText"
logoText.Size = UDim2.new(1, 0, 0.15, 0)
logoText.Position = UDim2.new(0.5, 0, 0, 0)
logoText.AnchorPoint = Vector2.new(0.5, 0)
logoText.BackgroundTransparency = 1
logoText.Text = CONFIG.LOGO_TEXT
logoText.TextColor3 = Color3.fromRGB(0, 80, 160)
logoText.TextSize = 36
logoText.Font = Enum.Font.GothamBlack
logoText.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
logoText.TextStrokeTransparency = 0.8
logoText.TextTransparency = 1
logoText.ZIndex = 12
logoText.Parent = leftPanel

local logoContainer = Instance.new("Frame")
logoContainer.Name = "LogoContainer"
logoContainer.Size = UDim2.new(0.9, 0, 0.7, 0)
logoContainer.Position = UDim2.new(0.5, 0, 0.2, 0)
logoContainer.AnchorPoint = Vector2.new(0.5, 0)
logoContainer.BackgroundTransparency = 1
logoContainer.ZIndex = 11
logoContainer.Parent = leftPanel

local logoImage = Instance.new("ImageLabel")
logoImage.Name = "LogoImage"
logoImage.Size = UDim2.new(1, 0, 1, 0)
logoImage.Position = UDim2.new(0.5, 0, 0.5, 0)
logoImage.AnchorPoint = Vector2.new(0.5, 0.5)
logoImage.BackgroundTransparency = 1
logoImage.Image = CONFIG.LOGO_IMAGE
logoImage.ScaleType = Enum.ScaleType.Fit
logoImage.ZIndex = 13
logoImage.Parent = logoContainer

local frameBorder = Instance.new("UIStroke")
frameBorder.Color = CONFIG.BORDER_COLOR
frameBorder.Thickness = CONFIG.BORDER_THICKNESS
frameBorder.Transparency = 1
frameBorder.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
frameBorder.Parent = logoImage

local borderGlow = Instance.new("UIStroke")
borderGlow.Color = CONFIG.PRIMARY_COLOR
borderGlow.Thickness = CONFIG.BORDER_THICKNESS * 1.5
borderGlow.Transparency = 1
borderGlow.Parent = logoImage

local innerGlow = Instance.new("ImageLabel")
innerGlow.Name = "InnerGlow"
innerGlow.Size = UDim2.new(1.1, 0, 1.1, 0)
innerGlow.Position = UDim2.new(0.5, 0, 0.5, 0)
innerGlow.AnchorPoint = Vector2.new(0.5, 0.5)
innerGlow.BackgroundTransparency = 1
innerGlow.Image = "rbxassetid://5028857084"
innerGlow.ImageColor3 = CONFIG.PRIMARY_COLOR
innerGlow.ScaleType = Enum.ScaleType.Slice
innerGlow.SliceCenter = Rect.new(100, 100, 100, 100)
innerGlow.ImageTransparency = 1
innerGlow.ZIndex = 11
innerGlow.Parent = logoContainer

local rightPanel = Instance.new("Frame")
rightPanel.Name = "RightPanel"
rightPanel.Size = UDim2.new(0.6, 0, 0.9, 0)
rightPanel.Position = UDim2.new(0.4, 0, 0.05, 0)
rightPanel.BackgroundTransparency = 1
rightPanel.ZIndex = 11
rightPanel.Parent = mainContainer

local welcomeText = Instance.new("TextLabel")
welcomeText.Name = "WelcomeText"
welcomeText.Size = UDim2.new(1, 0, 0.2, 0)
welcomeText.Position = UDim2.new(0.5, 0, 0.1, 0)
welcomeText.AnchorPoint = Vector2.new(0.5, 0.1)
welcomeText.BackgroundTransparency = 1
welcomeText.Text = "欢迎使用皮空"
welcomeText.TextColor3 = Color3.fromRGB(0, 80, 160)
welcomeText.TextSize = 38
welcomeText.Font = Enum.Font.GothamBlack
welcomeText.TextXAlignment = Enum.TextXAlignment.Center
welcomeText.TextTransparency = 1
welcomeText.ZIndex = 12
welcomeText.Parent = rightPanel

local usernameText = Instance.new("TextLabel")
usernameText.Name = "UsernameText"
usernameText.Size = UDim2.new(1, 0, 0.15, 0)
usernameText.Position = UDim2.new(0.5, 0, 0.35, 0)
usernameText.AnchorPoint = Vector2.new(0.5, 0.35)
usernameText.BackgroundTransparency = 1
usernameText.Text = "玩家: " .. player.Name
usernameText.TextColor3 = Color3.fromRGB(0, 100, 200)
usernameText.TextSize = 28
usernameText.Font = Enum.Font.GothamSemibold
usernameText.TextXAlignment = Enum.TextXAlignment.Center
usernameText.TextTransparency = 1
usernameText.ZIndex = 12
usernameText.Parent = rightPanel

local loadingText = Instance.new("TextLabel")
loadingText.Name = "LoadingText"
loadingText.Size = UDim2.new(1, 0, 0.1, 0)
loadingText.Position = UDim2.new(0.5, 0, 0.55, 0)
loadingText.AnchorPoint = Vector2.new(0.5, 0.55)
loadingText.BackgroundTransparency = 1
loadingText.Text = "正在加载资源..."
loadingText.TextColor3 = Color3.fromRGB(0, 120, 220)
loadingText.TextSize = 24
loadingText.Font = Enum.Font.Gotham
loadingText.TextXAlignment = Enum.TextXAlignment.Center
loadingText.TextTransparency = 1
loadingText.ZIndex = 12
loadingText.Parent = rightPanel

local progressContainer = Instance.new("Frame")
progressContainer.Name = "ProgressContainer"
progressContainer.Size = UDim2.new(1, 0, 0.15, 0)
progressContainer.Position = UDim2.new(0, 0, 0.75, 0)
progressContainer.BackgroundTransparency = 1
progressContainer.ZIndex = 11
progressContainer.Parent = rightPanel

local progressBackground = Instance.new("Frame")
progressBackground.Name = "ProgressBackground"
progressBackground.Size = UDim2.new(0.9, 0, 0.4, 0)
progressBackground.Position = UDim2.new(0.5, 0, 0.3, 0)
progressBackground.AnchorPoint = Vector2.new(0.5, 0.3)
progressBackground.BackgroundColor3 = Color3.fromRGB(220, 235, 255)
progressBackground.BackgroundTransparency = 0.7
progressBackground.BorderSizePixel = 0
progressBackground.ZIndex = 12
progressBackground.Parent = progressContainer

local progressCorner = Instance.new("UICorner")
progressCorner.CornerRadius = UDim.new(0.5, 0)
progressCorner.Parent = progressBackground

local progressBar = Instance.new("Frame")
progressBar.Name = "ProgressBar"
progressBar.Size = UDim2.new(0, 0, 1, 0)
progressBar.BackgroundColor3 = CONFIG.PRIMARY_COLOR
progressBar.BackgroundTransparency = 0.3
progressBar.BorderSizePixel = 0
progressBar.ZIndex = 13
progressBar.Parent = progressBackground

local barCorner = Instance.new("UICorner")
barCorner.CornerRadius = UDim.new(0.5, 0)
barCorner.Parent = progressBar

local gradient = Instance.new("UIGradient")
gradient.Rotation = 90
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 180, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 100, 200))
})
gradient.Parent = progressBar

local percentText = Instance.new("TextLabel")
percentText.Name = "PercentText"
percentText.Size = UDim2.new(0.9, 0, 0.4, 0)
percentText.Position = UDim2.new(0.5, 0, 0.7, 0)
percentText.AnchorPoint = Vector2.new(0.5, 0.7)
percentText.BackgroundTransparency = 1
percentText.Text = "0%"
percentText.TextColor3 = Color3.fromRGB(0, 100, 200)
percentText.TextSize = 22
percentText.Font = Enum.Font.GothamSemibold
percentText.TextXAlignment = Enum.TextXAlignment.Center
percentText.TextTransparency = 1
percentText.ZIndex = 12
percentText.Parent = progressContainer

local function createParticles()
    for i = 1, CONFIG.PARTICLE_COUNT do
        local particle = Instance.new("Frame")
        particle.Name = "Particle_"..i
        particle.Size = UDim2.new(0.01, 0, 0.01, 0)
        particle.Position = UDim2.new(math.random(), 0, math.random(), 0)
        particle.BackgroundColor3 = CONFIG.PRIMARY_COLOR
        particle.BackgroundTransparency = 0.8
        particle.ZIndex = 13
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0.5, 0)
        corner.Parent = particle
        
        particle.Parent = particles
    end
end

local function createBackgroundParticles()
    for i = 1, CONFIG.BG_PARTICLE_COUNT do
        local particle = Instance.new("Frame")
        particle.Name = "BgParticle_"..i
        particle.Size = UDim2.new(0.02, 0, 0.02, 0)
        particle.Position = UDim2.new(math.random(), 0, math.random(), 0)
        particle.BackgroundColor3 = CONFIG.SECONDARY_COLOR
        particle.BackgroundTransparency = 0.9
        particle.ZIndex = 0
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0.5, 0)
        corner.Parent = particle
        
        particle.Parent = bgParticles
        
        coroutine.wrap(function()
            local speed = 0.0002 + math.random() * 0.0001
            while particle and particle.Parent do
                particle.Position = particle.Position + UDim2.new(speed, 0, speed, 0)
                if particle.Position.X.Scale > 1.2 then
                    particle.Position = UDim2.new(-0.2, 0, math.random(), 0)
                end
                task.wait(0.1)
            end
        end)()
    end
end

local function logoFloatAnimation()
    local startPos = logoContainer.Position
    local lastUpdate = tick()
    
    while logoContainer and logoContainer.Parent do
        local now = tick()
        if now - lastUpdate >= 0.016 then
            local time = now
            local offset = UDim2.new(0, 0, 0, math.sin(time * 2) * 5)
            logoContainer.Position = startPos + offset
            
            local pulse = 0.7 + math.sin(time * 3) * 0.15
            innerGlow.ImageTransparency = 1 - (pulse * CONFIG.GLOW_INTENSITY)
            borderGlow.Transparency = 0.7 - (pulse * 0.2)
            
            lastUpdate = now
        end
        task.wait()
    end
end

local function logoPulseAnimation()
    local lastUpdate = tick()
    while logoImage and logoImage.Parent do
        local now = tick()
        if now - lastUpdate >= 0.05 then
            local time = now
            local scale = 1 + math.sin(time * 0.5) * 0.03
            logoImage.Size = UDim2.new(1 * scale, 0, 1 * scale, 0)
            lastUpdate = now
        end
        task.wait()
    end
end

local function borderPulseAnimation()
    local lastUpdate = tick()
    while mainBorder and mainBorder.Parent do
        local now = tick()
        if now - lastUpdate >= 0.016 then
            local time = now
            local pulse = 0.5 + math.sin(time * CONFIG.PULSE_SPEED) * 0.15
            
            mainBorderGlow.Thickness = CONFIG.MAIN_BORDER_THICKNESS * (2 + pulse * 0.5)
            mainBorderGlow.Transparency = 0.5 - (pulse * 0.2)
            innerGlowEffect.ImageTransparency = 0.8 - (pulse * 0.1)
            
            for _, particle in ipairs(particles:GetChildren()) do
                if particle:IsA("Frame") then
                    local particleNum = tonumber(string.match(particle.Name, "%d+"))
                    local offsetX = math.sin(time + particleNum) * 0.01
                    local offsetY = math.cos(time + particleNum) * 0.01
                    particle.Position = particle.Position + UDim2.new(offsetX, 0, offsetY, 0)
                    
                    if particle.Position.X.Scale < 0 then
                        particle.Position = UDim2.new(0, 0, particle.Position.Y.Scale, 0)
                    elseif particle.Position.X.Scale > 1 then
                        particle.Position = UDim2.new(1, 0, particle.Position.Y.Scale, 0)
                    end
                    
                    if particle.Position.Y.Scale < 0 then
                        particle.Position = UDim2.new(particle.Position.X.Scale, 0, 0, 0)
                    elseif particle.Position.Y.Scale > 1 then
                        particle.Position = UDim2.new(particle.Position.X.Scale, 0, 1, 0)
                    end
                end
            end
            
            lastUpdate = now
        end
        task.wait()
    end
end

local function elementsEntranceAnimation()
    local tweenInfo = TweenInfo.new(
        1.2, 
        Enum.EasingStyle.Quint, 
        Enum.EasingDirection.Out,
        0,
        false,
        0.2
    )
    
    TweenService:Create(mainBackground, tweenInfo, {BackgroundTransparency = CONFIG.MAIN_BG_TRANSPARENCY}):Play()
    TweenService:Create(mainBorderStroke, tweenInfo, {Thickness = CONFIG.MAIN_BORDER_THICKNESS}):Play()
    TweenService:Create(mainBorderGlow, tweenInfo, {Thickness = CONFIG.MAIN_BORDER_THICKNESS * 2.5}):Play()
    TweenService:Create(innerGlowEffect, tweenInfo, {ImageTransparency = 0.8}):Play()
    
    TweenService:Create(frameBorder, tweenInfo, {Transparency = 0}):Play()
    TweenService:Create(borderGlow, tweenInfo, {Transparency = 0.7}):Play()
    
    task.wait(0.3)
    TweenService:Create(innerGlow, tweenInfo, {ImageTransparency = 0.8}):Play()
    
    task.wait(0.2)
    local textTweenInfo = TweenInfo.new(0.8, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    TweenService:Create(logoText, textTweenInfo, {TextTransparency = 0}):Play()
    task.wait(0.15)
    TweenService:Create(welcomeText, textTweenInfo, {TextTransparency = 0}):Play()
    task.wait(0.15)
    TweenService:Create(usernameText, textTweenInfo, {TextTransparency = 0}):Play()
    task.wait(0.1)
    TweenService:Create(loadingText, textTweenInfo, {TextTransparency = 0}):Play()
    TweenService:Create(percentText, textTweenInfo, {TextTransparency = 0}):Play()
end

local function rainbowTextAnimation()
    local hue = 0
    while usernameText and usernameText.Parent do
        hue = (hue + 0.008) % 1
        local saturation = 0.7
        local value = 0.8 + math.sin(tick() * 2) * 0.2
        usernameText.TextColor3 = Color3.fromHSV(hue, saturation, value)
        task.wait(0.08)
    end
end

local function loadingAnimation()
    local startTime = tick()
    local duration = CONFIG.LOAD_TIME
    
    createParticles()
    createBackgroundParticles()
    
    local preloadTime = duration * 0.1
    while tick() - startTime < preloadTime do
        local progress = (tick() - startTime) / preloadTime * 0.1
        progressBar.Size = UDim2.new(progress, 0, 1, 0)
        percentText.Text = string.format("%d%%", math.floor(progress * 100))
        task.wait()
    end
    
    local mainLoadTime = duration * 0.8
    local mainStartTime = tick()
    while tick() - mainStartTime < mainLoadTime do
        local progress = 0.1 + (tick() - mainStartTime) / mainLoadTime * 0.8
        progressBar.Size = UDim2.new(progress, 0, 1, 0)
        percentText.Text = string.format("%d%%", math.floor(progress * 100))
        
        local dots = string.rep(".", math.floor(tick() % 4))
        loadingText.Text = "正在加载资源" .. dots
        
        local brightness = 0.7 + progress * 0.3
        gradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 180, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 100, 200))
        })
        
        task.wait()
    end
    
    local finishTime = duration * 0.1
    local finishStartTime = tick()
    while tick() - finishStartTime < finishTime do
        local progress = 0.9 + (tick() - finishStartTime) / finishTime * 0.1
        progressBar.Size = UDim2.new(progress, 0, 1, 0)
        percentText.Text = string.format("%d%%", math.floor(progress * 100))
        task.wait()
    end
    
    loadingText.Text = "加载完成!"
    percentText.Text = "100%"
    
    for i = 1, 2 do
        TweenService:Create(progressBar, TweenInfo.new(0.15), {Size = UDim2.new(1.02, 0, 1.1, 0)}):Play()
        task.wait(0.15)
        TweenService:Create(progressBar, TweenInfo.new(0.15), {Size = UDim2.new(1, 0, 1, 0)}):Play()
        task.wait(0.15)
    end
    
    local flash = Instance.new("Frame")
    flash.Size = UDim2.new(1, 0, 1, 0)
    flash.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    flash.BackgroundTransparency = 1
    flash.ZIndex = 20
    flash.Parent = mainContainer
    
    TweenService:Create(flash, TweenInfo.new(0.3), {BackgroundTransparency = 0.6}):Play()
    task.wait(0.3)
    TweenService:Create(flash, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
    
    local fadeOutInfo = TweenInfo.new(0.8, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
    
    for _, text in ipairs({logoText, welcomeText, usernameText, loadingText, percentText}) do
        TweenService:Create(text, fadeOutInfo, {TextTransparency = 1}):Play()
    end
    
    TweenService:Create(frameBorder, fadeOutInfo, {Transparency = 1}):Play()
    TweenService:Create(borderGlow, fadeOutInfo, {Transparency = 1}):Play()
    TweenService:Create(innerGlow, fadeOutInfo, {ImageTransparency = 1}):Play()
    
    TweenService:Create(mainBackground, fadeOutInfo, {BackgroundTransparency = 1}):Play()
    TweenService:Create(mainBorderStroke, fadeOutInfo, {Thickness = 0}):Play()
    TweenService:Create(mainBorderGlow, fadeOutInfo, {Thickness = 0}):Play()
    TweenService:Create(innerGlowEffect, fadeOutInfo, {ImageTransparency = 1}):Play()
    
    for _, particle in ipairs(particles:GetChildren()) do
        if particle:IsA("Frame") then
            TweenService:Create(particle, fadeOutInfo, {BackgroundTransparency = 1}):Play()
        end
    end
    
    task.wait(0.8)
    screenGui:Destroy()
    
    -- 加载动画完成后启动主脚本
    initMainScript()
end

screenGui.Parent = playerGui

coroutine.wrap(logoFloatAnimation)()
coroutine.wrap(logoPulseAnimation)()
coroutine.wrap(borderPulseAnimation)()
coroutine.wrap(elementsEntranceAnimation)()
coroutine.wrap(rainbowTextAnimation)()
coroutine.wrap(loadingAnimation)()

-- 主脚本初始化函数
function initMainScript()
    -- 加载通知面板
    local NotificationHolder = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Module.Lua"))()
    local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Client.Lua"))()

    -- 显示加载完成通知
    Notification:Notify(
        {Title = "皮空重置", Description = "脚本加载完成！享受使用吧！"},
        {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 5, Type = "image"},
        {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 150, 255)}
    )

    -- 使用WindUI库
    local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

    -- 创建窗口
    local Window = WindUI:CreateWindow({
        Title = "皮空重置",
        Icon = "settings",
        Author = "皮空重置 - 已加载",
        Folder = "皮空脚本",
        Size = UDim2.fromOffset(600, 500),
        Theme = "Light",
        User = {
            Enabled = true,
            Anonymous = false,
            Callback = function()
                local player = game.Players.LocalPlayer
                Notification:Notify(
                    {Title = "用户信息", Description = string.format("用户名: %s\n显示名: %s\n用户ID: %d", 
                        player.Name, player.DisplayName, player.UserId)},
                    {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 6, Type = "image"},
                    {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 150, 255)}
                )
            end
        },
        SideBarWidth = 200,
        ScrollBarEnabled = true,
        KeySystem = {
            Key = { "皮空脚本垃圾", "皮炎是司空的爸爸" },
            Note = "想获得卡密加Q群1057315887",
            URL = "1057315887",
        },
    })

    -- 添加标签
    Window:Tag({
        Title = "重置版",
        Color = Color3.fromHex("#0078D7")
    })

    -- 创建各个标签页
    local Tabs = {
        Main = Window:Section({ Title = "主界面", Opened = true }),
        Core = Window:Section({ Title = "通用", Opened = true }),
        Teleport = Window:Section({ Title = "传送功能", Opened = true }),
        Translate = Window:Section({ Title = "极速汉化", Opened = true }),
        Strongest = Window:Section({ Title = "最强战场", Opened = true }),
        Abandoned = Window:Section({ Title = "被遗弃", Opened = true }),
        V99 = Window:Section({ Title = "99页", Opened = true }),
        DeadRails = Window:Section({ Title = "死铁轨", Opened = true }),
        InkGame = Window:Section({ Title = "墨水游戏", Opened = true }),
        Other = Window:Section({ Title = "其他功能", Opened = true })
    }

    local TabHandles = {
        Main = Tabs.Main:Tab({ Title = "主界面", Icon = "home" }),
        Core = Tabs.Core:Tab({ Title = "通用", Icon = "zap" }),
        Teleport = Tabs.Teleport:Tab({ Title = "传送功能", Icon = "navigation" }),
        Translate = Tabs.Translate:Tab({ Title = "极速汉化", Icon = "languages" }),
        Strongest = Tabs.Strongest:Tab({ Title = "最强战场", Icon = "crosshair" }),
        Abandoned = Tabs.Abandoned:Tab({ Title = "被遗弃", Icon = "archive" }),
        V99 = Tabs.V99:Tab({ Title = "99页", Icon = "box" }),
        DeadRails = Tabs.DeadRails:Tab({ Title = "死铁轨", Icon = "train" }),
        InkGame = Tabs.InkGame:Tab({ Title = "墨水游戏", Icon = "pen-tool" }),
        Other = Tabs.Other:Tab({ Title = "其他功能", Icon = "grid" })
    }

    -- ========== 主界面内容 ==========
    TabHandles.Main:Paragraph({
        Title = "皮空重置",
        Desc = "欢迎使用皮空重置脚本！\n所有功能已解锁，请尽情使用！",
        Image = "user",
        ImageSize = 20,
        Color = Color3.fromHex("#0078D7"),
    })

    TabHandles.Main:Divider()

    -- 系统信息
    local player = game.Players.LocalPlayer

    TabHandles.Main:Paragraph({
        Title = "系统信息",
        Desc = string.format("用户名: %s\n显示名: %s\n用户ID: %d\n账号年龄: %d天", 
            player.Name, player.DisplayName, player.UserId, player.AccountAge),
        Image = "info",
        ImageSize = 20,
        Color = Color3.fromHex("#0099FF")
    })

    -- 帧率显示
    local fpsCounter = 0
    local fpsLastTime = tick()
    local fpsText = "计算中..."

    spawn(function()
        while true do
            fpsCounter = fpsCounter + 1
            if tick() - fpsLastTime >= 1 then
                fpsText = fpsCounter .. " FPS"
                fpsCounter = 0
                fpsLastTime = tick()
            end
            game:GetService("RunService").RenderStepped:Wait()
        end
    end)

    TabHandles.Main:Paragraph({
        Title = "性能信息",
        Desc = "帧率: " .. fpsText,
        Image = "bar-chart",
        ImageSize = 20,
        Color = Color3.fromHex("#00A2FF")
    })

    -- ========== 核心功能标签页 ==========
    TabHandles.Core:Paragraph({
        Title = "核心功能",
        Desc = "游戏基础功能修改",
        Image = "zap",
        ImageSize = 20,
        Color = Color3.fromHex("#0078D7")
    })

    TabHandles.Core:Divider()

    -- 修复的穿墙功能
    local Noclip = false
    local Stepped

    local NoclipToggle = TabHandles.Core:Toggle({
        Title = "穿墙模式",
        Desc = "允许穿过墙壁和障碍物",
        Default = false,
        Callback = function(Value)
            if Value then
                Noclip = true
                Stepped = game:GetService("RunService").Stepped:Connect(function()
                    if Noclip == true then
                        for a, b in pairs(game:GetService("Workspace"):GetChildren()) do
                            if b.Name == game.Players.LocalPlayer.Name then
                                for i, v in pairs(game:GetService("Workspace")[game.Players.LocalPlayer.Name]:GetChildren()) do
                                    if v:IsA("BasePart") then
                                        v.CanCollide = false
                                    end
                                end
                            end
                        end
                    else
                        Stepped:Disconnect()
                    end
                end)
                Notification:Notify(
                    {Title = "穿墙模式", Description = "穿墙模式已启用"},
                    {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 3, Type = "image"},
                    {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 150, 255)}
                )
            else
                Noclip = false
                if Stepped then
                    Stepped:Disconnect()
                end
                Notification:Notify(
                    {Title = "穿墙模式", Description = "穿墙模式已禁用"},
                    {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 3, Type = "image"},
                    {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 150, 255)}
                )
            end
        end
    })

    -- 无限跳跃功能
    local InfiniteJumpEnabled = false

    local InfiniteJumpToggle = TabHandles.Core:Toggle({
        Title = "无限跳跃",
        Desc = "在空中可以无限跳跃",
        Default = false,
        Callback = function(state)
            InfiniteJumpEnabled = state
            if state then
                local success, err = pcall(function()
                    loadstring(game:HttpGet("https://pastebin.com/raw/V5PQy3y0", true))()
                end)
                
                if success then
                    Notification:Notify(
                        {Title = "无限跳跃", Description = "无限跳跃已启用"},
                        {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 3, Type = "image"},
                        {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 150, 255)}
                    )
                else
                    Notification:Notify(
                        {Title = "无限跳跃", Description = "加载失败: " .. tostring(err)},
                        {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 5, Type = "image"},
                        {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 150, 255)}
                    )
                    InfiniteJumpToggle:Set(false)
                end
            else
                Notification:Notify(
                    {Title = "无限跳跃", Description = "无限跳跃已禁用"},
                    {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 3, Type = "image"},
                    {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 150, 255)}
                )
            end
        end
    })

    -- 爬墙功能
    local WallClimbEnabled = false

    local WallClimbToggle = TabHandles.Core:Toggle({
        Title = "爬墙功能",
        Desc = "可以在墙上爬行",
        Default = false,
        Callback = function(state)
            WallClimbEnabled = state
            if state then
                local success, err = pcall(function()
                    loadstring(game:HttpGet("https://pastebin.com/raw/zXk4Rq2r"))()
                end)
                
                if success then
                    Notification:Notify(
                        {Title = "爬墙功能", Description = "爬墙功能已启用"},
                        {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 3, Type = "image"},
                        {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 150, 255)}
                    )
                else
                    Notification:Notify(
                        {Title = "爬墙功能", Description = "加载失败: " .. tostring(err)},
                        {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 5, Type = "image"},
                        {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 150, 255)}
                    )
                    WallClimbToggle:Set(false)
                end
            else
                Notification:Notify(
                    {Title = "爬墙功能", Description = "爬墙功能已禁用"},
                    {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 3, Type = "image"},
                    {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 150, 255)}
                )
            end
        end
    })

    TabHandles.Core:Button({
        Title = "飞行模式",
        Icon = "wind",
        Callback = function()
            Notification:Notify(
                {Title = "飞行模式", Description = "正在加载飞行脚本..."},
                {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 3, Type = "image"},
                {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 150, 255)}
            )
            loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))()
        end
    })

    TabHandles.Core:Divider()

    -- 移动速度设置
    local SpeedValue = 16
    local SpeedSlider = TabHandles.Core:Slider({
        Title = "移动速度",
        Desc = "调整角色移动速度",
        Value = { Min = 16, Max = 100, Default = 16 },
        Callback = function(value)
            SpeedValue = value
            if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
            end
            Notification:Notify(
                {Title = "移动速度", Description = "已设置为: " .. value},
                {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 2, Type = "image"},
                {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 150, 255)}
            )
        end
    })

    -- 跳跃高度设置
    local JumpValue = 50
    local JumpSlider = TabHandles.Core:Slider({
        Title = "跳跃高度",
        Desc = "调整角色跳跃高度",
        Value = { Min = 50, Max = 200, Default = 50 },
        Callback = function(value)
            JumpValue = value
            if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                game.Players.LocalPlayer.Character.Humanoid.JumpPower = value
            end
            Notification:Notify(
                {Title = "跳跃高度", Description = "已设置为: " .. value},
                {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 2, Type = "image"},
                {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 150, 255)}
            )
        end
    })

    -- ========== 传送功能标签页 ==========
    TabHandles.Teleport:Paragraph({
        Title = "玩家传送功能",
        Desc = "选择玩家并传送到他们的位置",
        Image = "navigation",
        ImageSize = 20,
        Color = Color3.fromHex("#0078D7")
    })

    TabHandles.Teleport:Divider()

    -- 玩家列表管理
    local PlayerList = {}
    local SelectedPlayer = nil
    local PlayerButtons = {}

    -- 获取玩家列表函数
    local function GetPlayerList()
        local players = game:GetService("Players"):GetPlayers()
        local playerNames = {}
        PlayerList = {}
        
        for _, player in ipairs(players) do
            if player ~= game.Players.LocalPlayer then
                table.insert(playerNames, player.Name)
                PlayerList[player.Name] = player
            end
        end
        
        table.sort(playerNames)
        return playerNames
    end

    -- 创建玩家按钮列表
    local function CreatePlayerButtons()
        local playerNames = GetPlayerList()
        
        -- 清除现有按钮
        for _, button in ipairs(PlayerButtons) do
            if button and button.Remove then
                button:Remove()
            end
        end
        PlayerButtons = {}
        
        if #playerNames == 0 then
            -- 添加无玩家提示
            local noPlayersText = TabHandles.Teleport:Paragraph({
                Title = "无其他玩家",
                Desc = "当前没有其他玩家在线",
                Image = "users",
                ImageSize = 16,
                Color = Color3.fromHex("#0099FF")
            })
            table.insert(PlayerButtons, noPlayersText)
            SelectedPlayer = nil
            return
        end
        
        -- 为每个玩家创建按钮
        for _, playerName in ipairs(playerNames) do
            local playerButton = TabHandles.Teleport:Button({
                Title = playerName,
                Icon = "user",
                Callback = function()
                    SelectedPlayer = PlayerList[playerName]
                    Notification:Notify(
                        {Title = "玩家选择", Description = "已选择玩家: " .. playerName},
                        {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 2, Type = "image"},
                        {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 150, 255)}
                    )
                end
            })
            table.insert(PlayerButtons, playerButton)
        end
    end

    -- 刷新玩家列表按钮
    TabHandles.Teleport:Button({
        Title = "刷新玩家列表",
        Icon = "refresh-cw",
        Callback = function()
            -- 先清除所有现有按钮
            for _, button in ipairs(PlayerButtons) do
                if button and button.Remove then
                    button:Remove()
                end
            end
            PlayerButtons = {}
            
            -- 重新创建玩家按钮
            CreatePlayerButtons()
            Notification:Notify(
                {Title = "玩家列表", Description = "已刷新玩家列表"},
                {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 2, Type = "image"},
                {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 150, 255)}
            )
        end
    })

    -- 传送功能按钮
    TabHandles.Teleport:Button({
        Title = "传送到选中玩家",
        Icon = "user-check",
        Callback = function()
            if not SelectedPlayer then
                Notification:Notify(
                    {Title = "传送失败", Description = "请先选择一个玩家"},
                    {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 3, Type = "image"},
                    {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(255, 100, 100)}
                )
                return
            end
            
            local targetPlayer = SelectedPlayer
            local localPlayer = game.Players.LocalPlayer
            
            -- 检查目标玩家是否仍然有效
            if not targetPlayer or not targetPlayer.Parent then
                Notification:Notify(
                    {Title = "传送失败", Description = "目标玩家已离开游戏"},
                    {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 3, Type = "image"},
                    {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(255, 100, 100)}
                )
                CreatePlayerButtons() -- 刷新列表
                return
            end
            
            -- 检查目标玩家是否有效
            if not targetPlayer.Character then
                Notification:Notify(
                    {Title = "传送失败", Description = "目标玩家没有角色"},
                    {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 3, Type = "image"},
                    {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(255, 100, 100)}
                )
                return
            end
            
            local targetRoot = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
            local localRoot = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
            
            if not targetRoot then
                Notification:Notify(
                    {Title = "传送失败", Description = "目标玩家没有HumanoidRootPart"},
                    {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 3, Type = "image"},
                    {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(255, 100, 100)}
                )
                return
            end
            
            if not localRoot then
                Notification:Notify(
                    {Title = "传送失败", Description = "您没有HumanoidRootPart"},
                    {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 3, Type = "image"},
                    {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(255, 100, 100)}
                )
                return
            end
            
            -- 执行传送
            local success, err = pcall(function()
                local originalPosition = localRoot.Position
                localRoot.CFrame = CFrame.new(targetRoot.Position + Vector3.new(0, 3, 0))
                wait(0.1)
                
                if (localRoot.Position - targetRoot.Position).Magnitude > 20 then
                    localRoot.CFrame = CFrame.new(originalPosition)
                    error("传送距离过远，可能被防传送机制阻止")
                end
            end)
            
            if success then
                Notification:Notify(
                    {Title = "传送成功", Description = "已传送到玩家: " .. targetPlayer.Name},
                    {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 3, Type = "image"},
                    {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(100, 255, 100)}
                )
            else
                Notification:Notify(
                    {Title = "传送失败", Description = "传送过程中出现错误: " .. tostring(err)},
                    {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 3, Type = "image"},
                    {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(255, 100, 100)}
                )
            end
        end
    })

    -- 传送到鼠标位置功能
    TabHandles.Teleport:Button({
        Title = "传送到鼠标位置",
        Icon = "mouse-pointer",
        Callback = function()
            local localPlayer = game.Players.LocalPlayer
            local localRoot = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
            
            if not localRoot then
                Notification:Notify(
                    {Title = "传送失败", Description = "您没有HumanoidRootPart"},
                    {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 3, Type = "image"},
                    {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(255, 100, 100)}
                )
                return
            end
            
            -- 获取鼠标位置
            local mouse = localPlayer:GetMouse()
            local targetPosition = mouse.Hit.Position
            
            -- 执行传送
            local success, err = pcall(function()
                local originalPosition = localRoot.Position
                localRoot.CFrame = CFrame.new(targetPosition + Vector3.new(0, 3, 0))
                wait(0.1)
                
                if (localRoot.Position - targetPosition).Magnitude > 20 then
                    localRoot.CFrame = CFrame.new(originalPosition)
                    error("传送距离过远，可能被防传送机制阻止")
                end
            end)
            
            if success then
                Notification:Notify(
                    {Title = "传送成功", Description = "已传送到鼠标位置"},
                    {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 3, Type = "image"},
                    {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(100, 255, 100)}
                )
            else
                Notification:Notify(
                    {Title = "传送失败", Description = "传送过程中出现错误: " .. tostring(err)},
                    {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 3, Type = "image"},
                    {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(255, 100, 100)}
                )
            end
        end
    })

    -- 初始化时创建玩家按钮
    spawn(function()
        wait(1)
        CreatePlayerButtons()
    end)

    -- 自动刷新玩家列表
    spawn(function()
        while true do
            wait(10)  -- 每10秒自动刷新一次
            -- 清除现有按钮
            for _, button in ipairs(PlayerButtons) do
                if button and button.Remove then
                    button:Remove()
                end
            end
            PlayerButtons = {}
            -- 重新创建玩家按钮
            CreatePlayerButtons()
        end
    end)

    TabHandles.Teleport:Paragraph({
        Title = "使用说明",
        Desc = "1. 点击刷新玩家列表更新在线玩家\n2. 点击玩家名字选择目标玩家\n3. 点击传送到选中玩家按钮即可传送\n4. 也可以使用传送到鼠标位置功能",
        Image = "info",
        ImageSize = 16,
        Color = Color3.fromHex("#0099FF")
    })

    -- ========== 极速汉化标签页 ==========
    TabHandles.Translate:Paragraph({
        Title = "极速汉化设置",
        Desc = "自动翻译游戏界面文本",
        Image = "languages",
        ImageSize = 20,
        Color = Color3.fromHex("#0078D7")
    })

    TabHandles.Translate:Divider()

    local TranslateEngine = {
        isRunning = false,
        cache = {},
        textData = {}
    }

    local function translateText(text)
        if not text or text == "" then return "" end
        
        if TranslateEngine.cache[text] then
            return TranslateEngine.cache[text]
        end
        
        local url = "https://translate.googleapis.com/translate_a/single?client=gtx&sl=auto&tl=zh-CN&dt=t&q=" .. game:GetService("HttpService"):UrlEncode(text)
        
        local success, result = pcall(function()
            return game:HttpGet(url)
        end)
        
        if success and result then
            local decoded = game:GetService("HttpService"):JSONDecode(result)
            if decoded and decoded[1] then
                local translated = ""
                for _, item in ipairs(decoded[1]) do
                    if item[1] then
                        translated = translated .. item[1]
                    end
                end
                TranslateEngine.cache[text] = translated
                return translated
            end
        end
        
        return text
    end

    local function scanAndTranslate()
        if not TranslateEngine.isRunning then return end
        
        local guis = {
            game:GetService("CoreGui"),
            game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
        }
        
        local translatedCount = 0
        
        for _, gui in ipairs(guis) do
            for _, descendant in ipairs(gui:GetDescendants()) do
                if descendant:IsA("TextLabel") or descendant:IsA("TextButton") or descendant:IsA("TextBox") then
                    local text = descendant.Text
                    if text and text ~= "" and #text > 2 and #text < 100 then
                        if text:match("%a") and not text:match("[\228-\233][\128-\191].") then
                            local translated = translateText(text)
                            if translated and translated ~= text then
                                pcall(function()
                                    descendant.Text = translated
                                    translatedCount = translatedCount + 1
                                end)
                            end
                        end
                    end
                end
            end
        end
        
        if translatedCount > 0 then
            Notification:Notify(
                {Title = "极速汉化", Description = "已翻译 " .. translatedCount .. " 个文本"},
                {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 3, Type = "image"},
                {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 150, 255)}
            )
        end
    end

    local TranslateToggle = TabHandles.Translate:Toggle({
        Title = "启用极速汉化",
        Desc = "自动扫描并翻译界面文本",
        Default = false,
        Callback = function(state)
            TranslateEngine.isRunning = state
            if state then
                Notification:Notify(
                    {Title = "极速汉化", Description = "汉化功能已启用，开始扫描界面..."},
                    {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 3, Type = "image"},
                    {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 150, 255)}
                )
                spawn(function()
                    while TranslateEngine.isRunning do
                        scanAndTranslate()
                        wait(5)
                    end
                end)
            else
                Notification:Notify(
                    {Title = "极速汉化", Description = "汉化功能已关闭"},
                    {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 3, Type = "image"},
                    {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 150, 255)}
                )
            end
        end
    })

    TabHandles.Translate:Button({
        Title = "立即翻译界面",
        Icon = "refresh-cw",
        Callback = function()
            if TranslateEngine.isRunning then
                scanAndTranslate()
            else
                Notification:Notify(
                    {Title = "极速汉化", Description = "请先启用极速汉化"},
                    {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 3, Type = "image"},
                    {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 150, 255)}
                )
            end
        end
    })

    TabHandles.Translate:Button({
        Title = "清空翻译缓存",
        Icon = "trash-2",
        Callback = function()
            TranslateEngine.cache = {}
            Notification:Notify(
                {Title = "极速汉化", Description = "翻译缓存已清空"},
                {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 3, Type = "image"},
                {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 150, 255)}
            )
        end
    })

    -- ========== 最强战场标签页 ==========
    TabHandles.Strongest:Paragraph({
        Title = "最强战场脚本",
        Desc = "加载最强战场相关功能脚本",
        Image = "crosshair",
        ImageSize = 20,
        Color = Color3.fromHex("#0078D7")
    })

    TabHandles.Strongest:Divider()

    -- 不知名脚本一
    TabHandles.Strongest:Button({
        Title = "加载不知名脚本一",
        Icon = "download",
        Callback = function()
            Notification:Notify(
                {Title = "最强战场", Description = "正在加载不知名脚本一..."},
                {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 3, Type = "image"},
                {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 150, 255)}
            )
            
            local success, err = pcall(function()
                loadstring(game:HttpGet("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x72\x61\x77\x2e\x67\x69\x74\x68\x75\x62\x75\x73\x65\x72\x63\x6f\x6e\x74\x65\x6e\x74\x2e\x63\x6f\x6d\x2f\x63\x79\x74\x6a\x37\x37\x37\x69\x2f\x44\x65\x6c\x69\x76\x65\x72\x2d\x74\x68\x72\x6f\x75\x67\x68\x2d\x74\x68\x65\x2d\x77\x61\x6c\x6c\x2d\x70\x65\x72\x73\x70\x65\x63\x74\x69\x76\x65\x2f\x6d\x61\x69\x6e\x2f\xe5\xa4\xa9\xe4\xb8\x8b\xe5\xb8\x83\xe6\xad\xa6"))()
            end)
            
            if success then
                Notification:Notify(
                    {Title = "最强战场", Description = "不知名脚本一加载成功！"},
                    {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 3, Type = "image"},
                    {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 150, 255)}
                )
            else
                Notification:Notify(
                    {Title = "最强战场", Description = "不知名脚本一加载失败: " .. tostring(err)},
                    {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 5, Type = "image"},
                    {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 150, 255)}
                )
            end
        end
    })

    -- 不知名脚本二
    TabHandles.Strongest:Button({
        Title = "加载不知名脚本二",
        Icon = "download",
        Callback = function()
            Notification:Notify(
                {Title = "最强战场", Description = "正在加载不知名脚本二..."},
                {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 3, Type = "image"},
                {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 150, 255)}
            )
            
            local success, err = pcall(function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/cytj777i/Deliver-through-the-wall-perspective/main/%E8%87%AA%E5%8A%A8%E6%9C%9D%E5%90%91"))()
            end)
            
            if success then
                Notification:Notify(
                    {Title = "最强战场", Description = "不知名脚本二加载成功！"},
                    {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 3, Type = "image"},
                    {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 150, 255)}
                )
            else
                Notification:Notify(
                    {Title = "最强战场", Description = "不知名脚本二加载失败: " .. tostring(err)},
                    {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 5, Type = "image"},
                    {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 150, 255)}
                )
            end
        end
    })

    -- 隐身脚本
    TabHandles.Strongest:Button({
        Title = "加载隐身脚本",
        Icon = "eye-off",
        Callback = function()
            Notification:Notify(
                {Title = "最强战场", Description = "正在加载隐身脚本..."},
                {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 3, Type = "image"},
                {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 150, 255)}
            )
            
            local success, err = pcall(function()
                loadstring(game:HttpGet("https://rawscripts.net/raw/The-Strongest-Battlegrounds-NSExpression-v2-a3-TSBG-20252"))()
            end)
            
            if success then
                Notification:Notify(
                    {Title = "最强战场", Description = "隐身脚本加载成功！"},
                    {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 3, Type = "image"},
                    {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 150, 255)}
                )
            else
                Notification:Notify(
                    {Title = "最强战场", Description = "隐身脚本加载失败: " .. tostring(err)},
                    {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 5, Type = "image"},
                    {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 150, 255)}
                )
            end
        end
    })

    TabHandles.Strongest:Paragraph({
        Title = "提示",
        Desc = "这些脚本专为最强战场游戏设计",
        Image = "info",
        ImageSize = 16,
        Color = Color3.fromHex("#0099FF")
    })

    -- ========== 被遗弃标签页 ==========
    TabHandles.Abandoned:Paragraph({
        Title = "被遗弃脚本",
        Desc = "加载被遗弃相关功能脚本",
        Image = "archive",
        ImageSize = 20,
        Color = Color3.fromHex("#0078D7")
    })

    TabHandles.Abandoned:Divider()

    -- B0bby脚本
    TabHandles.Abandoned:Button({
        Title = "加载B0bby脚本",
        Icon = "download",
        Callback = function()
            Notification:Notify(
                {Title = "被遗弃", Description = "正在加载B0bby脚本..."},
                {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 3, Type = "image"},
                {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 150, 255)}
            )
            
            local success, err = pcall(function()
                getgenv().XiaoPi="被遗弃-B0bby[汉化版]" 
                loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaopi77/xiaopi77/187ec501507e956200e0741a7bc38ca1cd83973f/%E8%A2%AB%E9%81%97%E5%BC%83B0bby%E6%B1%89%E5%8C%96%20(1).lua"))()
            end)
            
            if success then
                Notification:Notify(
                    {Title = "被遗弃", Description = "B0bby脚本加载成功！"},
                    {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 3, Type = "image"},
                    {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 150, 255)}
                )
            else
                Notification:Notify(
                    {Title = "被遗弃", Description = "B0bby脚本加载失败: " .. tostring(err)},
                    {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 5, Type = "image"},
                    {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 150, 255)}
                )
            end
        end
    })

    -- 复制卡密按钮
    TabHandles.Abandoned:Button({
        Title = "复制卡密",
        Icon = "copy",
        Callback = function()
            local key = "Samuelspizzatrip"
            setclipboard(key)
            Notification:Notify(
                {Title = "被遗弃", Description = "卡密已复制到剪贴板: " .. key},
                {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 5, Type = "image"},
                {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 150, 255)}
            )
        end
    })

    TabHandles.Abandoned:Paragraph({
        Title = "使用说明",
        Desc = "1. 先复制卡密\n2. 然后加载B0bby脚本\n3. 在脚本中输入复制的卡密",
        Image = "info",
        ImageSize = 16,
        Color = Color3.fromHex("#0099FF")
    })

    -- ========== 99页标签页 ==========
    TabHandles.V99:Paragraph({
        Title = "99页脚本集合",
        Desc = "加载各种强大的99页脚本",
        Image = "box",
        ImageSize = 20,
        Color = Color3.fromHex("#0078D7")
    })

    TabHandles.V99:Divider()

    -- 虚空脚本
    TabHandles.V99:Button({
        Title = "加载虚空脚本",
        Icon = "download",
        Callback = function()
            Notification:Notify(
                {Title = "99页", Description = "正在加载虚空脚本..."},
                {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 3, Type = "image"},
                {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 150, 255)}
            )
            
            local success, err = pcall(function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/nightsintheforest.lua", true))()
            end)
            
            if success then
                Notification:Notify(
                    {Title = "99页", Description = "虚空脚本加载成功！"},
                    {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 3, Type = "image"},
                    {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 150, 255)}
                )
            else
                Notification:Notify(
                    {Title = "99页", Description = "虚空脚本加载失败: " .. tostring(err)},
                    {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 5, Type = "image"},
                    {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 150, 255)}
                )
            end
        end
    })

    -- 99夜红蛇
    TabHandles.V99:Button({
        Title = "加载99夜红蛇",
        Icon = "download",
        Callback = function()
            Notification:Notify(
                {Title = "99页", Description = "正在加载99夜红蛇脚本..."},
                {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 3, Type = "image"},
                {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 150, 255)}
            )
            
            local success, err = pcall(function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
            end)
            
            if success then
                Notification:Notify(
                    {Title = "99页", Description = "99夜红蛇脚本加载成功！"},
                    {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 3, Type = "image"},
                    {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 150, 255)}
                )
            else
                Notification:Notify(
                    {Title = "99页", Description = "99夜红蛇脚本加载失败: " .. tostring(err)},
                    {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 5, Type = "image"},
                    {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 150, 255)}
                )
            end
        end
    })

    -- 不知名99夜
    TabHandles.V99:Button({
        Title = "加载不知名99夜",
        Icon = "download",
        Callback = function()
            Notification:Notify(
                {Title = "99页", Description = "正在加载不知名99夜脚本..."},
                {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 3, Type = "image"},
                {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 150, 255)}
            )
            
            local success, err = pcall(function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/adibhub1/99-nighit-in-forest/refs/heads/main/99%20night%20in%20forest"))()
            end)
            
            if success then
                Notification:Notify(
                    {Title = "99页", Description = "不知名99夜脚本加载成功！"},
                    {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 3, Type = "image"},
                    {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 150, 255)}
                )
            else
                Notification:Notify(
                    {Title = "99页", Description = "不知名99夜脚本加载失败: " .. tostring(err)},
                    {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 5, Type = "image"},
                    {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 150, 255)}
                )
            end
        end
    })

    -- H4x99页脚本
    TabHandles.V99:Button({
        Title = "加载H4x99页脚本",
        Icon = "download",
        Callback = function()
            Notification:Notify(
                {Title = "99页", Description = "正在加载H4x99页脚本..."},
                {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 3, Type = "image"},
                {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 150, 255)}
            )
            
            local success, err = pcall(function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/xyx8846/-/refs/heads/main/H4x%E6%B1%89%E5%8C%96%E8%84%9A%E6%9C%AC"))()
            end)
            
            if success then
                Notification:Notify(
                    {Title = "99页", Description = "H4x99页脚本加载成功！"},
                    {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 3, Type = "image"},
                    {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 150, 255)}
                )
            else
                Notification:Notify(
                    {Title = "99页", Description = "H4x99页脚本加载失败: " .. tostring(err)},
                    {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 5, Type = "image"},
                    {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 150, 255)}
                )
            end
        end
    })

    -- 可杀队友脚本
    TabHandles.V99:Button({
        Title = "加载可杀队友脚本",
        Icon = "users",
        Callback = function()
            Notification:Notify(
                {Title = "99页", Description = "正在加载可杀队友脚本..."},
                {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 3, Type = "image"},
                {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 150, 255)}
            )
            
            local success, err = pcall(function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/358545698555/roblox-/refs/heads/main/%E5%8F%AF%E6%9D%80%E9%98%9F%E5%8F%8B99%E5%A4%9C"))()
            end)
            
            if success then
                Notification:Notify(
                    {Title = "99页", Description = "可杀队友脚本加载成功！"},
                    {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 3, Type = "image"},
                    {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 150, 255)}
                )
            else
                Notification:Notify(
                    {Title = "99页", Description = "可杀队友脚本加载失败: " .. tostring(err)},
                    {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 5, Type = "image"},
                    {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 150, 255)}
                )
            end
        end
    })

    -- OP99页脚本
    TabHandles.V99:Button({
        Title = "加载OP99页脚本",
        Icon = "zap",
        Callback = function()
            Notification:Notify(
                {Title = "99页", Description = "正在加载OP99页脚本..."},
                {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 3, Type = "image"},
                {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 150, 255)}
            )
            
            local success, err = pcall(function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/hdjsjjdgrhj/script-hub/refs/heads/main/99Nights"))()
            end)
            
            if success then
                Notification:Notify(
                    {Title = "99页", Description = "OP99页脚本加载成功！"},
                    {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 3, Type = "image"},
                    {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 150, 255)}
                )
            else
                Notification:Notify(
                    {Title = "99页", Description = "OP99页脚本加载失败: " .. tostring(err)},
                    {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 5, Type = "image"},
                    {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 150, 255)}
                )
            end
        end
    })

    -- 二狗子99页脚本
    TabHandles.V99:Button({
        Title = "加载二狗子99页脚本",
        Icon = "github",
        Callback = function()
            Notification:Notify(
                {Title = "99页", Description = "正在加载二狗子99页脚本..."},
                {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 3, Type = "image"},
                {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 150, 255)}
            )
            
            local success, err = pcall(function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/gycgchgyfytdttr/shenqin/refs/heads/main/99day.lua"))()
            end)
            
            if success then
                Notification:Notify(
                    {Title = "99页", Description = "二狗子99页脚本加载成功！"},
                    {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 3, Type = "image"},
                    {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 150, 255)}
                )
            else
                Notification:Notify(
                    {Title = "99页", Description = "二狗子99页脚本加载失败: " .. tostring(err)},
                    {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 5, Type = "image"},
                    {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 150, 255)}
                )
            end
        end
    })

    TabHandles.V99:Paragraph({
        Title = "提示",
        Desc = "这些脚本都很强大，请谨慎使用",
        Image = "info",
        ImageSize = 16,
        Color = Color3.fromHex("#0099FF")
    })

    -- ========== 死铁轨标签页 ==========
    TabHandles.DeadRails:Paragraph({
        Title = "死铁轨脚本",
        Desc = "加载死铁轨相关功能脚本",
        Image = "train",
        ImageSize = 20,
        Color = Color3.fromHex("#0078D7")
    })

    TabHandles.DeadRails:Divider()

    -- Dead脚本
    TabHandles.DeadRails:Button({
        Title = "加载Dead脚本",
        Icon = "download",
        Callback = function()
            Notification:Notify(
                {Title = "死铁轨", Description = "正在加载Dead脚本..."},
                {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 3, Type = "image"},
                {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 150, 255)}
            )
            
            local success, err = pcall(function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/Articles-Hub/ROBLOXScript/refs/heads/main/File-Script/Dead%20rails.lua"))()
            end)
            
            if success then
                Notification:Notify(
                    {Title = "死铁轨", Description = "Dead脚本加载成功！"},
                    {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 3, Type = "image"},
                    {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 150, 255)}
                )
            else
                Notification:Notify(
                    {Title = "死铁轨", Description = "Dead脚本加载失败: " .. tostring(err)},
                    {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 5, Type = "image"},
                    {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 150, 255)}
                )
            end
        end
    })

    -- VZ脚本
    TabHandles.DeadRails:Button({
        Title = "加载VZ脚本",
        Icon = "download",
        Callback = function()
            Notification:Notify(
                {Title = "死铁轨", Description = "正在加载VZ脚本..."},
                {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 3, Type = "image"},
                {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 150, 255)}
            )
            
            local success, err = pcall(function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/Dex-Bear/Vxezehub/refs/heads/main/VxezeHubMain"))()
            end)
            
            if success then
                Notification:Notify(
                    {Title = "死铁轨", Description = "VZ脚本加载成功！"},
                    {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 3, Type = "image"},
                    {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 150, 255)}
                )
            else
                Notification:Notify(
                    {Title = "死铁轨", Description = "VZ脚本加载失败: " .. tostring(err)},
                    {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 5, Type = "image"},
                    {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 150, 255)}
                )
            end
        end
    })

    TabHandles.DeadRails:Paragraph({
        Title = "注意",
        Desc = "这些脚本专为死铁轨游戏设计",
        Image = "info",
        ImageSize = 16,
        Color = Color3.fromHex("#0099FF")
    })

    -- ========== 墨水游戏标签页 ==========
    TabHandles.InkGame:Paragraph({
        Title = "墨水游戏脚本",
        Desc = "加载墨水游戏相关功能",
        Image = "pen-tool",
        ImageSize = 20,
        Color = Color3.fromHex("#0078D7")
    })

    TabHandles.InkGame:Button({
        Title = "加载墨水游戏汉化",
        Icon = "download",
        Callback = function()
            Notification:Notify(
                {Title = "墨水游戏", Description = "正在加载墨水游戏汉化脚本..."},
                {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 3, Type = "image"},
                {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 150, 255)}
            )
            
            local success, err = pcall(function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/hdjsjjdgrhj/script-hub/refs/heads/main/Ringta"))()
            end)
            
            if success then
                Notification:Notify(
                    {Title = "墨水游戏", Description = "墨水游戏汉化脚本加载成功！"},
                    {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 3, Type = "image"},
                    {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 150, 255)}
                )
            else
                Notification:Notify(
                    {Title = "墨水游戏", Description = "墨水游戏汉化脚本加载失败: " .. tostring(err)},
                    {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 5, Type = "image"},
                    {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 150, 255)}
                )
            end
        end
    })

    TabHandles.InkGame:Paragraph({
        Title = "注意",
        Desc = "这个有防作弊",
        Image = "alert-triangle",
        ImageSize = 16,
        Color = Color3.fromHex("#0099FF")
    })

    -- ========== 其他功能标签页 ==========
    TabHandles.Other:Paragraph({
        Title = "其他功能",
        Desc = "各种实用工具和FE功能",
        Image = "grid",
        ImageSize = 20,
        Color = Color3.fromHex("#0078D7")
    })

    TabHandles.Other:Divider()

    -- 修复的无限R恶作剧按钮
    TabHandles.Other:Button({
        Title = "无限R",
        Icon = "alert-triangle",
        Callback = function()
            -- 创建加载界面
            local prankLoadingGui = Instance.new("ScreenGui")
            prankLoadingGui.Name = "PrankLoadingGui"
            prankLoadingGui.ResetOnSpawn = false
            prankLoadingGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
            
            local loadingFrame = Instance.new("Frame")
            loadingFrame.Size = UDim2.new(1, 0, 1, 0)
            loadingFrame.BackgroundColor3 = Color3.fromRGB(0, 30, 60)
            loadingFrame.BackgroundTransparency = 0.1
            loadingFrame.ZIndex = 1000
            loadingFrame.Parent = prankLoadingGui
            
            local loadingContainer = Instance.new("Frame")
            loadingContainer.Size = UDim2.new(0.6, 0, 0.4, 0)
            loadingContainer.Position = UDim2.new(0.2, 0, 0.3, 0)
            loadingContainer.BackgroundColor3 = Color3.fromRGB(0, 50, 100)
            loadingContainer.BackgroundTransparency = 0.2
            loadingContainer.ZIndex = 1001
            loadingContainer.Parent = loadingFrame
            
            local loadingCorner = Instance.new("UICorner")
            loadingCorner.CornerRadius = UDim.new(0.05, 0)
            loadingCorner.Parent = loadingContainer
            
            local loadingBorder = Instance.new("UIStroke")
            loadingBorder.Color = Color3.fromRGB(0, 150, 255)
            loadingBorder.Thickness = 3
            loadingBorder.Parent = loadingContainer
            
            local loadingText = Instance.new("TextLabel")
            loadingText.Size = UDim2.new(0.8, 0, 0.3, 0)
            loadingText.Position = UDim2.new(0.1, 0, 0.1, 0)
            loadingText.BackgroundTransparency = 1
            loadingText.Text = "正在加载无限R功能..."
            loadingText.TextColor3 = Color3.fromRGB(255, 255, 255)
            loadingText.TextSize = 28
            loadingText.Font = Enum.Font.GothamBold
            loadingText.ZIndex = 1002
            loadingText.Parent = loadingContainer
            
            local progressBackground = Instance.new("Frame")
            progressBackground.Size = UDim2.new(0.8, 0, 0.1, 0)
            progressBackground.Position = UDim2.new(0.1, 0, 0.5, 0)
            progressBackground.BackgroundColor3 = Color3.fromRGB(0, 80, 160)
            progressBackground.BorderSizePixel = 0
            progressBackground.ZIndex = 1002
            progressBackground.Parent = loadingContainer
            
            local progressCorner = Instance.new("UICorner")
            progressCorner.CornerRadius = UDim.new(0.5, 0)
            progressCorner.Parent = progressBackground
            
            local progressBar = Instance.new("Frame")
            progressBar.Size = UDim2.new(0, 0, 1, 0)
            progressBar.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
            progressBar.BorderSizePixel = 0
            progressBar.ZIndex = 1003
            progressBar.Parent = progressBackground
            
            local barCorner = Instance.new("UICorner")
            barCorner.CornerRadius = UDim.new(0.5, 0)
            barCorner.Parent = progressBar
            
            local percentText = Instance.new("TextLabel")
            percentText.Size = UDim2.new(0.8, 0, 0.3, 0)
            percentText.Position = UDim2.new(0.1, 0, 0.65, 0)
            percentText.BackgroundTransparency = 1
            percentText.Text = "0%"
            percentText.TextColor3 = Color3.fromRGB(200, 230, 255)
            percentText.TextSize = 24
            percentText.Font = Enum.Font.Gotham
            percentText.ZIndex = 1002
            percentText.Parent = loadingContainer
            
            prankLoadingGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
            
            -- 模拟加载进度
            local loadDuration = 3
            local startTime = tick()
            
            -- 加载动画
            spawn(function()
                while tick() - startTime < loadDuration do
                    local progress = (tick() - startTime) / loadDuration
                    progressBar.Size = UDim2.new(progress, 0, 1, 0)
                    percentText.Text = string.format("%d%%", math.floor(progress * 100))
                    
                    -- 闪烁效果
                    loadingBorder.Transparency = 0.3 + math.sin(tick() * 10) * 0.3
                    
                    task.wait()
                end
                
                percentText.Text = "100%"
                progressBar.Size = UDim2.new(1, 0, 1, 0)
                
                -- 加载完成，显示嘲讽界面
                task.wait(1)
                prankLoadingGui:Destroy()
                
                -- 创建嘲讽界面
                local prankGui = Instance.new("ScreenGui")
                prankGui.Name = "PrankGui"
                prankGui.ResetOnSpawn = false
                prankGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
                
                local frame = Instance.new("Frame")
                frame.Size = UDim2.new(1, 0, 1, 0)
                frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                frame.BackgroundTransparency = 0
                frame.ZIndex = 1000
                frame.Parent = prankGui
                
                local label = Instance.new("TextLabel")
                label.Size = UDim2.new(1, 0, 0.5, 0)
                label.Position = UDim2.new(0, 0, 0.25, 0)
                label.BackgroundTransparency = 1
                label.Text = "不是，你还真信呀 🖕🏻🖕🏻🖕🏻 😂😂😂"
                label.TextColor3 = Color3.fromRGB(255, 0, 0)
                label.TextScaled = true
                label.Font = Enum.Font.SourceSansBold
                label.ZIndex = 1001
                label.Parent = frame
                
                -- 添加闪烁效果
                spawn(function()
                    while true do
                        label.TextColor3 = Color3.fromRGB(255, 0, 0)
                        task.wait(0.5)
                        label.TextColor3 = Color3.fromRGB(255, 255, 0)
                        task.wait(0.5)
                    end
                end)
                
                -- 添加真实音效
                spawn(function()
                    -- 创建音效
                    local sound = Instance.new("Sound")
                    sound.SoundId = "rbxassetid://9117008338"  -- 嘲讽笑声音效
                    sound.Volume = 1
                    sound.Parent = game:GetService("SoundService")
                    
                    -- 播放音效
                    sound:Play()
                    
                    -- 等待音效播放完成
                    wait(3)
                    
                    -- 循环播放音效
                    while true do
                        sound:Play()
                        wait(5)
                    end
                end)
                
                prankGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
                
                -- 等待确保界面和声音都显示/播放了
                wait(3)
                
                -- 卡死游戏
                while true do
                    -- 无限循环导致游戏卡死
                    for i = 1, 1000000 do
                        -- 大量计算操作卡死游戏
                        local x = math.random(1, 1000000)
                        local y = math.random(1, 1000000)
                        local z = x * y / math.random(1, 1000)
                    end
                end
            end)
        end
    })

    TabHandles.Other:Button({
        Title = "显示服务器信息",
        Icon = "server",
        Callback = function()
            local players = game.Players:GetPlayers()
            Notification:Notify(
                {Title = "服务器信息", Description = "玩家数量: " .. #players .. "/" .. game.Players.MaxPlayers},
                {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 5, Type = "image"},
                {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 150, 255)}
            )
        end
    })

    TabHandles.Other:Button({
        Title = "重置角色",
        Icon = "refresh-cw",
        Callback = function()
            if game.Players.LocalPlayer.Character then
                game.Players.LocalPlayer.Character:BreakJoints()
                Notification:Notify(
                    {Title = "重置角色", Description = "角色已重置"},
                    {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 2, Type = "image"},
                    {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 150, 255)}
                )
            end
        end
    })

    TabHandles.Other:Divider()

    -- FE功能
    TabHandles.Other:Paragraph({
        Title = "FE功能",
        Desc = "各种FE脚本",
        Image = "zap",
        ImageSize = 18,
        Color = Color3.fromHex("#0099FF")
    })

    TabHandles.Other:Button({
        Title = "R15无敌少侠飞行",
        Icon = "wind",
        Callback = function()
            Notification:Notify(
                {Title = "FE功能", Description = "正在加载R15无敌少侠飞行..."},
                {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 3, Type = "image"},
                {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 150, 255)}
            )
            loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Invinicible-Flight-R15-45414"))()
        end
    })

    TabHandles.Other:Button({
        Title = "R6无敌少侠飞行",
        Icon = "wind",
        Callback = function()
            Notification:Notify(
                {Title = "FE功能", Description = "正在加载R6无敌少侠飞行..."},
                {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 3, Type = "image"},
                {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 150, 255)}
            )
            loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/%E6%97%A0%E6%95%8C%E5%B0%91%E4%BE%A0%E9%A3%9E%E8%A1%8Cr6.txt"))()
        end
    })

    TabHandles.Other:Button({
        Title = "蛇动作",
        Icon = "activity",
        Callback = function()
            Notification:Notify(
                {Title = "FE功能", Description = "正在加载蛇动作..."},
                {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 3, Type = "image"},
                {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 150, 255)}
            )
            loadstring(game:HttpGet("https://raw.githubusercontent.com/randomstring0/qwertys/refs/heads/main/qwerty5.lua"))()
        end
    })

    TabHandles.Other:Button({
        Title = "防摔落",
        Icon = "shield",
        Callback = function()
            Notification:Notify(
                {Title = "FE功能", Description = "正在加载防摔落..."},
                {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 3, Type = "image"},
                {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 150, 255)}
            )
            loadstring(game:HttpGet("http://rawscripts.net/raw/Universal-Script-Touch-fling-script-22447"))()
        end
    })

    -- 页脚信息
    TabHandles.Other:Paragraph({
        Title = "关于",
        Desc = "作者: 皮炎\n联系方式: 快手1466456286",
        Image = "user",
        ImageSize = 20,
        Color = Color3.fromHex("#00A2FF"),
        Buttons = {
            {
                Title = "复制联系方式",
                Icon = "copy",
                Variant = "Tertiary",
                Callback = function()
                    setclipboard("快手1466456286")
                    Notification:Notify(
                        {Title = "复制成功", Description = "已复制联系方式到剪贴板"},
                        {OutlineColor = Color3.fromRGB(0, 100, 200),Time = 2, Type = "image"},
                        {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 150, 255)}
                    )
                end
            }
        }
    })

    -- 窗口关闭时的处理
    Window:OnClose(function()
        print("皮空重置 - 窗口已关闭")
        
        if Stepped then
            Stepped:Disconnect()
        end
    end)

    print("皮空重置 - WindUI界面初始化完成！")
end
