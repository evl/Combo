local addonName, addon = ...

if UnitPowerType("player") == 9 then
	local updateHolyPower = function(event, unit)
		if not unit or unit == "player" then
			addon:SetCount(UnitPower("player", SPELL_POWER_HOLY_POWER))
		end
	end

	addon:RegisterEvent("PLAYER_ENTERING_WORLD", updateHolyPower)
	addon:RegisterEvent("UNIT_DISPLAYPOWER", updateHolyPower)
	addon:RegisterEvent("UNIT_POWER", updateHolyPower)
end