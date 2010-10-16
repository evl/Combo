local addonName, addon = ...
local maxColor = {0, 1, 0}

if select(2, UnitClass("player")) == "SHAMAN" then
	local updateLightningShield = function(event, unit)
		if not unit or unit == "player" then
			local count = select(4, UnitAura("player", "Lightning Shield"))
			addon:SetCount(count, count == 9 and maxColor or nil)
		end
	end

	addon:RegisterEvent("PLAYER_ENTERING_WORLD", updateLightningShield)
	addon:RegisterEvent("UNIT_AURA", updateLightningShield)
end