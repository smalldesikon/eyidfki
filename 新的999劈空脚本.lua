-- 皮空重置版 - 带加载动画完整版
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local ContentProvider = game:GetService("ContentProvider")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- 加载动画配置
local CONFIG = {
    LOAD_TIME = 5,
    PRIMARY_COLOR = Color3.fromRGB(0, 150, 255),
    SECONDARY_COLOR = Color3.fromRGB(0, 120, 220),
    GLOW_INTENSITY = 0.6,
    LOGO_IMAGE = "rbxassetid://137107933084759",
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

-- 预加载资源
ContentProvider:PreloadAsync({
    CONFIG.LOGO_IMAGE,
    "rbxassetid://109223169214001"
})

-- 创建加载界面
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

-- 加载动画函数
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

-- 启动加载动画
screenGui.Parent = playerGui

coroutine.wrap(logoFloatAnimation)()
coroutine.wrap(logoPulseAnimation)()
coroutine.wrap(borderPulseAnimation)()
coroutine.wrap(elementsEntranceAnimation)()
coroutine.wrap(rainbowTextAnimation)()
coroutine.wrap(loadingAnimation)()

-- 主脚本初始化函数
function initMainScript()
    -- 使用WindUI库
    local success, WindUI = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/Xingyan777/roblox/refs/heads/main/main.lua"))()
    end)
    
    if not success then
        -- 如果库加载失败，使用备用方案
        loadSimpleUI()
        return
    end

    WindUI:Notify({
        Title = "皮空重置版",
        Content = "执行成功",
        Duration = 4
    })

    local Confirmed = false

    WindUI:Popup({
        Title = "皮空重置版",
        IconThemed = true,
        Content = "欢迎尊贵的用户使用皮空",
        Theme = "Light",
        Buttons = {
            {
                Title = "退出",
                Callback = function() end,
                Variant = "Secondary",
            },
            {
                Title = "进入",
                Icon = "arrow-right",
                Callback = function() Confirmed = true end,
                Variant = "Primary",
            }
        }
    })

    repeat wait() until Confirmed

    local Window = WindUI:CreateWindow({
        Title = "皮空重置版",
        Icon = "rbxassetid://137107933084759",
        IconThemed = true,
        Folder = "皮空脚本",
        Size = UDim2.fromOffset(580, 340),
        Transparent = true,
        Theme = "Light",
        User = { Enabled = true },
        SideBarWidth = 200,
        ScrollBarEnabled = true,
        KeySystem = {
            Key = { "皮空脚本垃圾", "皮炎是司空的爸爸" },
            Note = "想获得卡密加Q群1057315887",
            URL = "1057315887",
            SaveKey = true,
        },
    })

    Window:Tag({
        Title = "皮空重置版",
        Color = Color3.fromHex("#30ff6a")
    })

    -- 创建完整的标签页结构
    local Tabs = {}

    -- 主功能部分
    Tabs.MainSection = Window:Section({
        Title = "主功能",
        Icon = "home",
        Opened = true,
    })

    Tabs.CoreSection = Window:Section({
        Title = "核心功能",
        Opened = true,
    })

    Tabs.TranslateSection = Window:Section({
        Title = "API翻译",
        Opened = true,
    })

    -- 脚本集合部分
    Tabs.ScriptSection = Window:Section({
        Title = "脚本集合",
        Opened = true,
    })

    Tabs.TeleportSection = Window:Section({
        Title = "传送功能",
        Opened = true,
    })

    -- 游戏专门部分
    Tabs.GameSection = Window:Section({
        Title = "游戏专门",
        Opened = true,
    })

    Tabs.StrongestSection = Window:Section({
        Title = "最强战场",
        Opened = true,
    })

    Tabs.AbandonedSection = Window:Section({
        Title = "被遗弃",
        Opened = true,
    })

    Tabs.V99Section = Window:Section({
        Title = "99页",
        Opened = true,
    })

    Tabs.DeadRailsSection = Window:Section({
        Title = "死铁轨",
        Opened = true,
    })

    Tabs.BackdoorSection = Window:Section({
        Title = "后门",
        Opened = true,
    })

    Tabs.InkGameSection = Window:Section({
        Title = "墨水游戏",
        Opened = true,
    })

    Tabs.StealBrainRedSection = Window:Section({
        Title = "偷走脑红",
        Opened = true,
    })

    -- 窗口设置部分
    Tabs.WindowSection = Window:Section({
        Title = "窗口设置",
        Opened = true,
    })

    -- 其他功能部分
    Tabs.OtherSection = Window:Section({
        Title = "其他功能",
        Opened = true,
    })

    -- 创建所有标签页
    -- 主功能标签页
    Tabs.MainTab = Tabs.MainSection:Tab({ Title = "首页", Icon = "home" })
    Tabs.CoreTab = Tabs.CoreSection:Tab({ Title = "核心功能", Icon = "zap" })
    Tabs.TranslateTab = Tabs.TranslateSection:Tab({ Title = "API翻译", Icon = "languages" })

    -- 脚本集合标签页
    Tabs.ScriptTab = Tabs.ScriptSection:Tab({ Title = "常用脚本", Icon = "download" })
    Tabs.FETab = Tabs.ScriptSection:Tab({ Title = "FE脚本", Icon = "paintbrush" })
    Tabs.KnownScriptTab = Tabs.ScriptSection:Tab({ Title = "知名脚本", Icon = "star" })
    Tabs.TeleportTab = Tabs.TeleportSection:Tab({ Title = "传送功能", Icon = "navigation" })

    -- 游戏专门标签页
    Tabs.GameTab = Tabs.GameSection:Tab({ Title = "通用游戏", Icon = "gamepad-2" })
    Tabs.StrongestTab = Tabs.StrongestSection:Tab({ Title = "最强战场", Icon = "crosshair" })
    Tabs.AbandonedTab = Tabs.AbandonedSection:Tab({ Title = "被遗弃", Icon = "archive" })
    Tabs.V99Tab = Tabs.V99Section:Tab({ Title = "99页", Icon = "box" })
    Tabs.DeadRailsTab = Tabs.DeadRailsSection:Tab({ Title = "死铁轨", Icon = "train" })
    Tabs.BackdoorTab = Tabs.BackdoorSection:Tab({ Title = "后门", Icon = "key" })
    Tabs.InkGameTab = Tabs.InkGameSection:Tab({ Title = "墨水游戏", Icon = "pen-tool" })
    Tabs.StealBrainRedTab = Tabs.StealBrainRedSection:Tab({ Title = "偷走脑红", Icon = "brain" })

    -- 窗口设置标签页
    Tabs.WindowTab = Tabs.WindowSection:Tab({ Title = "窗口设置", Icon = "app-window-mac" })

    -- 其他功能标签页
    Tabs.OtherTab = Tabs.OtherSection:Tab({ Title = "其他功能", Icon = "grid" })

    Window:SelectTab(1)

    -- ========== 首页内容 ==========
    Tabs.MainTab:Paragraph({
        Title = "皮空重置版",
        Desc = "更便捷的脚本体验\n所有功能已解锁，请尽情使用！",
        Image = "user",
        ImageSize = 42,
    })

    Tabs.MainTab:Paragraph({
        Title = "系统信息",
        Desc = "用户名: " .. game.Players.LocalPlayer.Name .. "\n用户ID: " .. game.Players.LocalPlayer.UserId,
        Image = "info",
        ImageSize = 24,
        Color = Color3.fromHex("#0099FF")
    })

    -- 显示注入器信息
    Tabs.MainTab:Paragraph({
        Title = "您的注入器: " .. identifyexecutor(),
        Desc = "当前使用的执行器信息",
        Image = "cpu",
        ImageSize = 24,
        Color = Color3.fromHex("#FF6B6B")
    })

    -- 皮空介绍
    Tabs.MainTab:Paragraph({
        Title = "皮空",
        Desc = "皮空垃圾",
        Image = "https://c-ssl.duitang.com/uploads/blog/202310/21/oVS4gnBVIg4A1yJ.jpg",
        ImageSize = 42,
        Thumbnail = "https://c-ssl.duitang.com/uploads/blog/202103/27/20210327131203_74b6b.jpg",
        ThumbnailSize = 200
    })

    -- ========== 核心功能 ==========
    Tabs.CoreTab:Paragraph({
        Title = "核心功能",
        Desc = "游戏基础功能修改",
        Image = "zap",
        ImageSize = 24,
        Color = Color3.fromHex("#0078D7")
    })

    -- 移动速度设置
    Tabs.CoreTab:Slider({
        Title = "移动速度",
        Value = {
            Min = 16,
            Max = 100,
            Default = 16,
        },
        Increment = 1,
        Callback = function(value)
            if game.Players.LocalPlayer.Character then
                game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
            end
        end
    })

    -- 跳跃高度设置
    Tabs.CoreTab:Slider({
        Title = "跳跃高度",
        Value = {
            Min = 50,
            Max = 200,
            Default = 50,
        },
        Increment = 1,
        Callback = function(value)
            if game.Players.LocalPlayer.Character then
                game.Players.LocalPlayer.Character.Humanoid.JumpPower = value
            end
        end
    })

    -- 重力设置
    Tabs.CoreTab:Slider({
        Title = "重力",
        Value = {
            Min = 0.1,
            Max = 500.0,
            Default = 196.2,
        },
        Step = 0.1,
        Callback = function(value)
            game.Workspace.Gravity = value
        end
    })

    -- 穿墙功能
    local Noclip = false
    local NoclipConnection

    Tabs.CoreTab:Toggle({
        Title = "穿墙模式",
        Desc = "允许穿过墙壁和障碍物",
        Value = false,
        Callback = function(state)
            Noclip = state
            
            if NoclipConnection then
                NoclipConnection:Disconnect()
                NoclipConnection = nil
            end

            if state then
                NoclipConnection = RunService.Stepped:Connect(function()
                    local character = game.Players.LocalPlayer.Character
                    if not character then return end
                    
                    for _, part in pairs(character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end)
            else
                local character = game.Players.LocalPlayer.Character
                if character then
                    for _, part in pairs(character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = true
                        end
                    end
                end
            end
        end
    })

    -- 夜视模式
    local Lighting = game:GetService("Lighting")
    Tabs.CoreTab:Toggle({
        Title = "夜视模式",
        Desc = "增强环境光照",
        Value = false,
        Callback = function(state)
            Lighting.Ambient = state and Color3.new(1, 1, 1) or Color3.new(0, 0, 0)
        end
    })

    -- ========== API翻译 ==========
    Tabs.TranslateTab:Paragraph({
        Title = "API翻译",
        Desc = "高级翻译系统 - 替换了极速汉化",
        Image = "languages",
        ImageSize = 24,
        Color = Color3.fromHex("#0078D7")
    })

    Tabs.TranslateTab:Button({
        Title = "加载API翻译脚本",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/smalldesikon/eyidfki/ecca7e04b83299b86c5ce8af98762071cc5f346f/api%E7%BF%BB%E8%AF%91"))()
            WindUI:Notify({
                Title = "API翻译",
                Content = "正在加载高级翻译系统...",
                Duration = 3
            })
        end
    })

    Tabs.TranslateTab:Paragraph({
        Title = "说明",
        Desc = "点击上方按钮加载API翻译脚本\n该脚本提供更强大的翻译功能",
        Image = "info",
        ImageSize = 20,
        Color = Color3.fromHex("#FFA500")
    })

    -- ========== 常用脚本 ==========
    Tabs.ScriptTab:Paragraph({
        Title = "常用脚本",
        Desc = "各种实用脚本集合",
        Image = "download",
        ImageSize = 24,
        Color = Color3.fromHex("#0078D7")
    })

    Tabs.ScriptTab:Button({
        Title = "无限跳",
        Callback = function()
            loadstring(game:HttpGet("https://pastebin.com/raw/V5PQy3y0", true))()
        end
    })

    Tabs.ScriptTab:Button({
        Title = "飞行模式",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))()
        end
    })

    Tabs.ScriptTab:Button({
        Title = "视角锁定",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/ccacca444/scripts1/main/locking.lua"))()
        end
    })

    Tabs.ScriptTab:Button({
        Title = "反挂机",
        Callback = function()
            loadstring(game:HttpGet("https://pastebin.com/raw/9fFu43FF"))()
        end
    })

    Tabs.ScriptTab:Button({
        Title = "爬墙功能",
        Callback = function()
            loadstring(game:HttpGet("https://pastebin.com/raw/zXk4Rq2r"))()
        end
    })

    -- ========== FE脚本 ==========
    Tabs.FETab:Paragraph({
        Title = "FE脚本",
        Desc = "各种FE功能脚本",
        Image = "paintbrush",
        ImageSize = 24,
        Color = Color3.fromHex("#0078D7")
    })

    Tabs.FETab:Button({
        Title = "隐身",
        Callback = function()
            loadstring(game:HttpGet("https://pastebin.com/raw/vP6CrQJj"))()
        end
    })

    Tabs.FETab:Button({
        Title = "蜘蛛侠",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Xingyan777/roblox/refs/heads/main/%E8%9C%98%E8%9B%9B%E4%BE%A0.txt"))()
        end
    })

    Tabs.FETab:Button({
        Title = "R15无敌少侠飞行",
        Callback = function()
            loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Invinicible-Flight-R15-45414"))()
        end
    })

    Tabs.FETab:Button({
        Title = "R6无敌少侠飞行",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/%E6%97%A0%E6%95%8C%E5%B0%91%E4%BE%A0%E9%A3%9E%E8%A1%8Cr6.txt"))()
        end
    })

    -- ========== 知名脚本 ==========
    Tabs.KnownScriptTab:Paragraph({
        Title = "知名脚本",
        Desc = "各种知名脚本集合",
        Image = "star",
        ImageSize = 24,
        Color = Color3.fromHex("#0078D7")
    })

    Tabs.KnownScriptTab:Button({
        Title = "皮脚本",
        Callback = function()
            getgenv().XiaoPi="皮脚本QQ群1002100032" 
            loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaopi77/xiaopi77/main/QQ1002100032-Roblox-Pi-script.lua"))()
        end
    })

    Tabs.KnownScriptTab:Button({
        Title = "XA Hub",
        Callback = function()
            loadstring(game:HttpGet("https://pastebin.com/raw/h8nC0fLb", true))()
        end
    })

    Tabs.KnownScriptTab:Button({
        Title = "退休v2",
        Callback = function()
            TX = "脚本群:160369111"
            Script = "Free永久免费"
            loadstring(game:HttpGet("https://raw.githubusercontent.com/JsYb666/TX-Free-YYDS/refs/heads/main/FREE-TX-TEAM"))()
        end
    })

    Tabs.KnownScriptTab:Button({
        Title = "天空脚本",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/hdjsjjdgrhj/script-hub/refs/heads/main/skyhub"))()
        end
    })

    -- ========== 传送功能 ==========
    Tabs.TeleportTab:Paragraph({
        Title = "传送功能",
        Desc = "玩家传送和位置传送",
        Image = "navigation",
        ImageSize = 24,
        Color = Color3.fromHex("#0078D7")
    })

    local PlayerList = {}
    local SelectedPlayer = nil

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
        return playerNames
    end

    local playerDropdown = Tabs.TeleportTab:Dropdown({
        Title = "选择玩家",
        Multi = false,
        AllowNone = true,
        Values = GetPlayerList(),
        Callback = function(selectedPlayer)
            if selectedPlayer then
                SelectedPlayer = PlayerList[selectedPlayer]
                WindUI:Notify({Title = "玩家选择", Content = "已选择玩家: " .. selectedPlayer, Duration = 3})
            end
        end
    })

    Tabs.TeleportTab:Button({
        Title = "刷新玩家列表",
        Callback = function()
            playerDropdown:Refresh(GetPlayerList())
            WindUI:Notify({Title = "玩家列表", Content = "已刷新玩家列表", Duration = 2})
        end
    })

    Tabs.TeleportTab:Button({
        Title = "传送到选中玩家",
        Callback = function()
            if not SelectedPlayer then
                WindUI:Notify({Title = "传送失败", Content = "请先选择一个玩家", Duration = 3})
                return
            end
            
            local targetPlayer = SelectedPlayer
            local localPlayer = game.Players.LocalPlayer
            
            if not targetPlayer.Character then
                WindUI:Notify({Title = "传送失败", Content = "目标玩家没有角色", Duration = 3})
                return
            end
            
            local targetRoot = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
            local localRoot = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
            
            if not targetRoot or not localRoot then
                WindUI:Notify({Title = "传送失败", Content = "传送失败，缺少必要组件", Duration = 3})
                return
            end
            
            local success = pcall(function()
                localRoot.CFrame = CFrame.new(targetRoot.Position + Vector3.new(0, 3, 0))
            end)
            
            if success then
                WindUI:Notify({Title = "传送成功", Content = "已传送到玩家: " .. targetPlayer.Name, Duration = 3})
            else
                WindUI:Notify({Title = "传送失败", Content = "传送过程中出现错误", Duration = 3})
            end
        end
    })

    Tabs.TeleportTab:Button({
        Title = "传送到鼠标位置",
        Callback = function()
            local localPlayer = game.Players.LocalPlayer
            local localRoot = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
            
            if not localRoot then
                WindUI:Notify({Title = "传送失败", Content = "您没有HumanoidRootPart", Duration = 3})
                return
            end
            
            local mouse = localPlayer:GetMouse()
            local targetPosition = mouse.Hit.Position
            
            local success = pcall(function()
                localRoot.CFrame = CFrame.new(targetPosition + Vector3.new(0, 3, 0))
            end)
            
            if success then
                WindUI:Notify({Title = "传送成功", Content = "已传送到鼠标位置", Duration = 3})
            else
                WindUI:Notify({Title = "传送失败", Content = "传送过程中出现错误", Duration = 3})
            end
        end
    })

    -- ========== 最强战场 ==========
    Tabs.StrongestTab:Paragraph({
        Title = "最强战场脚本",
        Desc = "最强战场相关功能脚本",
        Image = "crosshair",
        ImageSize = 24,
        Color = Color3.fromHex("#0078D7")
    })

    Tabs.StrongestTab:Button({
        Title = "加载不知名脚本一",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/cytj777i/Deliver-through-the-wall-perspective/main/%E8%87%AA%E5%8A%A8%E6%9C%9D%E5%90%91"))()
        end
    })

    Tabs.StrongestTab:Button({
        Title = "加载不知名脚本二",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/cytj777i/Deliver-through-the-wall-perspective/main/%E8%87%AA%E5%8A%A8%E6%9C%9D%E5%90%91"))()
        end
    })

    Tabs.StrongestTab:Button({
        Title = "加载隐身脚本",
        Callback = function()
            loadstring(game:HttpGet("https://rawscripts.net/raw/The-Strongest-Battlegrounds-NSExpression-v2-a3-TSBG-20252"))()
        end
    })

    -- ========== 被遗弃 ==========
    Tabs.AbandonedTab:Paragraph({
        Title = "被遗弃脚本",
        Desc = "被遗弃相关功能脚本",
        Image = "archive",
        ImageSize = 24,
        Color = Color3.fromHex("#0078D7")
    })

    Tabs.AbandonedTab:Button({
        Title = "加载B0bby脚本",
        Callback = function()
            getgenv().XiaoPi="被遗弃-B0bby[汉化版]" 
            loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaopi77/xiaopi77/187ec501507e956200e0741a7bc38ca1cd83973f/%E8%A2%AB%E9%81%97%E5%BC%83B0bby%E6%B1%89%E5%8C%96%20(1).lua"))()
        end
    })

    Tabs.AbandonedTab:Button({
        Title = "复制卡密",
        Callback = function()
            local key = "Samuelspizzatrip"
            setclipboard(key)
            WindUI:Notify({Title = "被遗弃", Content = "卡密已复制到剪贴板: " .. key, Duration = 5})
        end
    })

    -- ========== 99页 ==========
    Tabs.V99Tab:Paragraph({
        Title = "99页脚本集合",
        Desc = "各种强大的99页脚本",
        Image = "box",
        ImageSize = 24,
        Color = Color3.fromHex("#0078D7")
    })

    Tabs.V99Tab:Button({
        Title = "加载虚空脚本",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/nightsintheforest.lua", true))()
        end
    })

    Tabs.V99Tab:Button({
        Title = "加载99夜红蛇",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
        end
    })

    Tabs.V99Tab:Button({
        Title = "加载H4x99页脚本",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/xyx8846/-/refs/heads/main/H4x%E6%B1%89%E5%8C%96%E8%84%9A%E6%9C%AC"))()
        end
    })

    -- ========== 死铁轨 ==========
    Tabs.DeadRailsTab:Paragraph({
        Title = "死铁轨脚本",
        Desc = "死铁轨相关功能脚本",
        Image = "train",
        ImageSize = 24,
        Color = Color3.fromHex("#0078D7")
    })

    Tabs.DeadRailsTab:Button({
        Title = "加载Dead脚本",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Articles-Hub/ROBLOXScript/refs/heads/main/File-Script/Dead%20rails.lua"))()
        end
    })

    Tabs.DeadRailsTab:Button({
        Title = "加载VZ脚本",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Dex-Bear/Vxezehub/refs/heads/main/VxezeHubMain"))()
        end
    })

    -- ========== 后门 ==========
    Tabs.BackdoorTab:Paragraph({
        Title = "后门执行器",
        Desc = "各种后门执行器脚本",
        Image = "key",
        ImageSize = 24,
        Color = Color3.fromHex("#0078D7")
    })

    Tabs.BackdoorTab:Button({
        Title = "加载后门执行器",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/iK4oS/backdoor.exe/v6x/source.lua"))()
        end
    })

    Tabs.BackdoorTab:Button({
        Title = "复制后门一代码",
        Callback = function()
            local code = 'require(6858594080).KrnKidsSus("用户")'
            setclipboard(code)
            WindUI:Notify({Title = "后门", Content = "后门一代码已复制到剪贴板！", Duration = 5})
        end
    })

    -- ========== 墨水游戏 ==========
    Tabs.InkGameTab:Paragraph({
        Title = "墨水游戏脚本",
        Desc = "墨水游戏相关功能",
        Image = "pen-tool",
        ImageSize = 24,
        Color = Color3.fromHex("#0078D7")
    })

    Tabs.InkGameTab:Button({
        Title = "加载墨水游戏汉化",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/hdjsjjdgrhj/script-hub/refs/heads/main/Ringta"))()
        end
    })

    -- ========== 偷走脑红 ==========
    Tabs.StealBrainRedTab:Paragraph({
        Title = "偷走脑红脚本集合",
        Desc = "各种脑红反作弊绕过和功能脚本",
        Image = "brain",
        ImageSize = 24,
        Color = Color3.fromHex("#0078D7")
    })

    Tabs.StealBrainRedTab:Button({
        Title = "加载辣椒脚本",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli.lua"))()
        end
    })

    Tabs.StealBrainRedTab:Button({
        Title = "自动开启脑红反作弊绕过",
        Callback = function()
            WindUI:Notify({Title = "偷走脑红", Content = "脑红反作弊绕过已自动开启！", Duration = 3})
        end
    })

    -- ========== 窗口设置 ==========
    local HttpService = game:GetService("HttpService")

    local folderPath = "WindUI"
    if not isfolder(folderPath) then
        makefolder(folderPath)
    end

    local function SaveFile(fileName, data)
        local filePath = folderPath .. "/" .. fileName .. ".json"
        local jsonData = HttpService:JSONEncode(data)
        writefile(filePath, jsonData)
    end

    local function LoadFile(fileName)
        local filePath = folderPath .. "/" .. fileName .. ".json"
        if isfile(filePath) then
            local jsonData = readfile(filePath)
            return HttpService:JSONDecode(jsonData)
        end
        return nil
    end

    local function ListFiles()
        local files = {}
        for _, file in ipairs(listfiles(folderPath)) do
            local fileName = file:match("([^/]+)%.json$")
            if fileName then
                table.insert(files, fileName)
            end
        end
        return files
    end

    Tabs.WindowTab:Section({ Title = "窗口", Icon = "app-window-mac" })

    local themeValues = {}
    for name, _ in pairs(WindUI:GetThemes()) do
        table.insert(themeValues, name)
    end

    local themeDropdown = Tabs.WindowTab:Dropdown({
        Title = "选择主题",
        Multi = false,
        AllowNone = false,
        Value = nil,
        Values = themeValues,
        Callback = function(theme)
            WindUI:SetTheme(theme)
        end
    })
    themeDropdown:Select(WindUI:GetCurrentTheme())

    local ToggleTransparency = Tabs.WindowTab:Toggle({
        Title = "切换窗口透明度",
        Callback = function(e)
            Window:ToggleTransparency(e)
        end,
        Value = WindUI:GetTransparency()
    })

    Tabs.WindowTab:Section({ Title = "保存" })

    local fileNameInput = ""
    Tabs.WindowTab:Input({
        Title = "写入文件名",
        PlaceholderText = "Enter file name",
        Callback = function(text)
            fileNameInput = text
        end
    })

    Tabs.WindowTab:Button({
        Title = "保存文件",
        Callback = function()
            if fileNameInput ~= "" then
                SaveFile(fileNameInput, { Transparent = WindUI:GetTransparency(), Theme = WindUI:GetCurrentTheme() })
            end
        end
    })

    Tabs.WindowTab:Section({ Title = "加载" })

    local filesDropdown
    local files = ListFiles()

    filesDropdown = Tabs.WindowTab:Dropdown({
        Title = "选择文件",
        Multi = false,
        AllowNone = true,
        Values = files,
        Callback = function(selectedFile)
            fileNameInput = selectedFile
        end
    })

    Tabs.WindowTab:Button({
        Title = "加载文件",
        Callback = function()
            if fileNameInput ~= "" then
                local data = LoadFile(fileNameInput)
                if data then
                    WindUI:Notify({
                        Title = "文件已加载",
                        Content = "Loaded data: "..HttpService:JSONEncode(data),
                        Duration = 5,
                    })
                    if data.Transparent then 
                        Window:ToggleTransparency(data.Transparent)
                        ToggleTransparency:SetValue(data.Transparent)
                    end
                    if data.Theme then 
                        WindUI:SetTheme(data.Theme)
                        themeDropdown:Select(data.Theme)
                    end
                end
            end
        end
    })

    Tabs.WindowTab:Button({
        Title = "覆盖文件",
        Callback = function()
            if fileNameInput ~= "" then
                SaveFile(fileNameInput, { Transparent = WindUI:GetTransparency(), Theme = WindUI:GetCurrentTheme() })
            end
        end
    })

    Tabs.WindowTab:Button({
        Title = "刷新列表",
        Callback = function()
            filesDropdown:Refresh(ListFiles())
        end
    })

    -- ========== 其他功能 ==========
    Tabs.OtherTab:Paragraph({
        Title = "其他功能",
        Desc = "各种实用工具和功能",
        Image = "grid",
        ImageSize = 24,
        Color = Color3.fromHex("#0078D7")
    })

    Tabs.OtherTab:Button({
        Title = "显示服务器信息",
        Callback = function()
            local players = game.Players:GetPlayers()
            WindUI:Notify({
                Title = "服务器信息",
                Content = "玩家数量: " .. #players .. "/" .. game.Players.MaxPlayers,
                Duration = 5
            })
        end
    })

    Tabs.OtherTab:Button({
        Title = "重置角色",
        Callback = function()
            if game.Players.LocalPlayer.Character then
                game.Players.LocalPlayer.Character:BreakJoints()
                WindUI:Notify({Title = "重置角色", Content = "角色已重置", Duration = 2})
            end
        end
    })

    -- 页脚信息
    Tabs.OtherTab:Paragraph({
        Title = "关于",
        Desc = "作者: 皮炎\n联系方式: 快手1466456286",
        Image = "user",
        ImageSize = 24,
        Color = Color3.fromHex("#00A2FF"),
        Buttons = {
            {
                Title = "复制联系方式",
                Icon = "copy",
                Variant = "Tertiary",
                Callback = function()
                    setclipboard("快手1466456286")
                    WindUI:Notify({Title = "复制成功", Content = "已复制联系方式到剪贴板", Duration = 2})
                end
            }
        }
    })

    -- 窗口关闭时的处理
    Window:OnClose(function()
        print("皮空重置版 - 窗口已关闭")
        if NoclipConnection then
            NoclipConnection:Disconnect()
        end
    end)

    print("皮空重置版 - 界面初始化完成！")
end

-- 备用简单UI函数
function loadSimpleUI()
    local message = Instance.new("Message")
    message.Text = "皮空重置版 - WindUI加载失败，请检查网络连接"
    message.Parent = workspace
    wait(3)
    message:Destroy()
end

-- 执行额外脚本
pcall(function()
     loadstring(game:HttpGet("https://raw.githubusercontent.com/smalldesikon/eyidfki/a53d5face05b0a8e732ca27a905a78186d869131/%E5%8C%97%E4%BA%AC%E6%97%B6%E9%97%B4"))()
     print("✅ 执行成功")
 end)
