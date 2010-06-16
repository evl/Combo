local addonName, addon = ...

addon.config = {
	position = {"CENTER", UIParent, "BOTTOM", 0, 110},
	font = {STANDARD_TEXT_FONT, 26},
}

local config = addon.config
local frame = CreateFrame("Frame", nil, UIParent)
local count = frame:CreateFontString(nil, "OVERLAY")

local onEvent = function(self, event, ...)
	addon[event](addon, event, ...)
end

function addon:UpdateComboPoints()
	if not UnitIsDead("target") then
		local isInVehicle = UnitHasVehicleUI("player")
		local comboPoints = GetComboPoints(isInVehicle and "vehicle" or "player", "target")
	
		count:SetText(comboPoints > 0 and comboPoints or "")
	end
end

function addon:PLAYER_ENTERING_WORLD(event)
	frame:SetPoint(unpack(config.position))

	count:SetAllPoints(frame)
	count:SetJustifyH("CENTER")
	count:SetShadowOffset(0.7, -0.7)
	count:SetFont(unpack(config.font))
end

function addon:PLAYER_TARGET_CHANGED(event)
	self:UpdateComboPoints()
end

function addon:UNIT_COMBO_POINTS(event, unit)
	if unit == "player" or unit == "vehicle" then
		self:UpdateComboPoints()
	end
end

function addon:UNIT_EXITED_VEHICLE(event, unit)
	if unit == "player" then
		self:UpdateComboPoints()
	end
end

frame:SetWidth(50)
frame:SetHeight(50)
frame:SetScript("OnEvent", onEvent)
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:RegisterEvent("PLAYER_TARGET_CHANGED")
frame:RegisterEvent("UNIT_COMBO_POINTS")
frame:RegisterEvent("UNIT_EXITED_VEHICLE")

-- Hide Blizzards's Combo Frame
ComboFrame:UnregisterEvent("PLAYER_TARGET_CHANGED")
ComboFrame:UnregisterEvent("UNIT_COMBO_POINTS")