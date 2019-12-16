
--[[
	Project: Utility Binds Plugin
	Author: Dr_K4rma
	Date: 28 Nov. 2019
	Provides: Toplevel UtilityBinds Initializer
--]]

--// SERVICES AND PRIMARY OBJECTS \\--

local Plugin = {}

local DefaultKeybinds = script.Parent.DefaultKeybinds

--// CHANGABLE VARIABLES \\--


--// MISC VARIABLES \\--


--// FUNCTIONS \\--


--// MAIN CODE \\--
Plugin.Source = plugin
Plugin.Mouse = Plugin.Source:GetMouse()

for _, Util in pairs(DefaultKeybinds:GetChildren()) do
	xpcall(
		function()
			Util = require(Util)
			for Bind, Info in pairs(Util.Binds) do
				local Action = Plugin.Source:CreatePluginAction(Bind, Info.Text, Info.Description, Info.Icon, Info.AllowBinding)
				Action.Triggered:Connect(function() Util[Bind](Plugin) end)
			end
		end,
		function()
			error("UtilityBinds:// Failed to load util '"..Util.Name.."'")
		end
		)
end
