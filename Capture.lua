--// Module for handling user input

local UserInputService = game:GetService('UserInputService')

local KeyCodes = {
	Ctrl = "LeftControl";
	Cmd = "LeftControl";
	Command = "LeftControl";
	Control = "LeftControl";
	WinKey = "LeftSuper";
	Windows = "LeftSuper";
	Shift = "LeftShift";
	Alt = "LeftAlt";
	Enter = "Return";
	Dash = "Minus";
	Hyphen = "Minus";
	Stop = "Period";

	[0] = "Zero";	['0'] = "Zero";
	[1] = "One";	['1'] = "One";
	[2] = "Two";	['2'] = "Two";
	[3] = "Three";	['3'] = "Three";
	[4] = "Four";	['4'] = "Four";
	[5] = "Five";	['5'] = "Five";
	[6] = "Six";	['6'] = "Six";
	[7] = "Seven";	['7'] = "Seven";
	[8] = "Eight";	['8'] = "Eight";
	[9] = "Nine";	['9'] = "Nine";

	['['] = "LeftBracket";
	[']'] = "RightBracket";
	[ [[\]]] = "BackSlash";
	["'"] = "Quote";
	[';'] = "Semicolon";
	[','] = "Comma";
	['.'] = "Period";
	['/'] = "Slash";
	['-'] = "Minus";
	['='] = "Equals";
	['`'] = "Backquote";
}

local M = {
	Keys = {} :: {[number]: Key},
}
M.__index = M

--// Dependencies
local Event = require(script.Parent.Parent.Event)

--// Types
export type Key = typeof(setmetatable({}, M)) & {
	KeyCode: Enum.KeyCode;

	Event: Event.Event;

	IsDown: boolean;
	IsUp:   boolean
}

local function KeyDown(Data, GuiInput)
	if not GuiInput and Data.KeyCode ~= Enum.KeyCode.Unknown then
		local Key = M.Keys[Data.KeyCode.Value] do
			if Key then
				Key.Event:Fire()

				Key.IsDown = true
				Key.IsUp = false
			end
		end
	end
end

local function KeyUp(Data, GuiInput)
	if not GuiInput and Data.KeyCode ~= Enum.KeyCode.Unknown then
		local Key = M.Keys[Data.KeyCode.Value] do
			if Key then

				Key.IsDown = false
				Key.IsUp = true
			end
		end
	end
end

M.InputBegan = UserInputService.InputBegan:Connect(KeyDown)
M.InputEnded = UserInputService.InputEnded:Connect(KeyUp)

function M.new(KeyCode: Enum.KeyCode, ExistingEvent: Event.Event): Key
	local self = {
		KeyCode = KeyCode,
		Event  = ExistingEvent or Event.new("KeyConnection"..KeyCode.Value),

		IsDown = false,
		IsUp   = true
	}

	setmetatable(self :: Key, M)
	M.Keys[KeyCode.Value] = self :: Key

	return self :: Key
end

function M:Connect(f:()->any): Event.Connection
	return self.Event:Connect(f)
end

function M:Bind(KeyName)
	local KeyCode = Enum.KeyCode[KeyCodes[KeyName] or KeyName]
	if M.Keys[KeyCode.Value] then
		warn('Key '..KeyName..' is already in use.')
	else
		M.Keys[KeyCode.Value] = M.new(KeyCode, self.Event)
		M.Keys[self.KeyCode.Value] = nil
	end
end

function M:Map(Keys:{[string]: string})
	for i,v in Keys do

	end
end

function M:Destroy()
	M.Keys[self.KeyCode.Value] = nil

	self.Event:Destroy()
	setmetatable(self, nil)
end

local function doesEnumExist(enumList: Enum, enumItem: string)
	for _,Item:EnumItem in enumList:GetEnumItems() do
		if Item.Name == enumItem then
			return enumList[enumItem]
		end
	end

	return nil
end

local function getKeycode(KeyName)
	for _,item in Enum.KeyCode:GetEnumItems() do
		if item.Name == KeyName then
			return Enum.KeyCode[KeyName]
		end

		if item.Name == KeyCodes[KeyName] then
			return Enum.KeyCode[KeyCodes[KeyName]]
		end
	end
end

return setmetatable({
	Pause = function(self)
		M.InputBegan:Disconnect()
		M.InputEnded:Disconnect()

		return self
	end;

	Resume = function(self)
		M.InputBegan = UserInputService.InputBegan:Connect(KeyDown)
		M.InputEnded = UserInputService.InputEnded:Connect(KeyUp)

		return self
	end;
},{
	__index = function(self, k)
		local KeyCode = getKeycode(k)

		if KeyCode then
			if not M.Keys[KeyCode.Value] then
				return M.new(KeyCode)
			end

			return M.Keys[KeyCode.Value]
		end

		return M[k]
	end
})
