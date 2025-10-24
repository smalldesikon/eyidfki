-- 使用一个更稳定的 UI 库
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- 创建窗口
local Window = Rayfield:CreateWindow({
   Name = "司空我昌龄吗还不更新我直能做重制版了",
   LoadingTitle = "皮空重制版",
   LoadingSubtitle = "正在加载...",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "皮空脚本",
      FileName = "配置"
   },
   Discord = {
      Enabled = false,
      Invite = "noinvitelink",
      RememberJoins = true
   },
   KeySystem = true,
   KeySettings = {
      Title = "皮空验证系统",
      Subtitle = "请输入卡密",
      Note = "加Q:1046855905 获取卡密",
      FileName = "皮空密钥",
      SaveKey = true,
      GrabKeyFromSite = false,
      Key = {"皮空脚本垃圾", "皮炎是司空的爸爸"}
   }
})

-- 等待验证通过
Rayfield:LoadConfiguration()

-- 创建标签页
local MainTab = Window:CreateTab("主界面", 4483362458)
local CoreTab = Window:CreateTab("核心功能", 4483362458)
local TranslateTab = Window:CreateTab("极速汉化", 4483362458)
local V99Tab = Window:CreateTab("99页", 4483362458)
local InkGameTab = Window:CreateTab("墨水游戏", 4483362458)
local OtherTab = Window:CreateTab("其他功能", 4483362458)

-- ========== 主界面内容 ==========
local MainSection = MainTab:CreateSection("皮空重制版")
MainTab:CreateLabel("欢迎使用皮空重制版脚本！")
MainTab:CreateLabel("所有功能已解锁，请尽情使用！")
MainTab:CreateLabel("作者: 皮炎，司空")
MainTab:CreateLabel("联系方式: 快手1466456286")

local InfoSection = MainTab:CreateSection("系统信息")

if identifyexecutor then
    MainTab:CreateLabel("你的注入器: " .. identifyexecutor())
else
    MainTab:CreateLabel("你的注入器: 未知")
end

local FPSLabel = MainTab:CreateLabel("帧率: 计算中...")

local player = game.Players.LocalPlayer
MainTab:CreateLabel("用户名: " .. player.Name)
MainTab:CreateLabel("显示名: " .. player.DisplayName)
MainTab:CreateLabel("用户ID: " .. player.UserId)
MainTab:CreateLabel("账号年龄: " .. player.AccountAge .. " 天")

spawn(function()
    local RunService = game:GetService("RunService")
    local counter = 0
    local lastTime = tick()
    
    while true do
        counter = counter + 1
        if tick() - lastTime >= 1 then
            FPSLabel:SetText("帧率: " .. counter .. " FPS")
            counter = 0
            lastTime = tick()
        end
        RunService.RenderStepped:Wait()
    end
end)

-- ========== 核心功能 ==========
local CoreSection = CoreTab:CreateSection("核心功能")

local NoclipConnection
CoreTab:CreateToggle({
   Name = "穿墙模式",
   CurrentValue = false,
   Flag = "NoclipToggle",
   Callback = function(Value)
      if Value then
         NoclipConnection = game:GetService("RunService").Stepped:Connect(function()
            if game.Players.LocalPlayer.Character then
               for _, part in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                  if part:IsA("BasePart") and part.CanCollide then
                     part.CanCollide = false
                  end
               end
            end
         end)
      else
         if NoclipConnection then
            NoclipConnection:Disconnect()
            NoclipConnection = nil
         end
      end
   end,
})

local InfiniteJumpConnection
CoreTab:CreateToggle({
   Name = "无限跳跃",
   CurrentValue = false,
   Flag = "InfiniteJumpToggle",
   Callback = function(Value)
      if Value then
         InfiniteJumpConnection = game:GetService("UserInputService").JumpRequest:Connect(function()
            if game.Players.LocalPlayer.Character then
               game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
            end
         end)
      else
         if InfiniteJumpConnection then
            InfiniteJumpConnection:Disconnect()
            InfiniteJumpConnection = nil
         end
      end
   end,
})

CoreTab:CreateButton({
   Name = "飞行模式",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))()
   end,
})

