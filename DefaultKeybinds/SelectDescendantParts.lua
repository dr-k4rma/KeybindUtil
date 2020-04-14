
--[[
	Project: Utility Binds Plugin
	Author: Dr_K4rma
	Date: 14 April 2020
	Provides: Select Descendant Parts
--]]

--// SERVICES AND PRIMARY OBJECTS \\--
local UIS = game:GetService("UserInputService")
local ChangeHistoryService = game:GetService("ChangeHistoryService")
local Selection = game:GetService("Selection")

local SelectDescendantParts = {}

--// CHANGABLE VARIABLES \\--
SelectDescendantParts.Binds = {
	SelectDescendantParts = {
		Text = "Select Descendant Parts",
		Description = "Selects the descendant parts of the PARENT of the part your mouse is hovering over",
		Icon = "http://www.roblox.com/asset/?id=4479634634",
		AllowBinding = true,
	},
	AppendSelectDescendantParts = {
		Text = "[Append] Select Descendant Parts",
		Description = "[Append] Selects the descendant parts of the PARENT of the part your mouse is hovering over",
		Icon = "http://www.roblox.com/asset/?id=4479634634",
		AllowBinding = true,
	}
}

--// FUNCTIONS \\--
function merge(...)
	local tables = {...}
	local t = {}
	for _, Table in pairs(tables) do
		if typeof(Table) == "table" then
			for _, a in pairs(Table) do
				if a:IsA("BasePart") then
					table.insert(t, a)
				end
			end
		else
			if Table:IsA("BasePart") then
				table.insert(t, Table)
			end
		end
	end
	return t
end

function SelectDescendantPartsAction(Plugin, Append)
	local Append = Append or false
	local Target = Plugin.Mouse.Target
	if not Target then return end
	local ToSelect = Append and Selection:Get() or {}
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
			ToSelect = merge(Target.Parent:GetDescendants(), Target)
		end
	end
	if #ToSelect > 0 then
		Selection:Set(ToSelect)
	end
end

function SelectDescendantParts.SelectDescendantParts(Plugin)
	SelectDescendantPartsAction(Plugin, false)
end

function SelectDescendantParts.AppendSelectDescendantParts(Plugin)
	SelectDescendantPartsAction(Plugin, true)
end

--// MAIN CODE \\--

return SelectDescendantParts
