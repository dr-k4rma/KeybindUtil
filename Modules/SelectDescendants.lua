
--[[
	Project: Utility Binds Plugin
	Author: Dr_K4rma
	Date: 29 Nov. 2019
	Provides: Select Descendants
--]]

--// SERVICES AND PRIMARY OBJECTS \\--
local ChangeHistoryService = game:GetService("ChangeHistoryService")
local Selection = game:GetService("Selection")

local SelectDescendants = {}

--// CHANGABLE VARIABLES \\--
SelectDescendants.Binds = {
	SelectDescendants = {
		Text = "Select Descendants",
		Description = "Selects the descendants of the PARENT of the part your mouse is hovering over",
		Icon = "",
		AllowBinding = true,
	}
}

--// FUNCTIONS \\--
function SelectDescendants.SelectDescendants(Plugin)
	local Target = Plugin.Mouse.Target
	local ToSelect
	if Target.Parent:IsA("Model") or Target.Parent:IsA("Folder") then
		ToSelect = Target.Parent:GetDescendants()
	end
	if ToSelect then
		Selection:Set(ToSelect)
	end
end


--// MAIN CODE \\--

return SelectDescendants
