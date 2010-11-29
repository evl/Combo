local addonName, addon = ...
local config = addon.config
local maxColor = {0, 1, 0}

if select(2, UnitClass("player")) == "SHAMAN" then
	local updateLightningShield = function(event, unit)
		if not unit or unit == "player" then
			local count = select(4, UnitAura("player", "Lightning Shield"))
			addon:SetCount(count)
			addon:SetColor(count == 9 and maxColor or config.color)
		end
	end

	addon:RegisterEvent("PLAYER_ENTERING_WORLD", updateLightningShield)
	addon:RegisterEvent("UNIT_AURA", updateLightningShield)
end