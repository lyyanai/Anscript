print("脚本开源，缝合死全家🤣")
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/lyyanai/Anscript/main/WindUI"))()

print("反挂机已开启")
Start = tick()
		local vu = game:GetService("VirtualUser")
		game:GetService("Players").LocalPlayer.Idled:connect(function()
		   vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
		   wait(1)
		   vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
		end)

--保存文件
local HttpService = game:GetService("HttpService")

local folderPath = "WindUI"
makefolder(folderPath)

local function SaveFile(fileName, data)
    local filePath = folderPath .. "/" .. fileName .. ".lua"
    local jsonData = HttpService:JSONEncode(data)
    writefile(filePath, jsonData)
end

local function LoadFile(fileName)
    local filePath = folderPath .. "/" .. fileName .. ".lua"
    if isfile(filePath) then
        local jsonData = readfile(filePath)
        return HttpService:JSONDecode(jsonData)
    end
end

local function ListFiles()
    local files = {}
    for _, file in ipairs(listfiles(folderPath)) do
        local fileName = file:match("([^/]+)%.lua$")
        if fileName then
            table.insert(files, fileName)
        end
    end
    return files
end


local totalPlayers = 0 
local function updatePlayerCount() 
    totalPlayers = #game.Players:GetPlayers() 
    print("服务器总人数: ".. totalPlayers)
end 
 
game.Players.PlayerAdded:Connect(function() 
    updatePlayerCount() 
end) 
 
game.Players.PlayerRemoving:Connect(function() 
    updatePlayerCount() 
end) 
 
updatePlayerCount() 

--科学记数法
local abbrev = {"", "K", "M", "B", "T", "Qa", "Qi", "Sx", "Sp", "Oc", "No", "Dc"}

local function Format(value, idp)
	local ex = math.floor(math.log(math.max(1, math.abs(value)), 1000))
	local abbrevs = abbrev [1 + ex] or ("e+"..ex)
	local normal = math.floor(value * ((10 ^ idp) / (1000 ^ ex))) / (10 ^ idp)
	
	return ("%."..idp.."f%s"):format(normal, abbrevs)
end

local player = game.Players.LocalPlayer

local Window = WindUI:CreateWindow({
    Title = "安脚本•举重模拟器", 
    Icon = "rbxassetid://125659062095965", 
    Author = "ato", 
    Folder = "安脚本ato制作",
    Size = UDim2.fromOffset(290, 340), 
    Transparent = true,
    Theme = "Dark",
    SideBarWidth = 130, 
    HasOutline = true, 
})

Window:EditOpenButton({
    Title = "打开",
    Icon = "image-upscale",  
    CornerRadius = UDim.new(0,10),
    StrokeThickness = 3,
    Color = ColorSequence.new(
        Color3.fromHex("FF0F7B"), 
        Color3.fromHex("F89B29")
    )
})

local gg = Window:Tab({
    Title = "公告",
    Icon = "notebook-tabs",
})

gg:Paragraph({
    Title = "安脚本公告",
    Desc = "1.欢迎使用安脚本，祝你玩得开心！\n2.安脚本永久免费，但还请多多关注我b站和进q群\n3.脚本默认开启反挂机，请放心使用",
    Image = "smile",
    ImageSize = 20,
})

local Paragraph5 = gg:Paragraph({
    Title = "复制",
    Buttons = {
        {
            Title = "作者B站UID",
            Callback = function()
            setclipboard("作者B站UID:3546736987474050")
            end
        },
                {
            Title = "安脚本Q群号",
            Callback = function()
            setclipboard("安脚本Q群号:1025412071")
            end
        },
    }
})

local timehh = gg:Paragraph({
    Title = "当前时间:",
    Desc = "",
    Image = "timer",
    ImageSize = 25,
})
spawn(function()
while wait() do
pcall(function()
timehh:SetDesc(""..os.date("%Y-%m-%d %H:%M:%S"))
end)
end
end)


local fuwuqi = gg:Paragraph({
    Title = "当前服务器总人数:",
    Desc = "",
    Image = "users",
    ImageSize = 25,
})
spawn(function()
while wait() do
pcall(function()
fuwuqi:SetDesc(""..totalPlayers)
end)
end
end)

local gr = Window:Tab({
    Title = "个人信息",
    Icon = "user",
})

gr:Paragraph({
    Title = "账号年龄:"..game.Players.LocalPlayer.AccountAge.."天\n服务器id:"..game.GameId.."\n用户id:"..game.Players.LocalPlayer.UserId.."\n注入器:"..identifyexecutor().."\n用户名:"..game.Players.LocalPlayer.Character.Name.."\n客户端id:\n"..game:GetService("RbxAnalyticsService"):GetClientId(),
    Desc = "\n",
})

local ty = Window:Tab({
    Title = "通用功能",
    Icon = "user-cog",
})

local Input = ty:Input({
    Title = "自定义速度",
    Value = "",
    PlaceholderText = "请输入",
    ClearTextOnFocus = false, 
    Callback = function(Text)
    game.Workspace[game.Players.LocalPlayer.Name].Humanoid.WalkSpeed = Text
    end
})

local Input = ty:Input({
    Title = "自定义跳跃高度",
    Value = "",
    PlaceholderText = "请输入",
    ClearTextOnFocus = false, 
    Callback = function(Text)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = Text
    end
})

local Input = ty:Input({
    Title = "自定义重力",
    Value = "",
    PlaceholderText = "请输入",
    ClearTextOnFocus = false, 
    Callback = function(Text)
    game.Workspace.Gravity = Text
    end
})

