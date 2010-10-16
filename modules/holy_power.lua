local addonName, addon = ...

if select(2, UnitClass("player")) == "PALADIN" then
	local updateHolyPower = function(event, unit)
		if not unit or unit == "player" then
			addon:SetCount(UnitPower("player", SPELL_POWER_HOLY_POWER))
		end
	end

	addon:RegisterEvent("PLAYER_ENTERING_WORLD", updateHolyPower)
	addon:RegisterEvent("UNIT_DISPLAYPOWER", updateHolyPower)
	addon:RegisterEvent("UNIT_POWER", updateHolyPower)
	
	PaladinPowerBar:UnregisterAllEvents()
	PaladinPowerBar:SetAlpha(0)
end