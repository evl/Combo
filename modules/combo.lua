local addonName, addon = ...
local config = addon.config

local getCurrentComboPoints = function()
	return GetComboPoints(UnitHasVehicleUI("player") and "vehicle" or "player", "target")
end

local updateComboPoints = function(event, unit)
	local currentComboPoints = getCurrentComboPoints()

	-- If we switched targets to a target with no combo points, switch to a faded display
	if event == "PLAYER_TARGET_CHANGED" and currentComboPoints == 0 then
		addon:SetColor(config.color, 0.6)
	else
		addon:SetCount(currentComboPoints)
		addon:SetColor(config.color)
	end	
end

addon:RegisterEvent("PLAYER_ENTERING_WORLD", updateComboPoints)
addon:RegisterEvent("UNIT_COMBO_POINTS", updateComboPoints)
addon:RegisterEvent("UNIT_ENTERED_VEHICLE", updateComboPoints)
addon:RegisterEvent("UNIT_EXITED_VEHICLE", updateComboPoints)
addon:RegisterEvent("PLAYER_TARGET_CHANGED", updateComboPoints)

ComboFrame:UnregisterAllEvents()