local Button = ty:Button({
    Title = "重置人物",
    Callback = function()
    game.Players.LocalPlayer.Character.Humanoid.Health = 0 
    end,
})

local playnametp = ""
local Input = ty:Input({
    Title = "请输入玩家用户名",
    Value = "",
    PlaceholderText = "请输入",
    ClearTextOnFocus = false,
    Callback = function(Text)
    playnametp = Text
    end
})

local Button = ty:Button({
    Title = "传送到玩家",
    Callback = function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Players")[playnametp].Character.HumanoidRootPart.CFrame
    end,
})

local ui = Window:Tab({
    Title = "脚本界面",
    Icon = "palette",
})

local fare = {"黑暗", "玫瑰", "白色"}
local themeValues = {}
for name, _ in pairs(WindUI:GetThemes()) do
    table.insert(themeValues, name)
end

--ui颜色
local currentThemeName = WindUI:GetCurrentTheme()
local themes = WindUI:GetThemes()

local ThemeAccent = themes[currentThemeName].Accent
local ThemeOutline = themes[currentThemeName].Outline
local ThemeText = themes[currentThemeName].Text
local ThemePlaceholderText = themes[currentThemeName].PlaceholderText

function updateTheme()
    WindUI:AddTheme({
        Name = currentThemeName,
        Accent = ThemeAccent,
        Outline = ThemeOutline,
        Text = ThemeText,
        PlaceholderText = ThemePlaceholderText
    })
    WindUI:SetTheme(currentThemeName)
end

local wcnm = ""
local themeDropdown = ui:Dropdown({
    Title = "选择整体风格",
    Multi = false,
    AllowNone = false,
    Value = nil,
    Values = fare,
    Callback = function(theme)
    if theme == "黑暗" then
        wcnm = "Dark"
    elseif theme == "玫瑰" then
        wcnm = "Rose"    
    elseif theme == "白色" then
        wcnm = "Light"      
    end
    WindUI:SetTheme(wcnm)
    end
})
themeDropdown:Select(WindUI:GetCurrentTheme())

ui:Colorpicker({
    Title = "背景颜色",
    Default = Color3.fromHex(ThemeAccent),
    Callback = function(color)
        ThemeAccent = color:ToHex()
    end
})

ui:Colorpicker({
    Title = "轮毂颜色",
    Default = Color3.fromHex(ThemeOutline),
    Callback = function(color)
        ThemeOutline = color:ToHex()
    end
})

ui:Colorpicker({
    Title = "文字颜色",
    Default = Color3.fromHex(ThemeText),
    Callback = function(color)
        ThemeText = color:ToHex()
    end
})

local ToggleTransparency = ui:Toggle({
    Title = "透明背景",
    Callback = function(e)
        Window:ToggleTransparency(e)
    end,
    Value = WindUI:GetTransparency()
})

ui:Button({
    Title = "刷新界面",
    Callback = function()
        updateTheme()
    end
})

Window:Divider()

local auto = Window:Tab({
    Title = "主要功能",
    Icon = "rbxassetid://3682284315",
})

_G.auto_lift = true

function auto_lift()
	while _G.auto_lift == true do
	wait()
	if game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart") then
if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") then 
	local args = {
    [1] = {
        [1] = "GainMuscle"
    }
}

game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))
else
for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do 
if v.ClassName == "Tool" and v:FindFirstChild("Income_Tool_LocalScript") then 
game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
end
end
end
end
	end
end

local Button = auto:Toggle({
    Title = "自动举重",
    Value = false,
    Callback = function(state)
        _G.auto_lift = state
            auto_lift()
    end,
})

_G.auto_sell = true

function auto_sell()
	while _G.auto_sell == true do
	wait()
	local args = {
    [1] = {
        [1] = "SellMuscle"
    }
}

game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))

	end
end

local Button = auto:Toggle({
    Title = "自动出售",
    Value = false,
    Callback = function(state)
        _G.auto_sell = state
            auto_sell()
    end,
})

 local Button = auto:Button({
    Title = "远程打开商店界面",
    Callback = function()
        game:GetService("Players").LocalPlayer.PlayerGui["Main_Gui"]["UpgradeMenu_Frame"].Visible = true
    end,
})

local xue = Window:Tab({
    Title = "血系功能",
    Icon = "rbxassetid://3682284315",
})

local boss = {"boss1","boss2"}
local tpboss = ""
local Dropdown = xue:Dropdown({
    Title = "请选择要攻击的血系boss",
    Multi = false,
    Value = "",
    AllowNone = true,
    Values = boss,
    Callback = function(Tab)
    tpboss = Tab
    end
})

local Button = xue:Toggle({
    Title = "自动攻击血系boss",
    Value = false,
    Callback = function(state)
    getgenv().xueda0 = state
        while getgenv().xueda0 do
 wait()
for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
    if v:FindFirstChild("Foot_Tool_LocalScript")  and v.Name == "Foot" then
    game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(v)
end
end

for i,h in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
if h:FindFirstChild("Foot_Tool_LocalScript") and h.Name == "Foot" then 
h:Activate()
end
end
if tpboss == "boss1" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2164.84155, -43.7419281, 1876.13171, -0.983807147, -0.17878592, -0.0126409484, -0.166644379, 0.886469901, 0.431741595, -0.0659835041, 0.426856995, -0.901909113)
elseif tpboss == "boss2" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(4766.82470703125, 90.30026245117188, 1852.72998046875)
end
end
    end,
})