local AimlockEnabled = false
CoreTab:CreateToggle({
   Name = "自瞄锁定",
   CurrentValue = false,
   Flag = "AimlockToggle",
   Callback = function(Value)
      AimlockEnabled = Value
      if Value then
         spawn(function()
            while AimlockEnabled do
               task.wait()
               pcall(function()
                  local closestPlayer = getClosestPlayer()
                  if closestPlayer and closestPlayer.Character and closestPlayer.Character:FindFirstChild("HumanoidRootPart") then
                     game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(
                        game.Players.LocalPlayer.Character.HumanoidRootPart.Position,
                        Vector3.new(
                           closestPlayer.Character.HumanoidRootPart.Position.X,
                           game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Y,
                           closestPlayer.Character.HumanoidRootPart.Position.Z
                        )
                     )
                  end
               end)
            end
         end)
      end
   end,
})

local WalkOnAirEnabled = false
CoreTab:CreateToggle({
   Name = "踏空行走",
   CurrentValue = false,
   Flag = "WalkOnAirToggle",
   Callback = function(Value)
      WalkOnAirEnabled = Value
      if Value then
         local platform = Instance.new("Part")
         platform.Name = "AirPlatform"
         platform.Anchored = true
         platform.CanCollide = true
         platform.Size = Vector3.new(10, 1, 10)
         platform.Transparency = 0.7
         platform.BrickColor = BrickColor.new("Bright blue")
         platform.Parent = workspace
         
         spawn(function()
            while WalkOnAirEnabled do
               task.wait()
               pcall(function()
                  local character = game.Players.LocalPlayer.Character
                  if character and character:FindFirstChild("HumanoidRootPart") then
                     local pos = character.HumanoidRootPart.Position
                     platform.Position = Vector3.new(pos.X, pos.Y - 4, pos.Z)
                  end
               end)
            end
            platform:Destroy()
         end)
      else
         local platform = workspace:FindFirstChild("AirPlatform")
         if platform then
            platform:Destroy()
         end
      end
   end,
})

local ESPEnabled = false
local PlayersAdded
CoreTab:CreateToggle({
   Name = "绘制天线",
   CurrentValue = false,
   Flag = "ESPToggle",
   Callback = function(Value)
      ESPEnabled = Value
      if Value then
         for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer then
               createESP(player)
            end
         end
         
         PlayersAdded = game.Players.PlayerAdded:Connect(function(player)
            if ESPEnabled then
               createESP(player)
            end
         end)
      else
         for _, player in pairs(game.Players:GetPlayers()) do
            removeESP(player)
         end
         
         if PlayersAdded then
            PlayersAdded:Disconnect()
            PlayersAdded = nil
         end
      end
   end,
})

local SpeedValue = 16
CoreTab:CreateSlider({
   Name = "移动速度",
   Range = {16, 100},
   Increment = 1,
   Suffix = "速度",
   CurrentValue = 16,
   Flag = "SpeedSlider",
   Callback = function(Value)
      SpeedValue = Value
      if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
         game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
      end
   end,
})

local JumpValue = 50
CoreTab:CreateSlider({
   Name = "跳跃高度",
   Range = {50, 200},
   Increment = 1,
   Suffix = "高度",
   CurrentValue = 50,
   Flag = "JumpSlider",
   Callback = function(Value)
      JumpValue = Value
      if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
         game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
      end
   end,
})

-- ========== 极速汉化标签页 ==========
local TranslateSection = TranslateTab:CreateSection("极速汉化设置")

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
        Rayfield:Notify({
            Title = "极速汉化",
            Content = "已翻译 " .. translatedCount .. " 个文本",
            Duration = 3,
            Image = 4483362458,
        })
    end
end

local TranslateToggle = TranslateTab:CreateToggle({
    Name = "启用极速汉化",
    CurrentValue = false,
    Flag = "TranslateToggle",
    Callback = function(Value)
        TranslateEngine.isRunning = Value
        if Value then
            Rayfield:Notify({
                Title = "极速汉化",
                Content = "汉化功能已启用，开始扫描界面...",
                Duration = 3,
                Image = 4483362458,
            })
            spawn(function()
                while TranslateEngine.isRunning do
                    scanAndTranslate()
                    wait(5)
                end
            end)
        else
            Rayfield:Notify({
                Title = "极速汉化",
                Content = "汉化功能已关闭",
                Duration = 3,
                Image = 4483362458,
            })
        end
    end,
})

