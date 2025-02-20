print("this is best open source script if skid then u mom die nigga")
local name = {
	[1268927906] = "力量传奇",
	[1119466531] = "极速传奇",
	[3358419523] = "动物进化模拟器",
	[2564505263] = "超级大力士模拟器",
	[1275875292] = "举重模拟器",
}

local listPre = {
	[1268927906] = "loadstring(game:HttpGet('https://raw.githubusercontent.com/lyyanai/Anscript/main/力量传奇.lua'))()",
	[1119466531] = "loadstring(game:HttpGet('https://raw.githubusercontent.com/lyyanai/Anscript/main/极速传奇.lua'))()",	
	[3358419523] = "loadstring(game:HttpGet('https://raw.githubusercontent.com/lyyanai/Anscript/main/动物进化.lua'))()",
	[2564505263] = "loadstring(game:HttpGet('https://raw.githubusercontent.com/lyyanai/Anscript/main/超级大力士.lua'))()",
	[1275875292] = "loadstring(game:HttpGet('https://raw.githubusercontent.com/lyyanai/Anscript/main/举重模拟器.lua'))()",
}

if listPre[game.GameId] ~= nil then
	getgenv().messagebox = function()
end
game:GetService("StarterGui"):SetCore("SendNotification",{
                Title = "欢迎使用安脚本";
                Text ="当前游戏:"..name[tonumber(game.GameId)];
                Icon = "rbxassetid://125659062095965";
                Duration = 2.5
})
	loadstring(listPre[tonumber(game.GameId)])()
else
	game:GetService("StarterGui"):SetCore("SendNotification",{
                Title = "提示";
                Text ="安脚本暂不支持此游戏";
                Icon = "rbxassetid://125659062095965";
                Duration = 2.5
})
end
