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
    Title = "安脚本•力量传奇", 
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
    Desc = "1.欢迎使用安脚本，祝你玩得开心！\n2.还请多多关注我b站和进q群\n3.脚本默认开启反挂机，请放心使用",
    Image = "smile",
    ImageSize = 20,
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
benren:SetDesc("力量:"..Format(player.leaderstats.Strength.Value,2).."\n耐力:"..Format(player.Durability.Value,2).."\n敏捷:"..Format(player.Agility.Value,2).."\n重生:"..Format(player.leaderstats.Rebirths.Value,2).."\n宝石:"..Format(player.Gems.Value,2))
elseif jqsj == false then
benren:SetDesc("力量:"..game:GetService("Players").LocalPlayer.leaderstats.Strength.Value.."\n耐力:"..game:GetService("Players").LocalPlayer.Durability.Value.."\n敏捷:"..game:GetService("Players").LocalPlayer.Agility.Value.."\n重生:"..game:GetService("Players").LocalPlayer.leaderstats.Rebirths.Value.."\n宝石:"..game:GetService("Players").LocalPlayer.Gems.Value)
end
end)
end
end)

sj:Section({ 
    Title = "他人数据",
    TextSize = 25,
})

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
if jqsj == false then
taren:SetDesc("力量:"..game:GetService("Players")[name].leaderstats.Strength.Value.."\n耐力:"..game:GetService("Players")[name].Durability.Value.."\n敏捷:"..game:GetService("Players")[name].Agility.Value.."\n重生:"..game:GetService("Players")[name].leaderstats.Rebirths.Value.."\n宝石:"..game:GetService("Players")[name].Gems.Value)
elseif jqsj == true then
taren:SetDesc("力量:"..Format(game:GetService("Players")[name].leaderstats.Strength.Value,2).."\n耐力:"..Format(game:GetService("Players")[name].Durability.Value,2).."\n敏捷:"..Format(game:GetService("Players")[name].Agility.Value,2).."\n重生:"..Format(game:GetService("Players")[name].leaderstats.Rebirths.Value,2).."\n宝石:"..Format(game:GetService("Players")[name].Gems.Value,2))
end
end)
end
end)

local xg = Window:Tab({
    Title = "修改数据",
    Icon = "file-pen",
})

local Input = xg:Input({
    Title = "力量",
    Value = "",
    PlaceholderText = "请输入",
    ClearTextOnFocus = false,
    Callback = function(v)
    game:GetService("Players").LocalPlayer.leaderstats.Strength.Value = v
    end
})

local Input = xg:Input({
    Title = "耐力",
    Value = "",
    PlaceholderText = "请输入",
    ClearTextOnFocus = false,
    Callback = function(v)
    game:GetService("Players").LocalPlayer.Durability.Value = v
    end
})

local Input = xg:Input({
    Title = "敏捷",
    Value = "",
    PlaceholderText = "请输入",
    ClearTextOnFocus = false,
    Callback = function(v)
    game:GetService("Players").LocalPlayer.Agility.Value = v
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
    Title = "宝石",
    Value = "",
    PlaceholderText = "请输入",
    ClearTextOnFocus = false,
    Callback = function(v)
    game:GetService("Players").LocalPlayer.Gems.Value = v
    end
})

_G.qqq = true

function qqq()
	while _G.qqq == true do
	wait()
	game:GetService("ReplicatedStorage").strengthFrame.amountLabel.Text = "+100000力量"
	end
end

local Button = xg:Toggle({
    Title = "修改力量",
    Value = false,
    Callback = function(state)
        _G.qqq = state
            qqq()
    end,
})

local esp = Window:Tab({
    Title = "定位功能",
    Icon = "users",
})

function isnil(thing)
return (thing == nil)
end
local function round(n)
return math.floor(tonumber(n) + 0.5)
end
Number = math.random(1, 1000000)
function UpdatePlayerChams()
for i,v in pairs(game:GetService'Players':GetChildren()) do
    pcall(function()
        if not isnil(v.Character) then
            if ESPPlayer then
                if not isnil(v.Character.Head) and not v.Character.Head:FindFirstChild('NameEsp'..Number) then
                    local bill = Instance.new('BillboardGui',v.Character.Head)
                    bill.Name = 'NameEsp'..Number
                    bill.ExtentsOffset = Vector3.new(0, 1, 0)
                    bill.Size = UDim2.new(1,200,1,30)
                    bill.Adornee = v.Character.Head
                    bill.AlwaysOnTop = true
                    local name = Instance.new('TextLabel',bill)
                    name.Font = Enum.Font.GothamSemibold
                    name.FontSize = "Size10"
                    name.TextWrapped = true
                    name.Text = (v.Name ..' \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Character.Head.Position).Magnitude/3) ..' 米')
                    name.Size = UDim2.new(1,0,1,0)
                    name.TextYAlignment = 'Top'
                    name.BackgroundTransparency = 1
                    name.TextStrokeTransparency = 0.5
                    name.TextColor3 = Color3.new(255,255,255)
                else
                    v.Character.Head['NameEsp'..Number].TextLabel.Text = (v.Name ..' | '.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Character.Head.Position).Magnitude/3)..'米')
                end
            else
                if v.Character.Head:FindFirstChild('NameEsp'..Number) then
                    v.Character.Head:FindFirstChild('NameEsp'..Number):Destroy()
                end
            end
        end
    end)
end
end

local Button = esp:Toggle({
    Title = "定位玩家",
    Desc = "生命值过高会导致血量变为nan或inf",
    Value = false,
    Callback = function(state)
    ESPPlayer = state
    UpdatePlayerChams()
    end,
})
spawn(function()
    while wait(0.1) do
        if ESPPlayer then
            UpdatePlayerChams()
        end
    end
end)

Window:Divider()

local auto = Window:Tab({
    Title = "主要功能",
    Icon = "zap",
})

local szdx = 0
local szdsp = 0

_G.auto_zhuanp = true

function auto_zhuanp()
	while _G.auto_zhuanp == true do
	wait()
	local args = {
    [1] = "openFortuneWheel",
    [2] = game:GetService("ReplicatedStorage").fortuneWheelChances:FindFirstChild("Fortune Wheel")
}

game:GetService("ReplicatedStorage").rEvents.openFortuneWheelRemote:InvokeServer(unpack(args))

	end
end

local Button = auto:Toggle({
    Title = "自动转盘",
    Value = false,
    Callback = function(state)
        _G.auto_zhuanp = state
            auto_zhuanp()
    end,
})

_G.autozaixian = true

