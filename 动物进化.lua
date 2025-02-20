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
local abbrev = {"", "K", "M", "B", "T", "Qa", "Qi"}

local function Format(value, idp)
	local ex = math.floor(math.log(math.max(1, math.abs(value)), 1000))
	local abbrevs = abbrev [1 + ex] or ("e+"..ex)
	local normal = math.floor(value * ((10 ^ idp) / (1000 ^ ex))) / (10 ^ idp)
	
	return ("%."..idp.."f%s"):format(normal, abbrevs)
end

local player = game.Players.LocalPlayer

local Window = WindUI:CreateWindow({
    Title = "安脚本•动物进化模拟器", 
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

local sj = Window:Tab({
    Title = "游戏数据",
    Icon = "file",
})

local jqsj = false
local Button = sj:Toggle({
    Title = "精确数据",
    Value = false,
    Callback = function(state)
        if state then
          jqsj = true 
        else
          jqsj = false
        end
    end,
})

local benren = sj:Paragraph({
    Title = "个人数据",
    Desc = "0",
})

spawn(function()
while wait() do
pcall(function()
if jqsj == true then
benren:SetDesc("生命:"..Format(game.Players.LocalPlayer.Character.Humanoid.Health,2).."\n伤害:"..Format(game.workspace[game.Players.LocalPlayer.Name].HurtPart.Settings.Damage.Value,2).."\n重生:"..Format(player.leaderstats.Rebirth.Value,2).."\n黄金重生:"..Format(player.leaderstats:FindFirstChild("G Rebirth").Value,2).."\n钻石重生:"..Format(player.Stats:FindFirstChild("D Rebirth").Value,2)
.."\n等级:"..Format(player.leaderstats:FindFirstChild("Lv").Value,2).."\n经验:"..Format(player.leaderstats:FindFirstChild("Xp").Value,2).."\n苹果:"..Format(player.Stats:FindFirstChild("Apples").Value,2).."\n进化币:"..Format(player.Stats:FindFirstChild("EvoCoins").Value,2).."\n幸运倍数:"..Format(player.Stats:FindFirstChild("Luck").Value,2).."\n游玩时间:"..Format(player.Stats:FindFirstChild("TimeSpent").Value,2).."分钟\n进化宝石:"..Format(player.Stats:FindFirstChild("evoGems").Value,2).."\npvp币:"..Format(player.Stats:FindFirstChild("pvpCoins").Value,2))
elseif jqsj == false then
benren:SetDesc("生命:"..game.Players.LocalPlayer.Character.Humanoid.Health.."\n伤害:"..game.workspace[game.Players.LocalPlayer.Name].HurtPart.Settings.Damage.Value.."\n重生:"..player.leaderstats.Rebirth.Value.."\n黄金重生:"..player.leaderstats:FindFirstChild("G Rebirth").Value.."\n钻石重生:"..player.Stats:FindFirstChild("D Rebirth").Value.."\n等级:"..player.leaderstats:FindFirstChild("Lv").Value.."\n经验:"..player.leaderstats:FindFirstChild("Xp").Value.."\n苹果:"..player.Stats:FindFirstChild("Apples").Value.."\n进化币:"..player.Stats:FindFirstChild("EvoCoins").Value.."\n幸运倍数:"..player.Stats:FindFirstChild("Luck").Value.."\n游玩时间:"..player.Stats:FindFirstChild("TimeSpent").Value.."分钟\n进化宝石:"..player.Stats:FindFirstChild("evoGems").Value.."\npvp币:"..player.Stats:FindFirstChild("pvpCoins").Value)
end
end)
end
end)

local name = ""
local Input = sj:Input({
    Title = "请输入玩家用户名",
    Value = "",
    PlaceholderText = "请输入",
    ClearTextOnFocus = false, 
    Callback = function(Text)
    name = Text
    end
})

local taren = sj:Paragraph({
    Title = "他人数据",
    Desc = "请先输入对方用户名",
})
spawn(function()
while wait() do
pcall(function()
if jqsj == true then
taren:SetDesc("生命:"..Format(game.Players[name].Character.Humanoid.Health,2).."\n伤害:"..Format(game.workspace[name].HurtPart.Settings.Damage.Value,2).."\n重生:"..Format(game.Players[name].leaderstats.Rebirth.Value,2).."\n黄金重生:"..Format(game.Players[name].leaderstats:FindFirstChild("G Rebirth").Value,2).."\n钻石重生:"..Format(game.Players[name].Stats:FindFirstChild("D Rebirth").Value,2)
.."\n等级:"..Format(game.Players[name].leaderstats:FindFirstChild("Lv").Value,2).."\n经验:"..Format(game.Players[name].leaderstats:FindFirstChild("Xp").Value,2).."\n苹果:"..Format(game.Players[name].Stats:FindFirstChild("Apples").Value,2).."\n进化币:"..Format(game.Players[name].Stats:FindFirstChild("EvoCoins").Value,2).."\n幸运倍数:"..Format(game.Players[name].Stats:FindFirstChild("Luck").Value,2).."\n游玩时间:"..Format(game.Players[name].Stats:FindFirstChild("TimeSpent").Value,2).."分钟\n进化宝石:"..Format(game.Players[name].Stats:FindFirstChild("evoGems").Value,2).."\npvp币:"..Format(game.Players[name].Stats:FindFirstChild("pvpCoins").Value,2))
elseif jqsj == false then
taren:SetDesc("生命:"..game.Players[name].Character.Humanoid.Health.."\n伤害:"..game.workspace[name].HurtPart.Settings.Damage.Value.."\n重生:"..game.Players[name].leaderstats.Rebirth.Value.."\n黄金重生:"..game.Players[name].leaderstats:FindFirstChild("G Rebirth").Value.."\n钻石重生:"..game.Players[name].Stats:FindFirstChild("D Rebirth").Value.."\n等级:"..game.Players[name].leaderstats:FindFirstChild("Lv").Value.."\n经验:"..game.Players[name].leaderstats:FindFirstChild("Xp").Value.."\n苹果:"..game.Players[name].Stats:FindFirstChild("Apples").Value.."\n进化币:"..game.Players[name].Stats:FindFirstChild("EvoCoins").Value.."\n幸运倍数:"..game.Players[name].Stats:FindFirstChild("Luck").Value.."\n游玩时间:"..game.Players[name].Stats:FindFirstChild("TimeSpent").Value.."分钟\n进化宝石:"..game.Players[name].Stats:FindFirstChild("evoGems").Value.."\npvp币:"..game.Players[name].Stats:FindFirstChild("pvpCoins").Value)
end
end)
end
end)

local Main = Window:Tab({
    Title = "主要功能",
    Icon = "zap",
})

_G.dmg = true

function dmg()
	while _G.dmg == true do
	wait()
	local args = {
    [1] = "DmgLevel",
    [2] = 0
}

game:GetService("ReplicatedStorage").Events.UpgradeStatEvent:FireServer(unpack(args))

local args = {
    [1] = "HpLevel",
    [2] = 0
}

game:GetService("ReplicatedStorage").Events.UpgradeStatEvent:FireServer(unpack(args))

local args = {
    [1] = "CritDmgLevel",
    [2] = 0
}

game:GetService("ReplicatedStorage").Events.UpgradeStatEvent:FireServer(unpack(args))

local args = {
    [1] = "CritRateLevel",
    [2] = 0
}

game:GetService("ReplicatedStorage").Events.UpgradeStatEvent:FireServer(unpack(args))

	end
end

Main:Section({ 
    Title = "部分出现bug，游戏本身问题",
    TextSize = 25,
})

local chusheng = {"野猪","刺猬"}
local caoyuan = {"狮子"}
local congl = {"大猩猩"}
local nowma = ""
local nowmas = ""
local master = Main:Dropdown({
    Title = "请选择要吸的怪",
    Desc = "起始区域",
    Multi = false,
    Value = "",
    AllowNone = true,
    Values = chusheng,
    Callback = function(Tab)
    nowma = Tab
    if nowma == "野猪" then
        nowmas = "Small Wild boar"
    elseif nowma == "刺猬" then
        nowmas = "Hedgehog"
    end
    end
})

local master = Main:Dropdown({
    Title = "请选择要吸的怪",
    Desc = "草原区域",
    Multi = false,
    Value = "",
    AllowNone = true,
    Values = caoyuan,
    Callback = function(Tab)
    nowma = Tab
    if nowma == "狮子" then
        nowmas = "Lion"
    end
    end
})

local master = Main:Dropdown({
    Title = "请选择要吸的怪",
    Desc = "丛林区域",
    Multi = false,
    Value = "",
    AllowNone = true,
    Values = congl,
    Callback = function(Tab)
    nowma = Tab
    if nowma == "大猩猩" then
        nowmas = "Gorilla"
    end
    end
})

local bing = {"北极熊"}

local master = Main:Dropdown({
    Title = "请选择要吸的怪",
    Desc = "寒冰区域",
    Multi = false,
    Value = "",
    AllowNone = true,
    Values = bing,
    Callback = function(Tab)
    nowma = Tab
    if nowma == "北极熊" then
        nowmas = "Polar Bear"    
    end
    end
})

local Paragraph = Main:Paragraph({
    Title = "提示",
    Desc = "魔法区域全员都有bug，都放在下面了",

})

_G.xiguai = true

function xiguai()
	while _G.xiguai == true do
	wait()
	for i, player in ipairs(game.workspace:GetChildren()) do
if player.Name == (""..nowmas) and player:FindFirstChild("HumanoidRootPart") then
player.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HurtPart.CFrame
player.HurtPart.CFrame = game.Players.LocalPlayer.Character.HurtPart.CFrame
player.Head.CFrame = game.Players.LocalPlayer.Character.HurtPart.CFrame
elseif player.Name == (""..nowmas) and player:FindFirstChild("HurtPart") then
player.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HurtPart.CFrame
player.HurtPart.CFrame = game.Players.LocalPlayer.Character.HurtPart.CFrame
player.Head.CFrame = game.Players.LocalPlayer.Character.HurtPart.CFrame
elseif player.Name == (""..nowmas) and player:FindFirstChild("Head") then
player.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HurtPart.CFrame
player.HurtPart.CFrame = game.Players.LocalPlayer.Character.HurtPart.CFrame
player.Head.CFrame = game.Players.LocalPlayer.Character.HurtPart.CFrame
end
end
	end
end

local Button = Main:Toggle({
    Title = "吸怪",
    Value = false,
    Callback = function(state)
        _G.xiguai = state
            xiguai()
    end,
})

Main:Section({ 
    Title = "bug怪物修复合集",
    TextSize = 25,
})

local bugxz = ""
local bugp = {"獴","鳄鱼","鲑鱼","企鹅","猫","鹿"}
local master = Main:Dropdown({
    Title = "请选择要吸的怪",
    Desc = "这里选择的是上面出现bug的怪物修复版",
    Multi = false,
    Value = "",
    AllowNone = true,
    Values = bugp,
    Callback = function(Tab)
    bugxz = Tab
    end
})


_G.attack = true

function attack()
	while _G.attack == true do
	wait(0.4)
	game:GetService("ReplicatedStorage").Events.AttackEvent:FireServer()
	end
end

_G.auto_xibug = true

function auto_xibug()
	while _G.auto_xibug == true do
	wait()
	if bugxz == "獴" then
	local children = workspace:GetChildren()
                    for i, child in ipairs(children) do
                        if child.Name == "Mongoose" then
                        	child.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HurtPart.CFrame
                    end    
                end
	elseif bugxz == "鳄鱼" then
local children = workspace:GetChildren()
                    for i, child in ipairs(children) do
                        if child.Name == "Crocodile" then
                        	child.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HurtPart.CFrame
                    end    
                end
    elseif bugxz == "鲑鱼" then
local children = workspace:GetChildren()
                    for i, child in ipairs(children) do
                        if child.Name == "Salmon Group" then
                        	child.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HurtPart.CFrame
                        	child.Head.CFrame = game.Players.LocalPlayer.Character.HurtPart.CFrame
                    end    
                end
      elseif bugxz == "企鹅" then
local children = workspace:GetChildren()
                    for i, child in ipairs(children) do
                        if child.Name == "Penguin" then
                        	child.Head.CFrame = game.Players.LocalPlayer.Character.HurtPart.CFrame
                        	child.FixPart.CFrame = game.Players.LocalPlayer.Character.HurtPart.CFrame                                       child.Torso.CFrame = game.Players.LocalPlayer.Character.HurtPart.CFrame	
                        	child.HurtPart.CFrame = game.Players.LocalPlayer.Character.HurtPart.CFrame	
                        	child.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HurtPart.CFrame	
 
 child.Torso.CFrame = game.Players.LocalPlayer.Character.HurtPart.CFrame	                       	                       	
                    end    
                end 
                elseif bugxz == "鹿" then
                game.Workspace:FindFirstChild("Deer").HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HurtPart.CFrame
                   elseif bugxz == "猫" then
                game.Workspace:FindFirstChild("Cat").HurtPart.CFrame = game.Players.LocalPlayer.Character.HurtPart.CFrame
          end
	end
end

local Button = Main:Toggle({
    Title = "自动吸怪",
    Value = false,
    Callback = function(state)
        _G.auto_xibug = state
            auto_xibug()
    end,
})

local Button = Main:Toggle({
    Title = "自动攻击",
    Value = false,
    Callback = function(state)
        _G.auto_attack = state
            auto_attack()
    end,
})

local ci = Window:Tab({
    Title = "次要功能",
    Icon = "plug-zap",
})

local Button = ci:Toggle({
    Title = "自动升级",
    Desc = "自动帮你免费升级伤害，生命，暴击率以及暴击伤害",
    Value = false,
    Callback = function(state)
        _G.dmg = state
            dmg()
    end,
})

_G.jhb = true

function jhb()
	while _G.jhb == true do
	wait()
	for i=1, 100 do
	
	local args = {
    [1] = "5000 EvoCoins",
    [2] = "EvoCoins"
}

game:GetService("ReplicatedStorage").Events.UpdateStatEvent:FireServer(unpack(args))
end
	end
end


local Button = ci:Toggle({
    Title = "自动获得进化币",
    Value = false,
    Callback = function(state)
        _G.jhb = state
            jhb()
    end,
})

_G.apple = true

function apple()
	while _G.apple == true do
	wait()
	for i=1, 100 do
	
	local args = {
    [1] = "09/03/2024"
}

game:GetService("ReplicatedStorage").Events.DailyGiftEvent:FireServer(unpack(args))
	end
	end
end

local Button = ci:Toggle({
    Title = "自动获得苹果",
    Desc = "附带一小点进化币",
    Value = false,
    Callback = function(state)
        _G.apple = state
            apple()
    end,
})


local reb = Window:Tab({
    Title = "重生功能",
    Icon = "refresh-cw",
})

_G.auto_shengci = true

function auto_shengci()
	while _G.auto_shengci == true do
	wait()
	game:GetService("ReplicatedStorage").Events.UpgradeRarityEvent:FireServer()
	end
end

local Button = reb:Toggle({
    Title = "自动提升稀有度",
    Value = false,
    Callback = function(state)
        _G.auto_shengci = state
            auto_shengci()
    end,
})

_G.auto_reb = true

function auto_reb()
	while _G.auto_reb == true do
	wait()
	if game.Players.LocalPlayer.leaderstats.Rebirth.Value == 10000 then
	if game.Players.LocalPlayer.leaderstats:FindFirstChild("Xp").Value >= 15000000 then
	game:GetService("ReplicatedStorage").Events.RebirthEvent:FireServer()
end
	end
	end
end

local Button = reb:Toggle({
    Title = "自动重生",
    Desc = "当你的经验足够你1万重生时，自动重生，当前重生小于1万时需先手动",
    Value = false,
    Callback = function(state)
        _G.auto_reb = state
            auto_reb()
    end,
})

_G.auto_Greb = true

function auto_Greb()
	while _G.auto_Greb == true do
	wait()
	if game.Players.LocalPlayer.leaderstats.Rebirth.Value == 10000 then
	if game.Players.LocalPlayer.leaderstats:FindFirstChild("Xp").Value >= 15000000 then
	local args = {
    [1] = true
}

game:GetService("ReplicatedStorage").Events.getGoldenRebEvent:FireServer(unpack(args))
end
end
	end
end

local Button = reb:Toggle({
    Title = "自动黄金重生",
    Desc = "当你当前重生为1万且经验为1500万时才可以重生",
    Value = false,
    Callback = function(state)
        _G.auto_Greb = state
            auto_Greb()
    end,
})
