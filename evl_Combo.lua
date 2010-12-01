local addonName, addon = ...

addon.config = {
	position = {"CENTER", UIParent, "BOTTOM", 0, 110},
	font = {STANDARD_TEXT_FONT, 26},
	color = {1, 1, 1}
}

local config = addon.config
local frame = CreateFrame("Frame", nil, UIParent)
local display = frame:CreateFontString(nil, "OVERLAY")
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

function addon:SetCount(count)
	display:SetText((count or 0) > 0 and count or "")
end

function addon:SetColor(color, alpha)
	local r, g, b = unpack(color)
	
	display:SetTextColor(r, g, b, alpha or 1)
end

addon:RegisterEvent("PLAYER_ENTERING_WORLD", function()
	frame:SetPoint(unpack(config.position))

	display:SetAllPoints(frame)
	display:SetJustifyH("CENTER")
	display:SetShadowOffset(0.7, -0.7)
	display:SetFont(unpack(config.font))
	display:SetTextColor(unpack(config.color))
end)

frame:SetWidth(50)
frame:SetHeight(50)
frame:SetScript("OnEvent", onEvent)