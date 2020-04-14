
--[[
	Project: Utility Binds Plugin
	Author: Dr_K4rma
	Date: 14 April 2020
	Provides: Inserts formatted scripts
--]]

--// SERVICES AND PRIMARY OBJECTS \\--
local ChangeHistoryService = game:GetService("ChangeHistoryService")
local Selection = game:GetService("Selection")

local Username

local InsertScripts = {}

--// CHANGABLE VARIABLES \\--
InsertScripts.Binds = {
	InsertScript = {
		Text = "Insert Script",
		Description = "Inserts a formatted script into the last selected object",
		Icon = "http://www.roblox.com/asset/?id=4479634634",
		AllowBinding = true,
	},
	InsertModuleScript = {
		Text = "Insert Module Script",
		Description = "Inserts a formatted module script into the last selected object",
		Icon = "http://www.roblox.com/asset/?id=4479634634",
		AllowBinding = true,
	},
	InsertLocalScript = {
		Text = "Insert Local Script",
		Description = "Inserts a formatted local script into the last selected object",
		Icon = "http://www.roblox.com/asset/?id=4479634634",
		AllowBinding = true,
	}
}

local Months = {"Jan.", "Feb.", "Mar.", "Apr.", "May", "June", "July", "Aug.", "Sept.", "Oct.", "Nov.", "Dec."}

local Formats = {
	Script = 
		"--[[\n"..
		"\tAuthor: %s\n"..
		"\tDate: %s\n\n"..
		"\tPackage: %s\n"..
		"]]--\n\n"..
		"--// SERVICES AND PRIMARY OBJECTS \\\\--\n\n\n"..
		"--// CHANGABLE VARIABLES \\\\--\n\n\n"..
		"--// MISC VARIABLES \\\\--\n\n\n"..
		"--// FUNCTIONS \\\\--\n\n\n"..
		"--// MAIN CODE \\\\--\n",
		
	ModuleScript = 
		"--[[\n"..
		"\tAuthor: %s\n"..
		"\tDate: %s\n\n"..
		"\tPackage: %s\n"..
		"]]--\n\n"..
		"--// SERVICES AND PRIMARY OBJECTS \\\\--\n\n\n"..
		"local module = {}\n"..
		"--// CHANGABLE VARIABLES \\\\--\n\n\n"..
		"--// MISC VARIABLES \\\\--\n\n\n"..
		"--// FUNCTIONS \\\\--\n\n\n"..
		"--// MAIN CODE \\\\--\n\n\n"..
		"return module",
		
	LocalScript = 
		"--[[\n"..
		"\tAuthor: %s\n"..
		"\tDate: %s\n\n"..
		"\tPackage: %s\n"..
		"]]--\n\n"..
		"--// SERVICES AND PRIMARY OBJECTS \\\\--\n\n\n"..
		"--// CHANGABLE VARIABLES \\\\--\n\n\n"..
		"--// MISC VARIABLES \\\\--\n\n\n"..
		"--// FUNCTIONS \\\\--\n\n\n"..
		"--// MAIN CODE \\\\--\n",
}

--// FUNCTIONS \\--
function InsertScriptType(Plugin, Type)
	if not Username then
		local id = Plugin.Source:GetStudioUserId()
		Username = game:GetService("Players"):GetNameFromUserIdAsync(id)
	end
	local Date = os.date("*t")
	Date = Date.day.." "..Months[Date.month].." "..Date.year
	local Selection = Selection:Get()
	if #Selection > 0 then
		Selection = Selection[#Selection]
		local newScript = Instance.new(Type)
		newScript.Source = string.format(Formats[Type], Username, Date, Selection:GetFullName())
		newScript.Parent = Selection
		Plugin.Source:OpenScript(newScript)
	end
	ChangeHistoryService:SetWaypoint("Added "..Type.." to "..Selection.Name)
end

function InsertScripts.InsertScript(Plugin)
	InsertScriptType(Plugin, "Script")
end

function InsertScripts.InsertModuleScript(Plugin)
	InsertScriptType(Plugin, "ModuleScript")
end

function InsertScripts.InsertLocalScript(Plugin)
	InsertScriptType(Plugin, "LocalScript")
end

--// MAIN CODE \\--

return InsertScripts
