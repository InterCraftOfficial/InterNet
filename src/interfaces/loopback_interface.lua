local component = require("component")
local event     = require("event")
local Interface = require("network/interfaces/lan_interface")

-- LoopbackInterface Class ------------------------------------------------------------------------------

LoopbackInterface = {
	__openPorts = {}
}
LoopbackInterface.__index = LoopbackInterface

setmetatable(LoopbackInterface, {
	__index = LanInterface,
	__call  = function(cls, ...)
		local self = setmetatable({}, cls)
		self:constructor(...)
		return self
	end
})

function LoopbackInterface:constructor(name)
	LanInterface.constructor(self, name, nil)
end

-- Methods -----------------------------------------------------------------------------------------

function LoopbackInterface:open(port)
	self.__openPorts[port] = true
end

function LoopbackInterface:close(port)
	self.__openPorts[port] = nil
end

function LoopbackInterface:send(port, packet)
	-- Send packet to event handler
end

-- Accessors ---------------------------------------------------------------------------------------



-- Mutators ----------------------------------------------------------------------------------------



-- Module Export -----------------------------------------------------------------------------------

return LanInterface

