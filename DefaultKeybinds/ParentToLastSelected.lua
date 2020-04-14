
--[[
	Project: Utility Binds Plugin
	Author: Dr_K4rma
	Date: 14 April. 2020
	Provides: Parent to Last Selected
--]]

--// SERVICES AND PRIMARY OBJECTS \\--
local ChangeHistoryService = game:GetService("ChangeHistoryService")
local Selection = game:GetService("Selection")

local ParentToLastSelected = {}

--// CHANGABLE VARIABLES \\--
ParentToLastSelected.Binds = {
	ParentToLastSelected = {
		Text = "Parent to Last Selected",
		Description = "Parents all selected object to the last selected object",
		Icon = "http://www.roblox.com/asset/?id=4479634634",
		AllowBinding = true,
	}
}

--// FUNCTIONS \\--

function ParentToLastSelected.ParentToLastSelected(Plugin)
	local Selection = Selection:Get()
	local TargetParent = table.remove(Selection, #Selection)
	for _, a in pairs(Selection) do
		a.Parent = TargetParent
	end
	ChangeHistoryService:SetWaypoint("Parented selected objects to "..TargetParent.Name)
end

--// MAIN CODE \\--

return ParentToLastSelected
