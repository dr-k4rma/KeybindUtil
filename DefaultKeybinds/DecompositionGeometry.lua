
--[[
	Project: Utility Binds Plugin
	Author: Dr_K4rma
	Date: 28 Nov. 2019
	Provides: Show Decomposition Geometry
--]]

--// SERVICES AND PRIMARY OBJECTS \\--
local PhysicsSettings = settings():GetService("PhysicsSettings")

local DecompositionGeometry = {}

--// CHANGABLE VARIABLES \\--
DecompositionGeometry.Binds = {
	ToggleDecompositionGeometry = {
		Text = "Toggle Decomposition Geometry",
		Description = "Toggles the view to show meshes/unions' hitboxes",
		Icon = "http://www.roblox.com/asset/?id=4479634634",
		AllowBinding = true,
	},
}


local Saved = {
		Color = nil,
		Material = nil,
	}

--// FUNCTIONS \\--

function DecompositionGeometry.ToggleDecompositionGeometry()
	PhysicsSettings.ShowDecompositionGeometry = not PhysicsSettings.ShowDecompositionGeometry
	for _, a in pairs(workspace:GetDescendants()) do
		if a:IsA("TriangleMeshPart") then
			local Transparency = a.Transparency
			if Transparency == .5 then
				a.Transparency = 1
			else
				a.Transparency = 1 - Transparency
			end
			a.Transparency = Transparency
		end
	end
end

--// MAIN CODE \\--

return DecompositionGeometry