function autozaixian()
	while _G.autozaixian == true do
	wait()
	local args = {
    [1] = "claimGift",
    [2] = 1
}

game:GetService("ReplicatedStorage").rEvents.freeGiftClaimRemote:InvokeServer(unpack(args))

local args = {
    [1] = "claimGift",
    [2] = 2
}

game:GetService("ReplicatedStorage").rEvents.freeGiftClaimRemote:InvokeServer(unpack(args))
local args = {
    [1] = "claimGift",
    [2] = 3
}

game:GetService("ReplicatedStorage").rEvents.freeGiftClaimRemote:InvokeServer(unpack(args))

local args = {
    [1] = "claimGift",
    [2] = 4
}

game:GetService("ReplicatedStorage").rEvents.freeGiftClaimRemote:InvokeServer(unpack(args))

local args = {
    [1] = "claimGift",
    [2] = 5
}

game:GetService("ReplicatedStorage").rEvents.freeGiftClaimRemote:InvokeServer(unpack(args))

local args = {
    [1] = "claimGift",
    [2] = 6
}

game:GetService("ReplicatedStorage").rEvents.freeGiftClaimRemote:InvokeServer(unpack(args))

local args = {
    [1] = "claimGift",
    [2] = 7
}

game:GetService("ReplicatedStorage").rEvents.freeGiftClaimRemote:InvokeServer(unpack(args))

local args = {
    [1] = "claimGift",
    [2] = 8
}

game:GetService("ReplicatedStorage").rEvents.freeGiftClaimRemote:InvokeServer(unpack(args))

	end
end

_G.autochest = true

function autochest()
	while _G.autochest == true do
	wait()
	game:GetService("Workspace").mythicalChest["circleInner"].CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
wait(3.5)
game:GetService("Workspace").goldenChest["circleInner"].CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
wait(3.5)
game:GetService("Workspace").enchantedChest["circleInner"].CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
wait(3.5)
game:GetService("Workspace").magmaChest["circleInner"].CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
wait(3.5)
game:GetService("Workspace").legendsChest["circleInner"].CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
wait(3.5)
game:GetService("Workspace").eternalChest["circleInner"].CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
wait(3.5)
game:GetService("Workspace").saharaChest["circleInner"].CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
wait(3.5)
game:GetService("Workspace").thunderChest["circleInner"].CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
wait(3.5)
game:GetService("Workspace").ancientChest["circleInner"].CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
wait(3.5)
game:GetService("Workspace").midnightShadowChest["circleInner"].CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
wait(3.5)
game:GetService("Workspace").groupRewardsCircle["circleInner"].CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
wait(3.5)
game:GetService("Workspace")["Daily Chest"].circleInner.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
wait(3.5)
game:GetService("Workspace")["wonderChest"].circleInner.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
wait(3.5)
game:GetService("Workspace").wonderChest["circleInner"].CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
game:GetService("Workspace").midnightShadowChest["circleInner"].CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
game:GetService("Workspace").ancientChest["circleInner"].CFrame = game.Workspace.Part.CFrame
game:GetService("Workspace").midnightShadowChest["circleInner"].CFrame = game.Workspace.Part.CFrame
game:GetService("Workspace").thunderChest["circleInner"].CFrame = game.Workspace.Part.CFrame
game:GetService("Workspace").saharaChest["circleInner"].CFrame = game.Workspace.Part.CFrame
game:GetService("Workspace").eternalChest["circleInner"].CFrame = game.Workspace.Part.CFrame
game:GetService("Workspace").legendsChest["circleInner"].CFrame = game.Workspace.Part.CFrame
game:GetService("Workspace").magmaChest["circleInner"].CFrame = game.Workspace.Part.CFrame
game:GetService("Workspace").enchantedChest["circleInner"].CFrame = game.Workspace.Part.CFrame
game:GetService("Workspace").goldenChest["circleInner"].CFrame = game.Workspace.Part.CFrame
game:GetService("Workspace").mythicalChest["circleInner"].CFrame = game.Workspace.Part.CFrame
game:GetService("Workspace").groupRewardsCircle["circleInner"].CFrame = game.Workspace.Part.CFrame
game:GetService("Workspace")["Daily Chest"].circleInner.CFrame = game.Workspace.Part.CFrame
	end
end

local Button = auto:Toggle({
    Title = "自动收集宝箱",
    Value = false,
    Callback = function(state)
        _G.autochest = state
            autochest()
    end,
})

local Button = auto:Toggle({
    Title = "自动领在线奖励",
    Desc = "卡宠的时候不要打开，否则将会导致经验上涨",
    Value = false,
    Callback = function(state)
        _G.autozaixian = state
            autozaixian()
    end,
})

_G.auto_joinzhen = true

function auto_joinzhen()
	while _G.auto_joinzhen == true do
	wait()
	local args = {
    [1] = "joinBrawl"
}

game:GetService("ReplicatedStorage").rEvents.brawlEvent:FireServer(unpack(args))
	end
end

local Button = auto:Toggle({
    Title = "自动加入争斗",
    Value = false,
    Callback = function(state)
        _G.auto_joinzhen = state
            auto_joinzhen()
    end,
})

