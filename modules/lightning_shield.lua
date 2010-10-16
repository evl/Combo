local addonName, addon = ...

if select(2, UnitClass("player")) == "SHAMAN" then
	local updateLightningShield = function(event, unit)
		if not unit or unit == "player" then
			addon:SetCount(select(4, UnitAura("player", "Lightning Shield")))
		end
	end

	addon:RegisterEvent("PLAYER_ENTERING_WORLD", updateLightningShield)
	addon:RegisterEvent("UNIT_AURA", updateLightningShield)
end