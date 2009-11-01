evl_Combo = CreateFrame("Frame", "EvlCombo")
evl_Combo.config = {
	position = {"CENTER", UIParent, "BOTTOM", 0, 110},
	font = {STANDARD_TEXT_FONT, 26},
}

local config = evl_Combo.config
local count = evl_Combo:CreateFontString(nil, "OVERLAY")

local onEvent = function(self, event, ...)
	self[event](self, event, ...)
end

function evl_Combo:UpdateComboPoints()
	if not UnitIsDead("target") then
		local isInVehicle = UnitHasVehicleUI("player")
		local comboPoints = GetComboPoints(isInVehicle and "vehicle" or "player", "target")
	
		count:SetText(comboPoints > 0 and comboPoints or "")
	end
end

function evl_Combo:PLAYER_ENTERING_WORLD(event)
	self:SetPoint(unpack(config.position))

	count:SetAllPoints(evl_Combo)
	count:SetJustifyH("CENTER")
	count:SetShadowOffset(0.7, -0.7)
	count:SetFont(unpack(config.font))
end

function evl_Combo:PLAYER_TARGET_CHANGED(event)
	self:UpdateComboPoints()
end

function evl_Combo:UNIT_COMBO_POINTS(event, unit)
	if unit == "player" or unit == "vehicle" then
		self:UpdateComboPoints()
	end
end

function evl_Combo:UNIT_EXITED_VEHICLE(event, unit)
	if unit == "player" then
		self:UpdateComboPoints()
	end
end

evl_Combo:SetWidth(50)
evl_Combo:SetHeight(50)
evl_Combo:SetScript("OnEvent", onEvent)
evl_Combo:RegisterEvent("PLAYER_ENTERING_WORLD")
evl_Combo:RegisterEvent("PLAYER_TARGET_CHANGED")
evl_Combo:RegisterEvent("UNIT_COMBO_POINTS")
evl_Combo:RegisterEvent("UNIT_EXITED_VEHICLE")

-- Hide Blizzards's Combo Frame
ComboFrame:UnregisterEvent("PLAYER_TARGET_CHANGED")
ComboFrame:UnregisterEvent("UNIT_COMBO_POINTS")