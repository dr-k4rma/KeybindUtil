
--[[
	Project: Utility Binds Plugin
	Author: Dr_K4rma
	Date: 14 April 2020
	Provides: Anchors Descendants
--]]

--// SERVICES AND PRIMARY OBJECTS \\--
local ChangeHistoryService = game:GetService("ChangeHistoryService")
local Selection = game:GetService("Selection")

local AnchorDescendants = {}

--// CHANGABLE VARIABLES \\--
AnchorDescendants.Binds = {
	AnchorDescendants = {
		Text = "Anchor Descendants",
		Description = "Anchors the descendants of the instances selected",
		Icon = "http://www.roblox.com/asset/?id=4479634634",
		AllowBinding = true,
	}
}

--// FUNCTIONS \\--
function AnchorDescendants.AnchorDescendants(Plugin)
	local Selection = Selection:Get()
	if #Selection > 0 then
		for _, a in pairs(Selection) do
			if a:IsA("BasePart") then
				a.Anchored = true
			end
			for _, b in pairs(a:GetDescendants()) do
				if b:IsA("BasePart") then
					b.Anchored = true
				end
			end
		end
	end
	ChangeHistoryService:SetWaypoint("Anchored Descendants")
end


--// MAIN CODE \\--

return AnchorDescendants
