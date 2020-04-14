
--[[
	Project: Utility Binds Plugin
	Author: Dr_K4rma
	Date: 28 Nov. 2019, Updated 14 April 2020
	Provides: Copy/Paste Color & Material
--]]

--// SERVICES AND PRIMARY OBJECTS \\--
local ChangeHistoryService = game:GetService("ChangeHistoryService")
local Selection = game:GetService("Selection")

local CPColorMaterial = {}

--// CHANGABLE VARIABLES \\--
CPColorMaterial.Binds = {
	CopyMatColor = {
		Text = "Copy Material & Color",
		Description = "Copies selected object's material and color",
		Icon = "http://www.roblox.com/asset/?id=4479634634",
		AllowBinding = true,
	},
	PasteMatColor = {
		Text = "Paste Material & Color",
		Description = "Pastes saved material and color to selected object",
		Icon = "http://www.roblox.com/asset/?id=4479634634",
		AllowBinding = true,
	}
}

local Saved = {
		Color = nil,
		Material = nil,
		Transparency = nil,
		Reflectance = nil,
	}

--// FUNCTIONS \\--
function CPColorMaterial.CopyMatColor()
	local Selection = Selection:Get()
	if #Selection == 1 then
		Selection = Selection[1]
		if Selection:IsA("BasePart") or Selection:IsA("MeshPart") or Selection:IsA("UnionOperation") then
			Saved.Color = Selection.Color
			Saved.Material = Selection.Material
			Saved.Transparency = Selection.Transparency
			Saved.Reflectance = Selection.Reflectance
		end
	end
end

function CPColorMaterial.PasteMatColor()
	if not Saved.Color then return end --No saved data
	local Selection = Selection:Get()
	if #Selection > 0 then
		local ToProcess = {}
		for _, a in pairs(Selection) do
			if a:IsA("Model") then
				for _, b in pairs(a:GetDescendants()) do
					if b:IsA("BasePart") then
						table.insert(ToProcess, b)
					end
				end
			elseif a:IsA("BasePart") then
				table.insert(ToProcess, a)
			end
		end
		for _, a in pairs(ToProcess) do
			a.Color = Saved.Color
			a.Material = Saved.Material
			a.Transparency = Saved.Transparency
			a.Reflectance = Saved.Reflectance
		end
		ChangeHistoryService:SetWaypoint("Paste Color and Material")
	end
end

--// MAIN CODE \\--

return CPColorMaterial