TranslateTab:CreateButton({
    Name = "立即翻译界面",
    Callback = function()
        if TranslateEngine.isRunning then
            scanAndTranslate()
        else
            Rayfield:Notify({
                Title = "极速汉化",
                Content = "请先启用极速汉化",
                Duration = 3,
                Image = 4483362458,
            })
        end
    end,
})

TranslateTab:CreateButton({
    Name = "清空翻译缓存",
    Callback = function()
        TranslateEngine.cache = {}
        Rayfield:Notify({
            Title = "极速汉化",
            Content = "翻译缓存已清空",
            Duration = 3,
            Image = 4483362458,
        })
    end,
})

local TranslateSpeed = 5
TranslateTab:CreateSlider({
    Name = "翻译扫描间隔",
    Range = {1, 30},
    Increment = 1,
    Suffix = "秒",
    CurrentValue = 5,
    Flag = "TranslateSpeed",
    Callback = function(Value)
        TranslateSpeed = Value
    end,
})

local StatusSection = TranslateTab:CreateSection("状态信息")
local StatusLabel = TranslateTab:CreateLabel("状态: 未运行")
local CacheLabel = TranslateTab:CreateLabel("缓存文本: 0")

spawn(function()
    while true do
        wait(1)
        StatusLabel:SetText("状态: " .. (TranslateEngine.isRunning and "运行中" or "已停止"))
        CacheLabel:SetText("缓存文本: " .. (table.getn(TranslateEngine.cache) or 0))
    end
end)

-- ========== 99页标签页 ==========
local V99Section = V99Tab:CreateSection("虚空脚本")

V99Tab:CreateButton({
    Name = "加载虚空脚本",
    Callback = function()
        Rayfield:Notify({
            Title = "99页",
            Content = "正在加载虚空脚本...",
            Duration = 3,
            Image = 4483362458,
        })
        
        local success, err = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/nightsintheforest.lua", true))()
        end)
        
        if success then
            Rayfield:Notify({
                Title = "99页",
                Content = "虚空脚本加载成功！",
                Duration = 3,
                Image = 4483362458,
            })
        else
            Rayfield:Notify({
                Title = "99页",
                Content = "虚空脚本加载失败: " .. tostring(err),
                Duration = 5,
                Image = 4483362458,
            })
        end
    end,
})

V99Tab:CreateLabel("这个脚本挺强的")

-- ========== 墨水游戏标签页 ==========
local InkGameSection = InkGameTab:CreateSection("墨水游戏脚本")

InkGameTab:CreateButton({
    Name = "加载墨水游戏汉化",
    Callback = function()
        Rayfield:Notify({
            Title = "墨水游戏",
            Content = "正在加载墨水游戏汉化脚本...",
            Duration = 3,
            Image = 4483362458,
        })
        
        local success, err = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/hdjsjjdgrhj/script-hub/refs/heads/main/Ringta"))()
        end)
        
        if success then
            Rayfield:Notify({
                Title = "墨水游戏",
                Content = "墨水游戏汉化脚本加载成功！",
                Duration = 3,
                Image = 4483362458,
            })
        else
            Rayfield:Notify({
                Title = "墨水游戏",
                Content = "墨水游戏汉化脚本加载失败: " .. tostring(err),
                Duration = 5,
                Image = 4483362458,
            })
        end
    end,
})

InkGameTab:CreateLabel("这个有防作弊")

-- ========== 其他功能 ==========
local OtherSection = OtherTab:CreateSection("其他功能")

OtherTab:CreateButton({
    Name = "显示服务器信息",
    Callback = function()
        local players = game.Players:GetPlayers()
        Rayfield:Notify({
            Title = "服务器信息",
            Content = "玩家数量: " .. #players .. "/" .. game.Players.MaxPlayers .. "\n服务器位置: " .. game.JobId,
            Duration = 6,
            Image = 4483362458,
        })
    end,
})

