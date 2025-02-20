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

local function onPlayerAdded(player) 
    local joinTime = os.time()  -- 获取当前的系统时间（在玩家加入时） 
    print(player.Name.."加入时间:"..os.date("%c",  joinTime)) 
end 

game.Players.PlayerAdded:Connect(onPlayerAdded) 

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
 
-- 初始计数
updatePlayerCount() 

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
    Title = "安脚本•极速传奇", 
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
benren:SetDesc("步数:"..Format(player.leaderstats.Steps.Value,2).."\n宝石:"..Format(player.Gems.Value,2).."\n重生:"..Format(player.leaderstats.Rebirths.Value,2).."\n圈:"..Format(player.leaderstats.Hoops.Value,2).."\n等级:"..Format(player.level.Value,2).."\n经验:"..Format(player.exp.Value,2))
elseif jqsj == false then
benren:SetDesc("步数:"..player.leaderstats.Steps.Value.."\n宝石:"..player.Gems.Value.."\n重生:"..player.leaderstats.Rebirths.Value.."\n圈:"..player.leaderstats.Hoops.Value.."\n等级:"..player.level.Value.."\n经验:"..player.exp.Value)
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
taren:SetDesc("步数:"..Format(game:GetService("Players")[name].leaderstats.Steps.Value,2).."\n宝石:"..Format(game:GetService("Players")[name].Gems.Value,2).."\n重生:"..Format(game:GetService("Players")[name].leaderstats.Rebirths.Value,2).."\n圈:"..Format(game:GetService("Players")[name].leaderstats.Hoops.Value,2).."\n等级:"..Format(game:GetService("Players")[name].level.Value,2).."\n经验:"..Format(game:GetService("Players")[name].exp.Value,2))
elseif jqsj == false then
taren:SetDesc("步数:"..game:GetService("Players")[name].leaderstats.Steps.Value.."\n宝石:"..game:GetService("Players")[name].Gems.Value.."\n重生:"..game:GetService("Players")[name].leaderstats.Rebirths.Value.."\n圈:"..game:GetService("Players")[name].leaderstats.Hoops.Value.."\n等级:"..game:GetService("Players")[name].level.Value.."\n经验:"..game:GetService("Players")[name].exp.Value)
end
end)
end
end)

local tarenyi = sj:Paragraph({
    Title = "他人隐藏数据",
    Desc = "请先输入对方用户名",
})
spawn(function()
while wait() do
pcall(function()
tarenyi:SetDesc("转盘次数:"..game:GetService("Players")[name].freeWheelSpins.Value.."\n背包容量:"..game:GetService("Players")[name].maxPetCapacity.Value)
end)
end
end)

local xg = Window:Tab({
    Title = "修改数据",
    Icon = "file-pen",
})

local Input = xg:Input({
    Title = "步数",
    Value = "",
    PlaceholderText = "请输入",
    ClearTextOnFocus = false,
    Callback = function(v)
    game:GetService("Players").LocalPlayer.leaderstats.Steps.Value = v
    end
})

local Input = xg:Input({
    Title = "宝石",
    Value = "",
    PlaceholderText = "请输入",
    ClearTextOnFocus = false,
    Callback = function(v)
    game:GetService("Players").LocalPlayer.Gems.Value = v
    end
})

local Input = xg:Input({
    Title = "重生",
    Value = "",
    PlaceholderText = "请输入",
    ClearTextOnFocus = false,
    Callback = function(v)
    game:GetService("Players").LocalPlayer.leaderstats.Rebirths.Value = v
    end
})

local Input = xg:Input({
    Title = "圈",
    Value = "",
    PlaceholderText = "请输入",
    ClearTextOnFocus = false,
    Callback = function(v)
    game:GetService("Players").LocalPlayer.leaderstats.Hoops.Value = v
    end
})

Window:Divider()

local auto = Window:Tab({
    Title = "主要功能",
    Icon = "zap",
})

local Input = auto:Input({
    Title = "请输入跳跃高度",
    Value = "",
    PlaceholderText = "请输入",
    ClearTextOnFocus = false, 
    Callback = function(Text)
    szdx = tonumber(Text)
    end
})

_G.auto_size = true

