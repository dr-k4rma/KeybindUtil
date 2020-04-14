
--[[
	Project: Utility Binds Plugin
	Author: Dr_K4rma
	Date: 28 Nov. 2019, Updated 14 April 2020
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
		Icon = "http://www.roblox.com/asset/?id=4479634634",
		AllowBinding = true,
	},
	UngroupFolder = {
		Text = "Ungroup Folder",
		Description = "Ungroup selected folders. Children will be placed inside folder's parent.",
		Icon = "http://www.roblox.com/asset/?id=4479634634",
		AllowBinding = true,
	}
}

--// MISC VARIABLES \\--


--// FUNCTIONS \\--
function GroupIntoFolder.GroupFolder()
	local Selected = Selection:Get()
	if Selected[1] then
		ChangeHistoryService:SetWaypoint("Began Grouping Folder")
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
		Selection:Set({Folder})
		ChangeHistoryService:SetWaypoint("Grouped folder")
	end
end

function GroupIntoFolder.UngroupFolder()
	local toSelect = {}
	for _, Selected in pairs(Selection:Get()) do
		if Selected:IsA("Folder") then
			for _, Child in pairs(Selected:GetChildren()) do
				Child.Parent = Selected.Parent
				table.insert(toSelect, Child)
			end
			Selected:Destroy()
		end
	end
	Selection:Set(toSelect)
	ChangeHistoryService:SetWaypoint("Ungrouped folders")
end


return GroupIntoFolder