OtherTab:CreateButton({
    Name = "显示玩家列表",
    Callback = function()
        local playerNames = ""
        for i, player in pairs(game.Players:GetPlayers()) do
            playerNames = playerNames .. player.Name .. " (ID: " .. player.UserId .. ")\n"
        end
        
        Rayfield:Notify({
            Title = "在线玩家 (" .. #game.Players:GetPlayers() .. ")",
            Content = playerNames,
            Duration = 10,
            Image = 4483362458,
        })
    end,
})

OtherTab:CreateButton({
    Name = "重置角色",
    Callback = function()
        if game.Players.LocalPlayer.Character then
            game.Players.LocalPlayer.Character:BreakJoints()
        end
    end,
})

OtherTab:CreateButton({
    Name = "显示详细用户信息",
    Callback = function()
        local player = game.Players.LocalPlayer
        local info = "用户名: " .. player.Name ..
                    "\n显示名: " .. player.DisplayName ..
                    "\n用户ID: " .. player.UserId ..
                    "\n账号年龄: " .. player.AccountAge .. " 天" ..
                    "\n会员状态: " .. (player.MembershipType == Enum.MembershipType.Premium and "高级会员" or "普通会员")
        
        Rayfield:Notify({
            Title = "用户信息",
            Content = info,
            Duration = 8,
            Image = 4483362458,
        })
    end,
})

OtherTab:CreateButton({
    Name = "显示注入器信息",
    Callback = function()
        local injectorName = "未知"
        if identifyexecutor then
            injectorName = identifyexecutor()
        end
        
        Rayfield:Notify({
            Title = "注入器信息",
            Content = "注入器: " .. injectorName .. "\n作者: 皮炎\n联系方式: 快手1466456286\n状态: 运行中",
            Duration = 8,
            Image = 4483362458,
        })
    end,
})

local FPSDisplayEnabled = false
local FPSDisplayConnection
OtherTab:CreateToggle({
    Name = "显示实时帧率",
    CurrentValue = false,
    Flag = "FPSDisplayToggle",
    Callback = function(Value)
        FPSDisplayEnabled = Value
        if Value then
            local ScreenGui = Instance.new("ScreenGui")
            ScreenGui.Name = "FPSDisplay"
            ScreenGui.Parent = game.CoreGui
            
            local Frame = Instance.new("Frame")
            Frame.Size = UDim2.new(0, 120, 0, 40)
            Frame.Position = UDim2.new(0, 10, 0, 10)
            Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            Frame.BackgroundTransparency = 0.3
            Frame.BorderSizePixel = 0
            Frame.Parent = ScreenGui
            
            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0, 8)
            Corner.Parent = Frame
            
            local FPSLabel = Instance.new("TextLabel")
            FPSLabel.Size = UDim2.new(1, 0, 1, 0)
            FPSLabel.BackgroundTransparency = 1
            FPSLabel.Text = "FPS: 0"
            FPSLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            FPSLabel.TextSize = 16
            FPSLabel.Font = Enum.Font.GothamBold
            FPSLabel.Parent = Frame
            
            local fpsCounter = 0
            local fpsLastTime = tick()
            
            FPSDisplayConnection = game:GetService("RunService").RenderStepped:Connect(function()
                fpsCounter = fpsCounter + 1
                if tick() - fpsLastTime >= 1 then
                    FPSLabel.Text = "FPS: " .. fpsCounter
                    fpsCounter = 0
                    fpsLastTime = tick()
                end
            end)
        else
            if FPSDisplayConnection then
                FPSDisplayConnection:Disconnect()
                FPSDisplayConnection = nil
            end
            local FPSDisplay = game.CoreGui:FindFirstChild("FPSDisplay")
            if FPSDisplay then
                FPSDisplay:Destroy()
            end
        end
    end,
})

-- ========== FE功能 ==========
local FESection = OtherTab:CreateSection("FE功能")

OtherTab:CreateButton({
    Name = "R15无敌少侠飞行",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Invinicible-Flight-R15-45414"))()
    end,
})

OtherTab:CreateButton({
    Name = "R6无敌少侠飞行",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/%E6%97%A0%E6%95%8C%E5%B0%91%E4%BE%A0%E9%A3%9E%E8%A1%8Cr6.txt"))()
    end,
})

OtherTab:CreateButton({
    Name = "R15鹿菅",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/YZoglOyJ/raw"))()
    end,
})