function auto_size()
	while _G.auto_size == true do
	wait()
	game:GetService("ReplicatedStorage").rEvents.changeSpeedJumpRemote:InvokeServer("changeJump", szdx)
	end
end


local Button = auto:Toggle({
    Title = "自动设置跳跃高度",
    Value = false,
    Callback = function(state)
        _G.auto_size = state
            auto_size()
    end,
})

local Input = auto:Input({
    Title = "请输入速度",
    Value = "",
    PlaceholderText = "请输入",
    ClearTextOnFocus = false, 
    Callback = function(Text)
    szdsp = tonumber(Text)
    end
})

_G.auto_speed = true

function auto_speed()
	while _G.auto_speed == true do
	wait()
	game:GetService("ReplicatedStorage").rEvents.changeSpeedJumpRemote:InvokeServer("changeSpeed", szdsp)
	end
end

local Button = auto:Toggle({
    Title = "自动设置速度",
    Value = false,
    Callback = function(state)
        _G.auto_speed = state
            auto_speed()
    end,
})

local autoball = {"红球","橙球","蓝球","黄球","钻石球","空灵球","地狱钻石球"}
local aball = ""
local Dropdown = auto:Dropdown({
    Title = "请选择吸球类型",
    Multi = false,
    Value = "",
    AllowNone = true,
    Values = autoball,
    Callback = function(Tab)
    ballq = Tab
     if ballq == "红球" then
     aball = "Red Orb"
     elseif ballq == "橙球" then
     aball = "Orange Orb" 
     elseif ballq == "蓝球" then
     aball = "Blue Orb" 
     elseif ballq == "黄球" then
     aball = "Yellow Orb" 
     elseif ballq == "钻石球" then
     aball = "Gem" 
     elseif ballq == "空灵球" then
     aball = "Ethereal Orb" 
     elseif ballq == "地狱钻石球" then
     aball = "Infernal Gem" 
     end
    end
})

local map = ""
local whoma =  {"城市","白雪城","熔岩城","传奇公路","丛林"}
local Dropdown = auto:Dropdown({
    Title = "请选择地图",
    Desc = "当前地图是什么你就选什么，想切换地图请使用传送功能",
    Multi = false,
    Value = "",
    AllowNone = true,
    Values = whoma,
    Callback = function(Tab)
    xmap = Tab
    if xmap == "城市" then
    map = "City"
    elseif xmap == "白雪城" then
    map = "Snow City"
    elseif xmap == "熔岩城" then
    map = "Magma City"
    elseif xmap == "传奇公路" then
    map = "Legends Highway"
    elseif xmap == "丛林" then
    map = "Speed Jungle"
    end
    end
})

local nowc = ""

local nowmap = auto:Paragraph({
    Title = "当前地图:",
    Desc = "",
})
spawn(function()
while wait() do
pcall(function()
if game.Players.LocalPlayer.currentMap.Value == "City" then
nowc = "城市"
elseif  game.Players.LocalPlayer.currentMap.Value == "Snow City" then
nowc = "白雪城"
elseif  game.Players.LocalPlayer.currentMap.Value == "Magma City" then
nowc = "熔岩城"
elseif  game.Players.LocalPlayer.currentMap.Value == "Legends Highway" then
nowc = "传奇公路"
elseif  game.Players.LocalPlayer.currentMap.Value == "Speed Jungle" then
nowc = "丛林"
end
nowmap:SetDesc(""..nowc)
end)
end
end)

local xqbl = 0

local Input = auto:Input({
    Title = "自定义吸球倍数:",
    Desc = "建议倍数:0~200",
    Value = "",
    PlaceholderText = "请输入",
    ClearTextOnFocus = false,
    Callback = function(Text)
    xqbl = Text
    end
})

auto:Section({ 
    Title = "吸球卡宠",
    TextSize = 25,
})

local petzs = auto:Paragraph({
    Title = "宠物总步数:",
    Desc = "",
})
spawn(function()
while wait() do
pcall(function()
petzs:SetDesc(""..game.Players.LocalPlayer.PlayerGui.gameGui.petsMenu.petInfoMenu.totalStepsLabel.stepsLabel.Text)
end)
end
end)

_G.orbauto = true

