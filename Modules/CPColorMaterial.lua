
--[[
	Project: Utility Binds Plugin
	Author: Dr_K4rma
	Date: 28 Nov. 2019
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
		Icon = "",
		AllowBinding = true,
	},
	PasteMatColor = {
		Text = "Paste Material & Color",
		Description = "Pastes saved material and color to selected object",
		Icon = "",
		AllowBinding = true,
	}
}


local Saved = {
		Color = nil,
		Material = nil,
	}

--// FUNCTIONS \\--
function CPColorMaterial.CopyMatColor()
	local Selection = Selection:Get()
	if #Selection == 1 then
		Selection = Selection[1]
		if Selection:IsA("BasePart") or Selection:IsA("MeshPart") or Selection:IsA("UnionOperation") then
			Saved.Color = Selection.Color
			Saved.Material = Selection.Material
		end
	end
end

function CPColorMaterial.PasteMatColor()
	if not (Saved.Color and Saved.Material) then return end
	local Selection = Selection:Get()
	if #Selection > 0 then
		for _, a in pairs(Selection) do
			local ToProcess = a:GetChildren()
			table.insert(ToProcess, a)
			for _, Selected in pairs(ToProcess) do
				if Selected:IsA("BasePart") or Selected:IsA("MeshPart") or Selected:IsA("UnionOperation") then
					Selected.Color = Saved.Color
					Selected.Material = Saved.Material
				end
			end
		end
		ChangeHistoryService:SetWaypoint("Paste Color and Material")
	end
end

--// MAIN CODE \\--

return CPColorMaterial