OtherTab:CreateButton({
    Name = "R6鹿菅",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/wa3v2Vgm/raw"))()
    end,
})

OtherTab:CreateButton({
    Name = "蛇动作",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/randomstring0/qwertys/refs/heads/main/qwerty5.lua"))()
    end,
})

OtherTab:CreateButton({
    Name = "防摔落",
    Callback = function()
        loadstring(game:HttpGet("http://rawscripts.net/raw/Universal-Script-Touch-fling-script-22447"))()
    end,
})

OtherTab:CreateButton({
    Name = "R6动作脚本",
    Callback = function()
        Rayfield:Notify({
            Title = "FE功能",
            Content = "正在加载R6动作脚本...",
            Duration = 3,
            Image = 4483362458,
        })
        
        local success, err = pcall(function()
            loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-R6-Animations-Menu-By-Me-19427"))()
        end)
        
        if success then
            Rayfield:Notify({
                Title = "FE功能",
                Content = "R6动作脚本加载成功！",
                Duration = 3,
                Image = 4483362458,
            })
        else
            Rayfield:Notify({
                Title = "FE功能",
                Content = "R6动作脚本加载失败: " .. tostring(err),
                Duration = 5,
                Image = 4483362458,
            })
        end
    end,
})

-- 辅助函数
function getClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = math.huge
    
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
            if distance < shortestDistance then
                shortestDistance = distance
                closestPlayer = player
            end
        end
    end
    
    return closestPlayer
end

function createESP(player)
    if player.Character then
        local highlight = Instance.new("Highlight")
        highlight.Name = "皮空ESP"
        highlight.Adornee = player.Character
        highlight.Parent = player.Character
        highlight.FillColor = Color3.fromRGB(255, 0, 0)
        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
        highlight.FillTransparency = 0.5
        highlight.OutlineTransparency = 0
        
        local billboard = Instance.new("BillboardGui")
        billboard.Name = "皮空NameTag"
        billboard.Adornee = player.Character.Head
        billboard.Size = UDim2.new(0, 200, 0, 50)
        billboard.StudsOffset = Vector3.new(0, 3, 0)
        billboard.AlwaysOnTop = true
        billboard.Parent = player.Character.Head
        
        local nameLabel = Instance.new("TextLabel")
        nameLabel.Size = UDim2.new(1, 0, 1, 0)
        nameLabel.BackgroundTransparency = 1
        nameLabel.Text = player.Name
        nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        nameLabel.TextSize = 14
        nameLabel.Font = Enum.Font.GothamBold
        nameLabel.Parent = billboard
        
        local distanceBillboard = Instance.new("BillboardGui")
        distanceBillboard.Name = "皮空Distance"
        distanceBillboard.Adornee = player.Character.Head
        distanceBillboard.Size = UDim2.new(0, 200, 0, 30)
        distanceBillboard.StudsOffset = Vector3.new(0, 1.5, 0)
        distanceBillboard.AlwaysOnTop = true
        distanceBillboard.Parent = player.Character.Head
        
        local distanceLabel = Instance.new("TextLabel")
        distanceLabel.Size = UDim2.new(1, 0, 1, 0)
        distanceLabel.BackgroundTransparency = 1
        distanceLabel.TextColor3 = Color3.fromRGB(0, 255, 255)
        distanceLabel.TextSize = 12
        distanceLabel.Font = Enum.Font.Gotham
        distanceLabel.Parent = distanceBillboard
        
        spawn(function()
            while player.Character and player.Character:FindFirstChild("Head") do
                task.wait(0.1)
                pcall(function()
                    local distance = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
                    distanceLabel.Text = "距离: " .. math.floor(distance) .. " 米"
                end)
            end
        end)
    end
end

function removeESP(player)
    if player.Character then
        local highlight = player.Character:FindFirstChild("皮空ESP")
        if highlight then
            highlight:Destroy()
        end
        
        local nameTag = player.Character:FindFirstChild("Head"):FindFirstChild("皮空NameTag")
        if nameTag then
            nameTag:Destroy()
        end
        
        local distanceTag = player.Character:FindFirstChild("Head"):FindFirstChild("皮空Distance")
        if distanceTag then
            distanceTag:Destroy()
        end
    end
end

print("皮空重制版 - 界面初始化完成！")