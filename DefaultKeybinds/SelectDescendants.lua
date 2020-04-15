
--[[
	Project: Utility Binds Plugin
	Author: Dr_K4rma
	Date: 29 Nov. 2019, Updated 14 April 2020
	Provides: Select Descendants
--]]

--// SERVICES AND PRIMARY OBJECTS \\--
local UIS = game:GetService("UserInputService")
local ChangeHistoryService = game:GetService("ChangeHistoryService")
local Selection = game:GetService("Selection")

local SelectDescendants = {}

--// CHANGABLE VARIABLES \\--
SelectDescendants.Binds = {
	SelectDescendants = {
		Text = "Select Descendants",
		Description = "Selects the descendants of the PARENT of the part your mouse is hovering over",
		Icon = "http://www.roblox.com/asset/?id=4479634634",
		AllowBinding = true,
	},
	AppendSelectDescendants = {
		Text = "[Append] Select Descendants",
		Description = "[Append] Selects the descendants of the PARENT of the part your mouse is hovering over",
		Icon = "http://www.roblox.com/asset/?id=4479634634",
		AllowBinding = true,
	},
}

--// FUNCTIONS \\--
function merge(...)
	local tables = {...}
	local t = {}
	for _, Table in pairs(tables) do
		if typeof(Table) == "table" then
			for _, a in pairs(Table) do
				table.insert(t, a)
			end
		else
			table.insert(t, Table)
		end
	end
	return t
end

function SelectDescendantsAction(Plugin, Append)
	Append = Append or false
	local Target = Plugin.Mouse.Target
	if not Target then return end
	local ToSelect = {}
	if (Target.Parent:IsA("Model") or Target.Parent:IsA("Folder")) and Target.Parent ~= workspace then
		if Append then
			ToSelect = merge(Selection:Get(), Target.Parent:GetDescendants())
		else
			ToSelect = Target.Parent:GetDescendants()
		end
	elseif Target:IsA("BasePart") then
		if Append then
			ToSelect = merge(Selection:Get(), Target:GetDescendants(), Target)
		else
			ToSelect = merge(Target:GetDescendants(), Target)
		end
	end
	if #ToSelect > 0 then
		Selection:Set(ToSelect)
	end
end

function SelectDescendants.SelectDescendants(Plugin)
	SelectDescendantsAction(Plugin, false)
end

function SelectDescendants.AppendSelectDescendants(Plugin)
	SelectDescendantsAction(Plugin, true)
end

--// MAIN CODE \\--

return SelectDescendants
