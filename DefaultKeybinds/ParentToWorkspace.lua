
--[[
	Project: Utility Binds Plugin
	Author: Dr_K4rma
	Date: 16 Dec. 2019
	Provides: Parent to Workspace
--]]

--// SERVICES AND PRIMARY OBJECTS \\--
local ChangeHistoryService = game:GetService("ChangeHistoryService")
local Selection = game:GetService("Selection")

local ParentToWorkspace = {}

--// CHANGABLE VARIABLES \\--
ParentToWorkspace.Binds = {
	ParentToWorkspace = {
		Text = "Parent to Workspace",
		Description = "Parents the selected objects to workspace",
		Icon = "http://www.roblox.com/asset/?id=4479634634",
		AllowBinding = true,
	}
}

--// FUNCTIONS \\--

function ParentToWorkspace.ParentToWorkspace(Plugin)
	for _, a in pairs(Selection:Get()) do
		a.Parent = workspace
		ChangeHistoryService:SetWaypoint("Parented to workspace")
	end
end

--// MAIN CODE \\--

return ParentToWorkspace
