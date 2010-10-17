local addonName, addon = ...

local updateComboPoints = function(event, unit)
	addon:SetCount(GetComboPoints(UnitHasVehicleUI("player") and "vehicle" or "player", "target"))
end

addon:RegisterEvent("PLAYER_ENTERING_WORLD", updateComboPoints)
addon:RegisterEvent("UNIT_COMBO_POINTS", updateComboPoints)
addon:RegisterEvent("UNIT_ENTERED_VEHICLE", updateComboPoints)
addon:RegisterEvent("UNIT_EXITED_VEHICLE", updateComboPoints)

ComboFrame:UnregisterAllEvents()