function orbauto()
	while _G.orbauto == true do
	wait(0.2)
	for i=1, (""..xqbl) do
local A_1 = "collectOrb"
local A_2 = (""..aball)
local A_3 = (""..map)
local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3)
end
	end
end

local Button = auto:Toggle({
    Title = "自动吸球",
    Desc = "关得掉，延迟由倍数决定",
    Value = false,
    Callback = function(state)
        _G.orbauto = state
            orbauto()
    end,
})

_G.auto_orb = true

function auto_orb()
	while _G.auto_orb == true do
spawn(function()
while wait() do
game:GetService("ReplicatedStorage").rEvents.rebirthEvent:FireServer("rebirthRequest")
end
end)
while wait(0.2) do
for i=1, (""..xqbl) do
local A_1 = "collectOrb"
local A_2 = (""..aball)
local A_3 = (""..map)
local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3)
end
end
	end
end

local Button = auto:Toggle({
    Title = "自动吸球",
    Desc = "开了关不掉，延迟由倍数决定，卡宠速度快",
    Value = false,
    Callback = function(state)
        _G.auto_orb = state
            auto_orb()
    end,
})

_G.quan = true

function quan()
	while _G.quan == true do
	wait()
	local children = workspace.Hoops:GetChildren()
                    for i, child in ipairs(children) do
                        if child.Name == "Hoop" then
                        child.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                    end    
                end
	end
end


auto:Section({ 
    Title = "跳圈",
    TextSize = 25,
})

local Button = auto:Toggle({
    Title = "自动跳圈",
    Value = false,
    Callback = function(state)
        _G.quan = state
            quan()
    end,
})


auto:Section({ 
    Title = "比赛",
    TextSize = 25,
})

_G.auto_join = true

function auto_join()
	while _G.auto_join == true do
	wait()
local args = {
    [1] = "joinRace"
}

game:GetService("ReplicatedStorage").rEvents.raceEvent:FireServer(unpack(args))

	end
end

local Button = auto:Toggle({
    Title = "自动参加比赛",
    Value = false,
    Callback = function(state)
        _G.auto_join = state
            auto_join()
    end,
})

_G.autocomra = true

function autocomra()
	while _G.autocomra == true do
	wait()
	if game:GetService("ReplicatedStorage").raceStarted.Value == true then
	    if game.Players.LocalPlayer.currentMap.Value == "Magma Race" then
	        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.raceMaps.Magma.finishLine:FindFirstChild("Part").CFrame
	    elseif game.Players.LocalPlayer.currentMap.Value == "Grass Race" then
	        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.raceMaps.Grassland.finishLine:FindFirstChild("Part").CFrame
	    elseif game.Players.LocalPlayer.currentMap.Value == "Desert Race" then
	        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.raceMaps.Desert.finishLine:FindFirstChild("Part").CFrame  
	 end
	 end
	end
end

local Button = auto:Toggle({
    Title = "自动完成比赛",
    Value = false,
    Callback = function(state)
        _G.autocomra = state
            autocomra()
    end,
})


local reb = Window:Tab({
    Title = "重生功能",
    Icon = "refresh-cw",
})

_G.auto_reb = true

function auto_reb()
	while _G.auto_reb == true do
	wait()
	game:GetService("ReplicatedStorage").rEvents.rebirthEvent:FireServer("rebirthRequest")
	end
end

local Button = reb:Toggle({
    Title = "自动重生",
    Value = false,
    Callback = function(state)
        _G.auto_reb = state
            auto_reb()
    end,
})

reb:Section({ 
    Title = "指定重生",
    TextSize = 25,
})

local dzcs = 0
local Input = reb:Input({
    Title = "请输入指定重生",
    Value = "",
    PlaceholderText = "请输入",
    ClearTextOnFocus = false,
    Callback = function(Text)
        dzcs = tonumber(Text)
    end
})

