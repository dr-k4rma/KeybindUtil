
--[[
	Project: Utility Binds Plugin
	Author: Dr_K4rma
	Date: 28 Nov. 2019
	Provides: Place selected objects into a folder
--]]

--// SERVICES AND PRIMARY OBJECTS \\--
local ChangeHistoryService = game:GetService("ChangeHistoryService")
local Selection = game:GetService("Selection")

local GroupIntoFolder = {}

--// CHANGABLE VARIABLES \\--
GroupIntoFolder.Binds = {
	GroupFolder = {
		Text = "Group Folder",
		Description = "Group selected objects into a folder. If they share the same parent, folder will parent to the shared parent. Otherwise, it will parent to workspace",
		Icon = "",
		AllowBinding = true,
	},
	UngroupFolder = {
		Text = "Ungroup Folder",
		Description = "Ungroup selected folders. Children will be placed inside folder's parent.",
		Icon = "",
		AllowBinding = true,
	}
}

--// MISC VARIABLES \\--


--// FUNCTIONS \\--
function GroupIntoFolder.GroupFolder()
	local Selected = Selection:Get()
	local SharedParent = Selected[1].Parent
	for _, a in pairs(Selected) do
		if not (a.Parent == SharedParent) then
			SharedParent = nil
			break
		end
	end
	local Folder = Instance.new("Folder")
	for _, a in pairs(Selected) do
		a.Parent = Folder
	end
	Folder.Parent = SharedParent or workspace
	ChangeHistoryService:SetWaypoint("Grouped folder")
end

function GroupIntoFolder.UngroupFolder()
	for _, Selected in pairs(Selection:Get()) do
		if Selected:IsA("Folder") then
			for _, Child in pairs(Selected:GetChildren()) do
				Child.Parent = Selected.Parent
			end
			Selected:Destroy()
		end
	end
	ChangeHistoryService:SetWaypoint("Ungrouped folders")
end


return GroupIntoFolder
