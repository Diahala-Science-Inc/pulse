--[[

Pulse Engine 0.0.1

Copyright 2025 by onnichilzz

]]--


local pulse = {
	["Haptics"] = {},
	["HapticSettings"] = {}
}

local HapticService = game:GetService("HapticService")
local UserInputService = game:GetService("UserInputService")

local devices = require(script.Parent:WaitForChild("Devices"))
local hapticTypes = require(script.Parent:WaitForChild("HapticTypes"))

type HapticSettings = {
	hapticType: number,
	hapticTime: number?,
	hapticSize: string
}

function pulse:GetDevice()
	local device = devices.Desktop
	if UserInputService.GamepadEnabled then
		device = devices.Console
	elseif UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled then
		device = devices.Mobile
	end
	return device
end

function pulse.HapticSettings:New(hapticType: number, hapticSize: string)
	local newSettings = {}
	newSettings.hapticType = hapticType
	newSettings.hapticSize = hapticSize
	local newHapticSettings:HapticSettings = newSettings
	return newHapticSettings
end

function pulse.Haptics:Haptic(hapticSettings: HapticSettings)
	
	local device = pulse:GetDevice()
	if device == devices.Mobile or device == devices.Console then
		local vibrationMotor = Enum.VibrationMotor.Small
		if hapticSettings.hapticSize == "Large" then
			vibrationMotor = Enum.VibrationMotor.Large
		elseif hapticSettings.hapticSize == "Small" then
			vibrationMotor = Enum.VibrationMotor.Small
		end
		if hapticSettings.hapticType == hapticTypes.IncreasePlusEndingShake then
			local value = 0
			for i = 1,100 do
				value  += 0.01
				HapticService:SetMotor(Enum.UserInputType.Gamepad1, vibrationMotor,value)
				task.wait(0.02)
			end
			HapticService:SetMotor(Enum.UserInputType.Gamepad1, vibrationMotor,0)
			task.wait(0.1)
			HapticService:SetMotor(Enum.UserInputType.Gamepad1, vibrationMotor,1)
			task.wait(0.1)
			HapticService:SetMotor(Enum.UserInputType.Gamepad1, vibrationMotor,0)
		elseif hapticSettings.hapticType == hapticTypes.InstantOn then
			HapticService:SetMotor(Enum.UserInputType.Gamepad1, vibrationMotor,1)
		elseif hapticSettings.hapticType == hapticTypes.InstantOff then
			HapticService:SetMotor(Enum.UserInputType.Gamepad1, vibrationMotor,0)
		elseif hapticSettings.hapticType == hapticTypes.Increasing then
			local value = 0
			for i = 1,100 do
				value  += 0.01
				HapticService:SetMotor(Enum.UserInputType.Gamepad1, vibrationMotor,value)
				task.wait(0.02)
			end	
			HapticService:SetMotor(Enum.UserInputType.Gamepad1, vibrationMotor, 0)
		end
	end
end

print("PULSE Engine has been initialized")

return pulse