local Input = auto:Input({
    Title = "请输入大小",
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
	game:GetService("ReplicatedStorage").rEvents.changeSpeedSizeRemote:InvokeServer("changeSize", szdx)
	end
end

local Button = auto:Toggle({
    Title = "自动设置大小",
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
	game:GetService("ReplicatedStorage").rEvents.changeSpeedSizeRemote:InvokeServer("changeSpeed", szdsp)
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

local dq = ""

auto:Section({ 
    Title = "锻炼",
    TextSize = 25,
})

local Dropdown = auto:Dropdown({
    Title = "请选择锻炼类型",
    Multi = false,
    Value = "",
    AllowNone = true,
    Values = {
        "哑铃", "仰卧起坐", "俯卧撑", "倒立"
    },
    Callback = function(Tab)
    dq = Tab
    end
})

local Button = auto:Toggle({
    Title = "自动锻炼",
    Value = false,
    Callback = function(state)
      autowork = state
		game:GetService("RunService").Stepped:connect(
		function()
			pcall(
				function()
					if autowork then
					local args = {
    [1] = "rep"
}

game:GetService("Players").LocalPlayer.muscleEvent:FireServer(unpack(args))
						if autowork then
						    if dq == "哑铃" then
							game.Players.LocalPlayer.Character.Humanoid:EquipTool(game:GetService("Players").LocalPlayer.Backpack.Weight)
							elseif dq == "倒立" then
							game.Players.LocalPlayer.Character.Humanoid:EquipTool(game:GetService("Players").LocalPlayer.Backpack.Handstands)
							elseif dq == "仰卧起坐" then
							game.Players.LocalPlayer.Character.Humanoid:EquipTool(game:GetService("Players").LocalPlayer.Backpack.Situps)
							elseif dq == "俯卧撑" then
							game.Players.LocalPlayer.Character.Humanoid:EquipTool(game:GetService("Players").LocalPlayer.Backpack.Pushups)
							end	
						end
					end
				end
			)
		end
		)
    end,
})

local pao = {"海滩","冰霜","神话","永恒","传说"}
local pj = ""

auto:Section({ 
    Title = "跑步机",
    TextSize = 25,
})

local Dropdown = auto:Dropdown({
    Title = "请选择跑步机类型",
    Multi = false,
    Value = "",
    AllowNone = true,
    Values = pao,
    Callback = function(Tab)
    pj = Tab
    end
})

local Button = auto:Toggle({
    Title = "自动跑步",
    Value = false,
    Callback = function(Value)
        if pj == "海滩" then
        getgenv().spam = Value
while getgenv().spam do
wait()
game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = 10
game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(238.671112, 5.40315914, 387.713165, -0.0160072874, -2.90710176e-08, -0.99987185, -3.3434191e-09, 1, -2.90212157e-08, 0.99987185, 2.87843993e-09, -0.0160072874)
local oldpos = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
 
local localPlayer = Players.LocalPlayer
 
RunService:BindToRenderStep("move",
    Enum.RenderPriority.Character.Value + 1,
    function()
   	 if localPlayer.Character then
   		 local humanoid = localPlayer.Character:WaitForChild("Humanoid")
   		 if humanoid then
   			 humanoid:Move(Vector3.new(10000, 0, -1), true)
   		 end
   	 end
    end
)
end

if not getgenv().spam then
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
 
local localPlayer = Players.LocalPlayer
 
RunService:UnbindFromRenderStep("move",
    Enum.RenderPriority.Character.Value + 1,
    function()
   	 if localPlayer.Character then
   		 local humanoid = localPlayer.Character:FindFirstChild("Humanoid")
   		 if humanoid then
   			 humanoid:Move(Vector3.new(10000, 0, -1), true)
   		 end
   	 end
    end
)
end
elseif pj == "冰霜" then
 if game.Players.LocalPlayer.Agility.Value >= 2000 then
getgenv().spam = Value
while getgenv().spam do
wait()
game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = 10
game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(-3005.37866, 14.3221855, -464.697876, -0.015773816, -1.38508964e-08, 0.999875605, -5.13225586e-08, 1, 1.30429667e-08, -0.999875605, -5.11104332e-08, -0.015773816)
local oldpos = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
 
local localPlayer = Players.LocalPlayer
 
RunService:BindToRenderStep("move",
    
    Enum.RenderPriority.Character.Value + 1,
    function()
   	 if localPlayer.Character then
   		 local humanoid = localPlayer.Character:WaitForChild("Humanoid")
   		 if humanoid then
   			 humanoid:Move(Vector3.new(10000, 0, -1), true)
   		 end
   	 end
    end
)
end
end

if not getgenv().spam then
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
 
local localPlayer = Players.LocalPlayer
 
RunService:UnbindFromRenderStep("move",
    
    Enum.RenderPriority.Character.Value + 1,
    function()
   	 if localPlayer.Character then
   		 local humanoid = localPlayer.Character:FindFirstChild("Humanoid")
   		 if humanoid then
   			 humanoid:Move(Vector3.new(10000, 0, -1), true)
   		 end
   	 end
    end
)
end
elseif pj == "神话" then
if game.Players.LocalPlayer.Agility.Value >= 2000 then
getgenv().spam = Value
while getgenv().spam do
wait()
game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = 10
game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(2571.23706, 15.6896839, 898.650391, 0.999968231, 2.23868635e-09, -0.00797206629, -1.73198844e-09, 1, 6.35660768e-08, 0.00797206629, -6.3550246e-08, 0.999968231)
local oldpos = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
 
local localPlayer = Players.LocalPlayer
 
RunService:BindToRenderStep("move",
     
    Enum.RenderPriority.Character.Value + 1,
    function()
   	 if localPlayer.Character then
   		 local humanoid = localPlayer.Character:WaitForChild("Humanoid")
   		 if humanoid then
   			 humanoid:Move(Vector3.new(10000, 0, -1), true)
   		 end
   	 end
    end
)
end
end

if not getgenv().spam then
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
 
local localPlayer = Players.LocalPlayer
 
RunService:UnbindFromRenderStep("move",
     
    Enum.RenderPriority.Character.Value + 1,
    function()
   	 if localPlayer.Character then
   		 local humanoid = localPlayer.Character:FindFirstChild("Humanoid")
   		 if humanoid then
   			 humanoid:Move(Vector3.new(10000, 0, -1), true)
   		 end
   	 end
    end
)
end
elseif pj == "永恒" then
 if game.Players.LocalPlayer.Agility.Value >= 3500 then
getgenv().spam = Value
while getgenv().spam do
wait()
game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = 10
game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(-7077.79102, 29.6702118, -1457.59961, -0.0322036594, -3.31122768e-10, 0.99948132, -6.44344267e-09, 1, 1.23684493e-10, -0.99948132, -6.43611742e-09, -0.0322036594)
local oldpos = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
 
local localPlayer = Players.LocalPlayer
 
RunService:BindToRenderStep("move",
     
    Enum.RenderPriority.Character.Value + 1,
    function()
   	 if localPlayer.Character then
   		 local humanoid = localPlayer.Character:WaitForChild("Humanoid")
   		 if humanoid then
   			 humanoid:Move(Vector3.new(10000, 0, -1), true)
   		 end
   	 end
    end
)
end
end

if not getgenv().spam then
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
 
local localPlayer = Players.LocalPlayer
 
RunService:UnbindFromRenderStep("move",
     
    Enum.RenderPriority.Character.Value + 1,
    function()
   	 if localPlayer.Character then
   		 local humanoid = localPlayer.Character:FindFirstChild("Humanoid")
   		 if humanoid then
   			 humanoid:Move(Vector3.new(10000, 0, -1), true)
   		 end
   	 end
    end
)
end
elseif pj == "传说" then
 if game.Players.LocalPlayer.Agility.Value >= 3000 then
getgenv().spam = Value
while getgenv().spam do
wait()
game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = 10
game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(4370.82812, 999.358704, -3621.42773, -0.960604727, -8.41949266e-09, -0.27791819, -6.12478646e-09, 1, -9.12496567e-09, 0.27791819, -7.06329528e-09, -0.960604727)
local oldpos = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
 
local localPlayer = Players.LocalPlayer
 
RunService:BindToRenderStep("move",
     
    Enum.RenderPriority.Character.Value + 1,
    function()
   	 if localPlayer.Character then
   		 local humanoid = localPlayer.Character:WaitForChild("Humanoid")
   		 if humanoid then
   			 humanoid:Move(Vector3.new(10000, 0, -1), true)
   		 end
   	 end
    end
)
end
end

if not getgenv().spam then
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
 
local localPlayer = Players.LocalPlayer
 
RunService:UnbindFromRenderStep("move",
     
    Enum.RenderPriority.Character.Value + 1,
    function()
   	 if localPlayer.Character then
   		 local humanoid = localPlayer.Character:FindFirstChild("Humanoid")
   		 if humanoid then
   			 humanoid:Move(Vector3.new(10000, 0, -1), true)
   		 end
   	 end
    end
)
end
end
    end, 
})

local reb = Window:Tab({
    Title = "重生功能",
    Icon = "refresh-cw",
})

_G.auto_tpjr = true

function auto_tpjr()
	while _G.auto_tpjr == true do
	wait()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-8625.9296875, 13.566278457641602, -5730.4736328125)
	end
end

local Button = reb:Toggle({
    Title = "自动传送到肌肉之王",
    Value = false,
    Callback = function(state)
        _G.auto_tpjr = state
            auto_tpjr()
    end,
})


_G.auto_reb = true

function auto_reb()
	while _G.auto_reb == true do
	wait()
	game:GetService("ReplicatedStorage").rEvents.rebirthRemote:InvokeServer("rebirthRequest")	
	end
end

local yesno = true

local Dialog = Window:Dialog({
    Title = "提示",
    Content = "当前处于锁定状态，请先取消锁定状态再开启本功能",
    Buttons = {
        {
            Title = "确认",
            Callback = function()
            end
        },
    }
})

local rebno = reb:Toggle({
    Title = "自动重生",
    Locked = false,
    Value = false,
    Callback = function(state)
        if state then
        if yesno == false then
        _G.auto_reb = state
            auto_reb()
        else
        Dialog:Open()
        end
        end
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

_G.auto_reb_stop = true

function auto_reb_stop()
	while _G.auto_reb_stop == true do
	wait()
	if game:GetService("Players").LocalPlayer.leaderstats.Rebirths.Value >= dzcs then
	local args = {
    [1] = "rep"
}

game:GetService("Players").LocalPlayer.muscleEvent:FireServer(unpack(args))
	else
	local args = {
    [1] = "rebirthRequest"
}

game:GetService("ReplicatedStorage").rEvents.rebirthRemote:InvokeServer(unpack(args))

	end
	end
end

local rebst = reb:Toggle({
    Title = "自动重生",
    Desc = "达到指定重生自动停止，不踢你，而是继续锻炼",
    Locked = false,
    Value = false,
    Callback = function(state)
     if state then
     if yesno == false then
    _G.auto_reb_stop = state
            auto_reb_stop()
     else
            Dialog:Open()
     end
     end
    end,
})

reb:Section({ 
    Title = "强制解除锁定",
    TextSize = 25,
})

local zkgts = Window:Dialog({
    Title = "提示",
    Content = "确定关掉锁定？",
    Buttons = {
        {
            Title = "确认",
            Callback = function()
            yesno = false
            end
        },
        {
            Title = "算了",
            Callback = function()
            yesno = true
            end
        },
    }
})

local zkg = reb:Toggle({
    Title = "锁定总开关",
    Value = true,
    Locked = true,
    Callback = function(state)
        if state then
            yesno = true
        else
            zkgts:Open()
        end
    end,
})

local yb = Window:Tab({
    Title = "业报功能",
    Icon = "rbxassetid://3649607608",
})

local ybfq = yb:Paragraph({
    Title = "当前服务器总人数:",
    Desc = "",
    Image = "users",
    ImageSize = 25,
})
spawn(function()
while wait() do
pcall(function()
ybfq:SetDesc(""..totalPlayers)
end)
end
end)


_G.autotpking = true

function autotpking()
	while _G.autotpking == true do
	wait()
local suijiking = game.Players:GetPlayers()[math.random(1, #game.Players:GetPlayers())]
			wait()
			if game:GetService("ReplicatedStorage").muscleKing.Value == suijiking then
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = 
			CFrame.new(
					Vector3.new(
						suijiking.Character.Head.Position.X,
						suijiking.Character.Head.Position.Y,
						suijiking.Character.Head.Position.Z
					)
				)
			end
	end
end

local Button = yb:Toggle({
    Title = "自动传送到肌肉之王拥有者",
    Desc = "每次传送有间隔，间隔时间由服务器人数决定",
    Value = false,
    Callback = function(state)
        _G.autotpking = state
            autotpking()
    end,
})

local Button = yb:Toggle({
    Title = "自动挥拳",
    Value = false,
    Callback = function(Value)
  pun = Value
		game:GetService("RunService").Stepped:connect(
		function()
			pcall(
				function()
					if pun then
					local args = {
    [1] = "punch",
    [2] = "leftHand"
}

game:GetService("Players").LocalPlayer.muscleEvent:FireServer(unpack(args))

						if pun then
							game.Players.LocalPlayer.Character.Humanoid:EquipTool(
								game:GetService("Players").LocalPlayer.Backpack.Punch
							)
						end
					end
				end
			)
		end
		)
    end,
})

yb:Section({ 
    Title = "全图击杀",
    TextSize = 25,
})

local ki = {"逐个传送","隔空打人","全图吸人"}
local kk = ""

local Dropdown = yb:Dropdown({
    Title = "请选择击杀形式",
    Desc = "切换时，先把自动击杀关掉，再切换",
    Multi = false,
    Value = "",
    AllowNone = true,
    Values = ki,
    Callback = function(Tab)
    kk = Tab
    end
})

local Players = game:GetService("Players")
local whitelist = {}

local Input = yb:Input({
    Title = "击杀白名单",
    Desc = "可以指定一名玩家不打他",
    Value = "",
    PlaceholderText = "请输入",
    ClearTextOnFocus = false,
    Callback = function(input)
    local playerName = input:match("^%s*(.-)%s*$")
        if playerName and playerName ~= "" then
            local player = Players:FindFirstChild(playerName)
            if player then
                if not table.find(whitelist, playerName) then
                    table.insert(whitelist, playerName)
                end
            end
        end
    end
})

local function isInWhitelist(player, whitelist)
    return table.find(whitelist, player.Name) ~= nil
end

local function touchHead(player)
    local character = player.Character
    if character and not isInWhitelist(player, whitelist) then
        local head = character:FindFirstChild("Head")
        local localPlayer = game.Players.LocalPlayer
        local leftHand = localPlayer and localPlayer.Character:FindFirstChild("LeftHand")
        if head and leftHand then
            pcall(function()
                firetouchinterest(head, leftHand, 0)
                wait(0.01)
                firetouchinterest(head, leftHand, 1)
            end)
        end
    end
end

_G.quantu = true

function quantu()
	while _G.quantu == true do
	wait()
	for i, player in ipairs(game.Players:GetChildren()) do
if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
player.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * 1
end
end
	end
end	

local Button = yb:Toggle({
    Title = "自动击杀",
    Value = false,
    Callback = function(Value)
        if kk == "隔空打人" then
        if Value then
            _G.autokill = true
            local isRunning = false

            local function main()
                while _G.autokill do
                    for _, player in ipairs(Players:GetPlayers()) do
                        if player ~= Players.LocalPlayer then
                            touchHead(player)
                        end
                    end
                    wait(1 * 0.1)
                end
            end

            local function startCode()
                isRunning = true
                main()
            end

            startCode()
        else
            _G.autokill = false
        end
elseif kk == "全图吸人" then
_G.quantu = Value
quantu()
elseif kk == "逐个传送" then
    br = Value
		while br do
			local randomPlayer = game.Players:GetPlayers()[math.random(1, #game.Players:GetPlayers())]
			wait(0.2)
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
				CFrame.new(
					Vector3.new(
						randomPlayer.Character.Head.Position.X,
						randomPlayer.Character.Head.Position.Y,
						randomPlayer.Character.Head.Position.Z
					)
				)
				
				local args = {
    [1] = "punch",
    [2] = "leftHand"
}

game:GetService("Players").LocalPlayer.muscleEvent:FireServer(unpack(args)) 
end       
        end
    end,
})

yb:Section({ 
    Title = "全图锁人",
    TextSize = 25,
})

local sr = {}

local Input = yb:Input({
    Title = "请输入玩家用户名",
    Value = "",
    PlaceholderText = "请输入",
    ClearTextOnFocus = false,
    Callback = function(input)
    local playerName = input:match("^%s*(.-)%s*$")
        if playerName and playerName ~= "" then
            local player = Players:FindFirstChild(playerName)
            if player then
                if not table.find(sr, playerName) then
                    table.insert(sr, playerName)
                end
            end
        end
    end
})

local function isr(player, sr)
    return table.find(sr, player.Name) ~= nil
end

local function touHead(player)
    local character = player.Character
    if character and isr(player, sr) then
        local head = character:FindFirstChild("Head")
        local localPlayer = game.Players.LocalPlayer
        local leftHand = localPlayer and localPlayer.Character:FindFirstChild("LeftHand")
        if head and leftHand then
            pcall(function()
                firetouchinterest(head, leftHand, 0)
                wait(0.01)
                firetouchinterest(head, leftHand, 1)
            end)
        end
    end
end

local Button = yb:Toggle({
    Title = "自动击杀",
    Value = false,
    Callback = function(Value)
        if Value then
            _G.onekill = true
            local isRunning = false

            local function main()
                while _G.onekill do
                    for _, player in ipairs(Players:GetPlayers()) do
                        if player ~= Players.LocalPlayer then
                            touHead(player)
                        end
                    end
                    wait(1 * 0.1)
                end
            end

            local function startCode()
                isRunning = true
                main()
            end

            startCode()
        else
            _G.onekill = false
        end
    end,
})

local food = Window:Tab({
    Title = "吃食功能",
    Icon = "wheat",
})

local deg = {"小石头","中石头","大石头","沙滩石头","蓝石头","紫石头","橙石头","白石头","绿石头","丛林石头"}
local sxnl = ""
local n = ""

local gh4 = Window:Tab({
    Title = "光环功能",
    Icon = "tornado",
})

gh4:Section({ 
    Title = "交易方使用",
    TextSize = 25,
})

local tradepls = ""

local Input = gh4:Input({
    Title = "请输入要交易玩家的用户名",
    Value = "",
    PlaceholderText = "请输入",
    ClearTextOnFocus = false,
    Callback = function(Text)
    tradepls = Text
    end
})

_G.auto4ji = true

function auto4ji()
	while _G.auto4ji == true do
	wait()
	for i,h in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
if h:IsA("Tool") and h.Name == "Punch" then 
h:Activate()
end
end
if game:GetService("Players").LocalPlayer.powerUpsFolder.Unique:FindFirstChild("Muscle King") then 
if game:GetService("Players").LocalPlayer.powerUpsFolder.Unique:FindFirstChild("Muscle King").exp.Value == 0 and game:GetService("Players").LocalPlayer.powerUpsFolder.Unique:FindFirstChild("Muscle King").level.Value == 1 then
local args = {
    [1] = "equipPowerUp",
    [2] = game:GetService("Players").LocalPlayer.powerUpsFolder.Unique:FindFirstChild("Muscle King")
}

game:GetService("Players").LocalPlayer.equipPowerUpEvent:FireServer(unpack(args))
elseif game:GetService("Players").LocalPlayer.powerUpsFolder.Unique:FindFirstChild("Muscle King").exp.Value == 4000 and game:GetService("Players").LocalPlayer.powerUpsFolder.Unique:FindFirstChild("Muscle King").level.Value == 4 then
local args = {
    [1] = "unequipPowerUp"
}

game:GetService("Players").LocalPlayer.equipPowerUpEvent:FireServer(unpack(args))
end
else
local args = {
    [1] = game:GetService("ReplicatedStorage").cPetShopFolder:FindFirstChild("Muscle King")
}

game:GetService("ReplicatedStorage").cPetShopRemote:InvokeServer(unpack(args))
end
	end
end

local Button = gh4:Toggle({
    Title = "自动卡经验",
    Desc = "自动卡金环经验到4级4000经验，仅限金环和1380重生，打绿石",
    Value = false,
    Callback = function(state)
    _G.auto4ji = state
            auto4ji()
    end,
})

_G.autotrade1 = true

function autotrade1()
	while _G.autotrade1 == true do
	wait(1)
	local args = {
    [1] = "sendTradeRequest",
    [2] = game:GetService("Players")[(""..tradepls)]
}

game:GetService("ReplicatedStorage").rEvents.tradingEvent:FireServer(unpack(args))

local args = {
    [1] = "offerItem",
    [2] = game:GetService("Players").LocalPlayer.powerUpsFolder.Unique:FindFirstChild("Muscle King")
}

game:GetService("ReplicatedStorage").rEvents.tradingEvent:FireServer(unpack(args))

local args = {
    [1] = "acceptTrade"
}

game:GetService("ReplicatedStorage").rEvents.tradingEvent:FireServer(unpack(args))
	end
end

local Button = gh4:Toggle({
    Title = "自动交易",
    Value = false,
    Callback = function(state)
        _G.autotrade1 = state
            autotrade1()
    end,
})

gh4:Section({ 
    Title = "被交易方使用",
    TextSize = 25,
})

local btradepls = ""

local Input = gh4:Input({
    Title = "请输入要同意交易的玩家用户名",
    Value = "",
    PlaceholderText = "请输入",
    ClearTextOnFocus = false,
    Callback = function(Text)
    btradepls = Text
    end
})

_G.autotrade2 = true

function autotrade2()
	while _G.autotrade2 == true do
	wait()
	local args = {
    [1] = "requestAccepted",
    [2] = game:GetService("Players")[(""..btradepls)]
}

game:GetService("ReplicatedStorage").rEvents.tradingEvent:FireServer(unpack(args))

local args = {
    [1] = "acceptTrade"
}

game:GetService("ReplicatedStorage").rEvents.tradingEvent:FireServer(unpack(args))
	end
end

local Button = gh4:Toggle({
    Title = "自动同意交易",
    Value = false,
    Callback = function(state)
        _G.autotrade2 = state
            autotrade2()
    end,
})


local bug = Window:Tab({
    Title = "卡宠功能",
    Icon = "dog",
})

local dstsx = bug:Dropdown({
    Title = "请选择石头:",
    Multi = false,
    Value = "",
    AllowNone = true,
    Values = deg,
    Callback = function(Tab)
         n = Tab
     if n == "小石头" then
     sxnl = "0"
     elseif n == "中石头" then
     sxnl = "10"
     elseif n == "大石头" then
     sxnl = "100"
     elseif n == "沙滩石头" then
     sxnl = "5k"
     elseif n == "蓝石头" then
     sxnl = "150k"
     elseif n == "紫石头" then
     sxnl = "400k"
     elseif n == "橙石头" then
     sxnl = "750k"
     elseif n == "白石头" then
     sxnl = "1m"
     elseif n == "绿石头" then
     sxnl = "5m"
     elseif n == "丛林石头" then
     sxnl = "10m"
     end
    end
})

local Input = bug:Input({
    Title = "自定义挥拳速度",
    Desc = "调之前先取消装备拳头，然后再调才能生效",
    Value = "",
    PlaceholderText = "请输入",
    ClearTextOnFocus = false,
    Callback = function(Text)
    game:GetService("Players").LocalPlayer.Backpack.Punch:FindFirstChildOfClass("NumberValue").Value = Text
    end
})

local sxyddl = bug:Paragraph({
    Title = "打当前石头所需耐力:",
    Desc = "请先选择石头",
})
spawn(function()
while wait() do
pcall(function()
sxyddl:SetDesc("打当前石头所需耐力:"..sxnl)
end)
end
end)

bug:Section({ 
    Title = "传送型自动打石头",
    TextSize = 25,
})

local Button = bug:Toggle({
    Title = "自动打石头",
    Value = false,
    Callback = function(Value)
    getgenv().RK0 = Value
 while getgenv().RK0 do
 wait()
for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
    if v:IsA("Tool") and v.Name == "Punch" then
    game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(v)
end
end

for i,h in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
if h:IsA("Tool") and h.Name == "Punch" then 
h:Activate()
end
end
if n == "小石头" then
game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(7.60643005, 4.02632904, 2104.54004, -0.23040159, -8.53662385e-08, -0.973095655, -4.68743764e-08, 1, -7.66279342e-08, 0.973095655, 2.79580536e-08, -0.23040159)
elseif n == "中石头" then
if game.Players.LocalPlayer.Durability.Value >= 10 then
game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(-157.680908, 3.72453046, 434.871185, 0.923298299, -1.81774684e-09, -0.384083599, 3.45247031e-09, 1, 3.56670582e-09, 0.384083599, -4.61917082e-09, 0.923298299)
end
elseif n == "大石头" then
if game.Players.LocalPlayer.Durability.Value >= 100 then
game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(162.233673, 3.66615629, -164.686783, -0.921312928, -1.80826774e-07, -0.38882193, -9.13036544e-08, 1, -2.48719346e-07, 0.38882193, -1.93647494e-07, -0.921312928)
end
elseif n == "沙滩石头" then
if game.Players.LocalPlayer.Durability.Value >= 5000 then
game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(329.831482, 3.66450214, -618.48407, -0.806075394, -8.67358096e-08, 0.591812849, -1.05715522e-07, 1, 2.57029176e-09, -0.591812849, -6.04919563e-08, -0.806075394)
end
elseif n == "蓝石头" then
if game.Players.LocalPlayer.Durability.Value >= 150000 then
game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(-2566.78076, 3.97019577, -277.503235, -0.923934579, -4.11600105e-08, -0.382550538, -3.38838042e-08, 1, -2.57576183e-08, 0.382550538, -1.08360858e-08, -0.923934579)
end
elseif n == "紫石头" then
if game.Players.LocalPlayer.Durability.Value >= 400000 then
game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(2155.61743, 3.79830337, 1227.06482, -0.551303148, -9.16796949e-09, -0.834304988, -5.61318245e-08, 1, 2.61027839e-08, 0.834304988, 6.12216127e-08, -0.551303148)
end
elseif n == "橙石头" then
if game.Players.LocalPlayer.Durability.Value >= 750000 then
game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(-7285.6499, 3.66624784, -1228.27417, 0.857643783, -1.58175091e-08, -0.514244199, -1.22581563e-08, 1, -5.12025977e-08, 0.514244199, 5.02172774e-08, 0.857643783)
end
elseif n == "白石头" then
if game.Players.LocalPlayer.Durability.Value >= 1000000 then
game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(4160.87109, 987.829102, -4136.64502, -0.893115997, 1.25481356e-05, 0.44982639, 5.02490684e-06, 1, -1.79187136e-05, -0.44982639, -1.37431543e-05, -0.893115997) 
end
elseif n == "绿石头" then
if game.Players.LocalPlayer.Durability.Value >= 5000000 then
game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(-8957.54395, 5.53625107, -6126.90186, -0.803919137, 6.6065212e-08, 0.594738603, -8.93136143e-09, 1, -1.23155459e-07, -0.594738603, -1.04318865e-07, -0.803919137) 
end
elseif n == "丛林石头" then
if game.Players.LocalPlayer.Durability.Value >= 10000000 then
game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(-7622.2666015625, 7.850967884063721, 3011.919189453125) 
end
end
end
if not getgenv().RK0 then
game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):UnequipTools()        
end
    end,
})

bug:Section({ 
    Title = "隔空型自动打石头",
    TextSize = 25,
})

_G.auto_bugrock = true

function auto_bugrock()
	while _G.auto_bugrock == true do
	wait()
	if n == "蓝石头" then
	firetouchinterest(game.workspace.machinesFolder["Frozen Rock"].Rock, game.Players.LocalPlayer.Character.LeftHand, 0)
                    wait(0.01)
                    firetouchinterest(game.workspace.machinesFolder["Frozen Rock"].Rock, game.Players.LocalPlayer.Character.LeftHand, 1)
                        elseif n == "紫石头" then
                        local children = workspace.machinesFolder:GetChildren()
                    for i, child in ipairs(children) do
                        if child.Name == "Frozen Rock" and child.durabilityGain.Value == 30 then
                        firetouchinterest(child.Rock, game.Players.LocalPlayer.Character.LeftHand, 0)
                    wait(0.01)
                    firetouchinterest(child.Rock, game.Players.LocalPlayer.Character.LeftHand, 1)
                    end    
                end                                     
                    elseif n == "橙石头" then
                    firetouchinterest(game.workspace.machinesFolder["Inferno Rock"].Rock, game.Players.LocalPlayer.Character.LeftHand, 0)
                    wait(0.01)
                    firetouchinterest(game.workspace.machinesFolder["Inferno Rock"].Rock, game.Players.LocalPlayer.Character.LeftHand, 1)
                    elseif n == "白石头" then
                    firetouchinterest(game.workspace.machinesFolder["Rock Of Legends"].Rock, game.Players.LocalPlayer.Character.LeftHand, 0)
                    wait(0.01)
                    firetouchinterest(game.workspace.machinesFolder["Rock Of Legends"].Rock, game.Players.LocalPlayer.Character.LeftHand, 1)
                    elseif n == "绿石头" then
                    firetouchinterest(game.workspace.machinesFolder["Muscle King Mountain"].Rock, game.Players.LocalPlayer.Character.LeftHand, 0)
                    wait(0.01)
                    firetouchinterest(game.workspace.machinesFolder["Muscle King Mountain"].Rock, game.Players.LocalPlayer.Character.LeftHand, 1)
                    elseif n == "丛林石头" then
                    firetouchinterest(game.workspace.machinesFolder["Ancient Jungle Rock"].Rock, game.Players.LocalPlayer.Character.LeftHand, 0)
                    wait(0.01)
                    firetouchinterest(game.workspace.machinesFolder["Ancient Jungle Rock"].Rock, game.Players.LocalPlayer.Character.LeftHand, 1)
                    end
	end
end

local Button = bug:Toggle({
    Title = "自动打石头",
    Desc = "只支持蓝紫橙绿丛林",
    Value = false,
    Callback = function(state)
        _G.auto_bugrock = state
            auto_bugrock()
    end,
})

Window:Divider()

local pet = Window:Tab({
    Title = "宠物商店",
    Icon = "shopping-cart",
})

local buyjc = {"暗星","赛博龙","肌肉之王","守护者","力量师傅","狂热爆炸"}
local bpqq = ""

local Dropdown = pet:Dropdown({
    Title = "请选择要购买的宠物",
    Desc = "金宠",
    Multi = false,
    Value = "",
    AllowNone = true,
    Values = buyjc,
    Callback = function(Tab)
    buyp = Tab
     if buyp == "暗星" then
     bpqq = "Darkstar Hunter" 
     elseif buyp == "赛博龙" then
     bpqq = "Cybernetic Showdown Dragon"
     elseif buyp == "肌肉之王" then
     bpqq = "Muscle King"
     elseif buyp == "守护者" then
     bpqq = "Neon Guardian"
     elseif buyp == "力量师傅" then
     bpqq = "Muscle Sensei"
     elseif buyp == "狂热爆炸" then
     bpqq = "Entropic Blast"
     end       
    end
})

_G.autobuy_pet = true

function autobuy_pet()
	while _G.autobuy_pet == true do
	wait()
	local args = {
    [1] = game:GetService("ReplicatedStorage").cPetShopFolder:FindFirstChild(""..bpqq)
}

game:GetService("ReplicatedStorage").cPetShopRemote:InvokeServer(unpack(args))
	end
end

local Button = pet:Toggle({
    Title = "自动购买",
    Value = false,
    Callback = function(state)
        _G.autobuy_pet = state
            autobuy_pet()
    end,
})

local buypet = pet:Paragraph({
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

local Button = pet:Toggle({
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

local petcry = {"蓝色水晶","绿色水晶","战斗传奇水晶","暗星云水晶","冰霜水晶","银河甲骨文水晶","丛林水晶","传奇水晶","地狱水晶","神话水晶","肌肉精英水晶","天空月食水晶"}
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
    elseif cry == "绿色水晶" then
        cryna = "Green Crystal"
    elseif cry == "战斗传奇水晶" then
        cryna = "Battle Legends Crystal"
    elseif cry == "暗星云水晶" then
        cryna = "Dark Nebula Crystal"
    elseif cry == "冰霜水晶" then
        cryna = "Frost Crystal"
    elseif cry == "银河甲骨文水晶" then
        cryna = "Galaxy Oracle Crystal"
    elseif cry == "丛林水晶" then
        cryna = "Jungle Crystal"
    elseif cry == "传奇水晶" then
        cryna = "Legends Crystal"
    elseif cry == "地狱水晶" then
        cryna = "Inferno Crystal"
    elseif cry == "神话水晶" then
        cryna = "Mythical Crystal"
    elseif cry == "肌肉精英水晶" then
        cryna = "Muscle Elite Crystal"
    elseif cry == "天空月食水晶" then
        cryna = "Sky Eclipse Crystal"
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

local shc = ""
local hcs = ""
local sxcs = {"蛋白质棒","能量棒","健壮条","蛋白质奶昔","超级奶昔","能量奶昔"}

local Dropdown = food:Dropdown({
    Title = "请选择食物:",
    Multi = false,
    Value = "",
    AllowNone = true,
    Values = sxcs,
    Callback = function(Tab)
    shc = Tab
     if shc == "蛋白质棒" then
        hcs = "proteinBar"
     elseif shc == "能量棒" then
        hcs = "energyBar"
     elseif shc == "健壮条" then
        hcs = "toughBar"
     elseif shc == "蛋白质奶昔" then
        hcs = "proteinShake"  
     elseif shc == "超级奶昔" then
        hcs = "ultraShake"
     elseif shc == "能量奶昔" then
        hcs = "energyShake"   
     end         
    end
})

_G.auto_egg = true

function auto_egg()
	while _G.auto_egg == true do
	wait()
		if shc == "蛋白质棒" then
if game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart") then
if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") then 
	local args = {
    [1] = "proteinBar",
    [2] = game:GetService("Players").LocalPlayer.Character:FindFirstChild("Protein Bar")
}

game:GetService("Players").LocalPlayer.muscleEvent:FireServer(unpack(args))
else
for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do 
if v.ClassName == "Tool" and v.Name == "Protein Bar" then 
game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
end
end
end
end
elseif shc == "能量棒" then
if game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart") then
if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") then 
	local args = {
    [1] = "energyBar",
    [2] = game:GetService("Players").LocalPlayer.Character:FindFirstChild("Energy Bar")
}

game:GetService("Players").LocalPlayer.muscleEvent:FireServer(unpack(args))
else
for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do 
if v.ClassName == "Tool" and v.Name == "Energy Bar" then 
game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
end
end
end
end
elseif shc == "健壮条" then
if game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart") then
if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") then 
	local args = {
    [1] = "toughBar",
    [2] = game:GetService("Players").LocalPlayer.Character:FindFirstChild("TOUGH Bar")
}

game:GetService("Players").LocalPlayer.muscleEvent:FireServer(unpack(args))
else
for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do 
if v.ClassName == "Tool" and v.Name == "TOUGH Bar" then 
game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
end
end
end
end
elseif shc == "蛋白质奶昔" then
if game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart") then
if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") then 
	local args = {
    [1] = "proteinShake",
    [2] = game:GetService("Players").LocalPlayer.Character:FindFirstChild("Protein Shake")
}

game:GetService("Players").LocalPlayer.muscleEvent:FireServer(unpack(args))
else
for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do 
if v.ClassName == "Tool" and v.Name == "Protein Shake" then 
game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
end
end
end
end
elseif shc == "超级奶昔" then
if game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart") then
if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") then 
		local args = {
    [1] = "ultraShake",
    [2] = game:GetService("Players").LocalPlayer.Character:FindFirstChild("ULTRA Shake")
}

game:GetService("Players").LocalPlayer.muscleEvent:FireServer(unpack(args))
else
for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do 
if v.ClassName == "Tool" and v.Name == "ULTRA Shake" then 
game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
end
end
end
end
elseif shc == "能量奶昔" then
if game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart") then
if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") then 
		local args = {
    [1] = "energyShake",
    [2] = game:GetService("Players").LocalPlayer.Character:FindFirstChild("Energy Shake")
}

game:GetService("Players").LocalPlayer.muscleEvent:FireServer(unpack(args))

else
for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do 
if v.ClassName == "Tool" and v.Name == "Energy Shake" then 
game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
end
end
end
end
end
	end
end

local Button = food:Toggle({
    Title = "自动吃食",
    Desc = "切换后没效果，请检查背包里是否还有此物品，如有而无效，重新开启即可",
    Value = false,
    Callback = function(state)
        _G.auto_egg = state
            auto_egg()
    end,
})

food:Section({ 
    Title = "特殊加成物品",
    TextSize = 25,
})

local Paragraph = food:Paragraph({
    Title = "提示",
    Desc = "自动挂机吃蛋：\n1.蛋白质蛋的功能为30分钟内x2力量\n2.此功能可以让你在挂机练力量或重生时自动吃蛋（每隔30分钟）\n3.前提得保证你有蛋白质蛋！\n4.此功能可在任何器材上使用（不支持自练，即物品栏），需搭配连点器",
})

local yesdan = food:Paragraph({
    Title = "是否有蛋",
    Desc = "",
})
spawn(function()
while wait() do
pcall(function()
if game.Players.LocalPlayer.boostTimersFolder:FindFirstChild("Protein Egg") then
yesdan:SetDesc("你有蛋，可以开启自动吃蛋")
end
yesdan:SetDesc("你没蛋，不可以开启自动吃蛋")
end)
end
end)

_G.autofodeg = true

function autofodeg()
	while _G.autofodeg == true do
	wait()
if not game.Players.LocalPlayer.boostTimersFolder:FindFirstChild("Protein Egg") then
game.Players.LocalPlayer.Character.Humanoid:EquipTool(game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Protein Egg"))
end
	end
end

local Button = food:Toggle({
    Title = "自动挂机吃蛋",
    Desc = "请不要反复点击此功能",
    Value = false,
    Callback = function(state)
        _G.autofodeg = state
            autofodeg()
    end,
})

Window:Divider()

local plr = game.Players.LocalPlayer.Name

local jsping = Window:Tab({
    Title = "减少延迟",
    Icon = "hand-helping",
})

local Button = jsping:Button({
    Title = "删除显示",
    Desc = "包括力量，头衔以及粒子效果等等",
    Callback = function()
        game:GetService("ReplicatedStorage").strengthFrame:Destroy()
        wait(0.001)
        game:GetService("ReplicatedStorage").durabilityFrame:Destroy()
        wait(0.001)
        game.Workspace[(plr)].sweatPart:Destroy()
        wait(0.001)
        game.Workspace[(plr)].airPart:Destroy()
        wait(0.001)
        game:GetService("ReplicatedStorage").agilityFrame:Destroy()
    end,
})

local Button = jsping:Button({
    Title = "删除杂物",
    Callback = function()
    for i, v in pairs(game.Workspace:GetChildren()) do
	if v.Name == "Part" then
	v:Destroy()
	end
	end
	for i, n in pairs(game.Workspace:GetChildren()) do
	if n.Name == "Meshes/Pillar Model" then
	n:Destroy()
	end
	end
	for i, b in pairs(game.Workspace:GetChildren()) do
	if b.Name == "Barbell" then
	b:Destroy()
	end
	end
	for i, s in pairs(game.Workspace:GetChildren()) do
	if s.Name == "Rock" then
	s:Destroy()
	end
	end
	for i, u in pairs(game.Workspace:GetChildren()) do
	if u.Name == "Palm Tree" then
	u:Destroy()
	end
	end
    end,
})