local cssb = ""
local Dropdown = reb:Dropdown({
    Title = "请选择重生之后吸球类型",
    Desc = "重生之后必定在城市！所以默认为城市",
    Multi = false,
    Value = "",
    AllowNone = true,
    Values = autoball,
    Callback = function(Tab)
    csball = Tab
     if csball == "红球" then
     cssb = "Red Orb"
     elseif csball == "橙球" then
     cssb = "Orange Orb" 
     elseif csball == "蓝球" then
     cssb = "Blue Orb" 
     elseif csball == "黄球" then
     cssb = "Yellow Orb" 
     elseif csball == "钻石球" then
     cssb = "Gem" 
     elseif csball == "空灵球" then
     cssb = "Ethereal Orb" 
     elseif csball == "地狱钻石球" then
     cssb = "Infernal Gem" 
     end
    end
})

_G.auto_reb_stop = true

function auto_reb_stop()
	while _G.auto_reb_stop == true do
	wait()
	if game:GetService("Players").LocalPlayer.leaderstats.Rebirths.Value >= dzcs then
local A_1 = "collectOrb"
local A_2 = (""..cssb)
local A_3 = "City"
local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3)
	else
	game:GetService("ReplicatedStorage").rEvents.rebirthEvent:FireServer("rebirthRequest")	
	end
	end
end

local Button = reb:Toggle({
    Title = "自动重生",
    Desc = "达到指定重生自动停止，不踢你，而是继续吸球",
    Value = false,
    Callback = function(state)
        _G.auto_reb_stop = state
            auto_reb_stop()
    end,
})

local tele = Window:Tab({
    Title = "传送功能",
    Icon = "door-closed",
})

local Button = tele:Button({
    Title = "城市",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-9690.380859375, 59.82936477661133, 3098.795654296875)
    end,
})

local Button = tele:Button({
    Title = "白雪城",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-9673.427734375, 59.82936477661133, 3780.18798828125)
    end,
})

local Button = tele:Button({
    Title = "熔岩城",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-11042.6572265625, 217.78936767578125, 4905.84619140625)
    end,
})

local Button = tele:Button({
    Title = "传奇公路",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-13102.474609375, 217.78936767578125, 5907.515625)
    end,
})

local Button = tele:Button({
    Title = "丛林",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-15269.0751953125, 399.1441955566406, 5567.77587890625)
    end,
})

Window:Divider()

local shop = Window:Tab({
    Title = "宠物商店",
    Icon = "shopping-cart",
})

local buyp = ""
local bpqq = ""

local buypet = shop:Paragraph({
    Title = "当前购买宠物:",
    Desc = "所需宝石:",
})
spawn(function()
while wait() do
pcall(function()
if jqsj == true then
buypet:SetTitle("当前购买宠物:"..buyp)
buypet:SetDesc("所需宝石:"..Format(game:GetService("ReplicatedStorage").cPetShopFolder:FindFirstChild(""..bpqq).priceValue.Value,2))
elseif jqsj == false then
buypet:SetTitle("当前购买宠物:"..buyp)
buypet:SetDesc("所需宝石:"..game:GetService("ReplicatedStorage").cPetShopFolder:FindFirstChild(""..bpqq).priceValue.Value)
end
end)
end
end)

_G.autobuyhei = true

function autobuyhei()
	while _G.autobuyhei == true do
	wait()
	local args = {
    [1] =game:GetService("ReplicatedStorage").cPetShopFolder:FindFirstChild(""..bpqq)
}

game:GetService("ReplicatedStorage").cPetShopRemote:InvokeServer(unpack(args))
	end
end

local Button = shop:Toggle({
    Title = "自动购买",
    Value = false,
    Callback = function(state)
        _G.autobuyhei = state
            autobuyhei()
    end,
})

local buyhc = {"斯威夫特武士","终极超速小兔","影锋小猫","永恒星云龙","黑魂小鸟","超音速飞马","融魂小狗"}

local Dropdown = shop:Dropdown({
    Title = "请选择购买宠物",
    Desc = "黑宠",
    Multi = false,
    Value = "",
    AllowNone = true,
    Values = buyhc,
    Callback = function(Tab)
    buyp = Tab
     if buyp == "斯威夫特武士" then
     bpqq = "Swift Samurai"   
     elseif buyp == "影锋小猫" then
     bpqq = "Shadows Edge Kitty"
     elseif buyp == "永恒星云龙" then
     bpqq = "Eternal Nebula Dragon"
     elseif buyp == "黑魂小鸟" then
     bpqq = "Dark Soul Birdie"
     elseif buyp == "超音速飞马" then
     bpqq = "Hypersonic Pegasus"
     elseif buyp == "融魂小狗" then
     bpqq = "Soul Fusion Dog"
     elseif buyp == "终极超速小兔" then
     bpqq = "Ultimate Overdrive Bunny"
     end       
    end
})

