local component = require("component")
local Interface = require("network/interfaces/lan_interface")

-- LoopbackInterface Class ------------------------------------------------------------------------------

LoopbackInterface = {}
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

function LanInterface:sendIp(packet)
	assert(self.__address ~= nil and self.__modem ~= nil)
	packet.setSource(self.__ipAddress)
	sendRaw(self.__address, LAN_PORT, packet)
end

function LanInterface:sendRaw(address, port, packet)
	-- Dispatch the packet to the applications
end

function LanInterface:receive()
	-- Receive a packet
end

-- Accessors ---------------------------------------------------------------------------------------



-- Mutators ----------------------------------------------------------------------------------------



-- Module Export -----------------------------------------------------------------------------------

return LanInterface

