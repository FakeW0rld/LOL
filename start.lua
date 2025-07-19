local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- Create blur and tween it in
local blur = Instance.new("BlurEffect")
blur.Parent = Lighting
blur.Size = 0

local blurIn = TweenService:Create(blur, TweenInfo.new(0.5), {Size = 24})
blurIn:Play()
blurIn.Completed:Wait()

-- Create GUI
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "FrostbyteLoader"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true

local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(1, 0, 1, 0)
frame.BackgroundTransparency = 1

local bg = Instance.new("Frame", frame)
bg.Size = UDim2.new(1, 0, 1, 0)
bg.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
bg.BackgroundTransparency = 1
bg.ZIndex = 0

TweenService:Create(bg, TweenInfo.new(0.5), {BackgroundTransparency = 0.3}):Play()

-- 使用图像标签代替文本
local imageLabel = Instance.new("ImageLabel")
imageLabel.Image = "rbxassetid://114295767049054"
imageLabel.Size = UDim2.new(0, 500, 0, 200) -- 调整图像大小
imageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
imageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
imageLabel.BackgroundTransparency = 1
imageLabel.ScaleType = Enum.ScaleType.Fit -- 适应方式
imageLabel.Parent = frame

-- 图像透明度和大小动画
local imageTweenIn = TweenService:Create(imageLabel, TweenInfo.new(0.3), {
    ImageTransparency = 0,
    Size = UDim2.new(0, 600, 0, 240) -- 动画结束时的大小
})
imageLabel.ImageTransparency = 1 -- 初始透明
imageTweenIn:Play()

-- Function to tween out and cleanup
local function tweenOutAndDestroy()
    -- 动画图像淡出
    local imageTweenOut = TweenService:Create(imageLabel, TweenInfo.new(0.3), {
        ImageTransparency = 1,
        Size = UDim2.new(0, 500, 0, 200) -- 淡出时缩小
    })
    imageTweenOut:Play()
    
    TweenService:Create(bg, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()

    local blurOut = TweenService:Create(blur, TweenInfo.new(0.5), {Size = 0})
    blurOut:Play()
    blurOut.Completed:Wait()

    screenGui:Destroy()
    blur:Destroy()
end

-- Hold then cleanup
wait(3) -- 延长显示时间以便看到图像
tweenOutAndDestroy()

-- Ensure game is loaded before continuing
repeat task.wait() until player and player.Character
if not game:IsLoaded() then
    game.Loaded:Wait()
end