local buyjc = {"极速老师","金色维京人","大师狗","第一尾迹"}
local Dropdown = shop:Dropdown({
    Title = "请选择购买宠物",
    Desc = "金宠",
    Multi = false,
    Value = "",
    AllowNone = true,
    Values = buyjc,
    Callback = function(Tab)
    buyp = Tab
     if buyp == "极速老师" then
     bpqq = "Speedy Sensei"   
     elseif buyp == "金色维京人" then
     bpqq = "Golden Viking"
     elseif buyp == "大师狗" then
     bpqq = "Maestro Dog"
     elseif buyp == "第一尾迹" then
     bpqq = "1st Trail"
     end       
    end
})

shop:Section({ 
    Title = "进化",
    TextSize = 25,
})

_G.auto_jh = true

function auto_jh()
	while _G.auto_jh == true do
	wait()
	local args = {
    [1] = "evolvePet",
    [2] = (""..bpqq)
}

game:GetService("ReplicatedStorage").rEvents.petEvolveEvent:FireServer(unpack(args))
	end
end

local Button = shop:Toggle({
    Title = "自动进化",
    Desc = "这里进化的宠物是上面所选的宠物",
    Value = false,
    Callback = function(state)
        _G.auto_jh = state
            auto_jh()
    end,
})

local egg = Window:Tab({
    Title = "宠物水晶",
    Icon = "egg",
})

local petcry = {"蓝色水晶","电子传奇水晶","熔岩水晶水晶","闪电水晶","紫色水晶","红色水晶","丛林水晶","白雪水晶","地狱水晶","黄色水晶"}
local cry = ""
local cryna = ""

local eggandpe = egg:Dropdown({
    Title = "请选择水晶",
    Multi = false,
    Value = "",
    AllowNone = true,
    Values = petcry,
    Callback = function(Tab)
    cry = Tab
    if cry == "蓝色水晶" then
        cryna = "Blue Crystal"
    elseif cry == "电子传奇水晶" then
        cryna = "Electro Legends Crystal"
    elseif cry == "熔岩水晶" then
        cryna = "Lava Crystal"
    elseif cry == "闪电水晶" then
        cryna = "Lightning Crystal"
    elseif cry == "紫色水晶" then
        cryna = "Purple Crystal"
    elseif cry == "红色水晶" then
        cryna = "Red Crystal"
    elseif cry == "丛林水晶" then
        cryna = "Jungle Crystal"
    elseif cry == "白雪水晶" then
        cryna = "Snow Crystal"
    elseif cry == "地狱水晶" then
        cryna = "Inferno Crystal"
    elseif cry == "黄色水晶" then
        cryna = "Yellow Crystal"
    end     
    end
})

_G.autobuy_crye = true

function autobuy_crye()
	while _G.autobuy_crye == true do
	wait()
	local args = {
    [1] = "openCrystal",
    [2] = (""..cryna)
}

game:GetService("ReplicatedStorage").rEvents.openCrystalRemote:InvokeServer(unpack(args))

	end
end

local Button = egg:Toggle({
    Title = "自动开水晶",
    Value = false,
    Callback = function(state)
        _G.autobuy_crye = state
            autobuy_crye()
    end,
})

local eggcry = egg:Paragraph({
    Title = "当前水晶:",
    Desc = "所需宝石:",
})
spawn(function()
while wait() do
pcall(function()
if jqsj == true then
eggcry:SetTitle("当前水晶:"..cry)
eggcry:SetDesc("所需宝石:"..Format(game:GetService("ReplicatedStorage").crystalPrices:FindFirstChild(""..cryna).price.Value,2))
elseif jqsj == false then
eggcry:SetTitle("当前水晶:"..cry)
eggcry:SetDesc("所需宝石:"..game:GetService("ReplicatedStorage").crystalPrices:FindFirstChild(""..cryna).price.Value)
end
end)
end
end)
