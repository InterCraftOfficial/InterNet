local component = require("component")
local Interface = require("network/interfaces/interface")
local Packet    = require("network/packets/packet")
local IpPacket  = require("network/packets/ip_packet")

-- LanInterface Class ------------------------------------------------------------------------------

LanInterface = {
	LAN_PORT = 1, -- The reserved port for general IP communication

	__hwAddress      = nil,
	__modem          = nil,
	__defaultGateway = nil
}
LanInterface.__index = LanInterface

setmetatable(LanInterface, {
	__index = Interface,
	__call  = function(cls, ...)
		local self = setmetatable({}, cls)
		self:constructor(...)
		return self
	end
})

function LanInterface:constructor(name, modem)
	Interface.constructor(self, name)
	self.__modem     = modem
end

-- Methods -----------------------------------------------------------------------------------------

function LanInterface:broadcastRaw(port, packet)
	self.__modem.broadcast(port, packet:unpack())
end

function LanInterface:close(port)
	self.__modem.close(port)
end

function LanInterface:open(port)
	self.__modem.open(port)
end

function LanInterface:send(packet)
	assert(self.__hwAddress ~= nil and self.__modem ~= nil)
	packet:setSource(self.__modem.address)
	sendRaw(self.__hwAddress, LAN_PORT, packet)
end

function LanInterface:sendRaw(address, port, packet)
	self.__modem.send(address, port, packet:unpack())
end

-- Accessors ---------------------------------------------------------------------------------------

function LanInterface:defaultGateway()
	return self.__defaultGateway
end

function LanInterface:hwAddress()
	return self.__hwAddress
end

function LanInterface:modem()
	return self.__modem
end

-- Mutators ----------------------------------------------------------------------------------------

function LanInterface:setDefaultGateway(defaultGateway)
	self.__defaultGateway = defaultGateway
end

function LanInterface:setHwAddress(hwAddress)
	self.__hwAddress = hwAddress
end

function LanInterface:setModem(modem)
	self.__modem = modem
end

-- Module Export -----------------------------------------------------------------------------------

return LanInterface

