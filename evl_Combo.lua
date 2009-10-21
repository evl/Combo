local onEvent = function(self, event, ...)
	self[event](self, event, ...)
end

evl_Combo = CreateFrame("Frame", "EvlCombo")
evl_Combo:SetWidth(50)
evl_Combo:SetHeight(50)
evl_Combo:SetPoint("CENTER", UIParent, "BOTTOM", 0, 110)

local count = evl_Combo:CreateFontString(nil, "OVERLAY")
count:SetAllPoints(evl_Combo)
count:SetFont(STANDARD_TEXT_FONT, 26)
count:SetJustifyH("CENTER")
count:SetTextColor(1, 1, 1)
count:SetShadowOffset(0.7, -0.7)

evl_Combo:SetScript("OnEvent", onEvent)
evl_Combo:RegisterEvent("PLAYER_TARGET_CHANGED")
evl_Combo:RegisterEvent("UNIT_COMBO_POINTS")
evl_Combo:RegisterEvent("UNIT_EXITED_VEHICLE")

-- Hide Blizzards's Combo Frame
ComboFrame:UnregisterEvent("PLAYER_TARGET_CHANGED")
ComboFrame:UnregisterEvent("UNIT_COMBO_POINTS")

function evl_Combo:UpdateComboPoints()
	if not UnitIsDead("target") then
		local isInVehicle = UnitHasVehicleUI("player")
		local comboPoints = GetComboPoints(isInVehicle and "vehicle" or "player", "target")
	
		count:SetText(comboPoints > 0 and comboPoints or "")
	end
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
