local addonName, addon = ...

addon.config = {
	position = {"CENTER", UIParent, "BOTTOM", 0, 110},
	font = {STANDARD_TEXT_FONT, 26},
}

local config = addon.config
local frame = CreateFrame("Frame", nil, UIParent)
local count = frame:CreateFontString(nil, "OVERLAY")
local defaultColor = {1, 1, 1}
local events = {}

local onEvent = function(self, event, ...)
	local handlers = events[event]
	
	for _, handler in ipairs(events[event]) do
		handler(event, ...)
	end
end

function addon:RegisterEvent(event, handler)
	local handlers = events[event]
	
	if not handlers then
		handlers = {}
		events[event] = handlers
		frame:RegisterEvent(event)
	end
	
	table.insert(handlers, handler)
end

function addon:SetCount(value, color)
	if not color then
		color = defaultColor
	end
	
	count:SetText((value or 0) > 0 and value or "")
	count:SetTextColor(unpack(color))
end

addon:RegisterEvent("PLAYER_ENTERING_WORLD", function()
	frame:SetPoint(unpack(config.position))

	count:SetAllPoints(frame)
	count:SetJustifyH("CENTER")
	count:SetShadowOffset(0.7, -0.7)
	count:SetFont(unpack(config.font))
end)

frame:SetWidth(50)
frame:SetHeight(50)
frame:SetScript("OnEvent", onEvent)