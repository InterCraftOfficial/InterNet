local component = require("component")
local computer  = require("computer")
local event     = require("event")
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

function LanInterface:close(port)
	return self.__modem.close(port)
end

function LanInterface:open(port)
	return self.__modem.open(port)
end

function LanInterface:send(destination, packet)
	assert(self.__hwAddress ~= nil and self.__modem ~= nil)
	packet:setSourceUuid(self.__modem.address)
	self:sendRaw(destination, self.LAN_PORT, packet)
end

function LanInterface:sendRaw(destination, port, packet)
	if address == nil then
		self.__modem.broadcast(port, packet:unpack())
	else
		self.__modem.send(destination, port, packet:unpack())
	end
end

-- Accessors ---------------------------------------------------------------------------------------

function LanInterface:address()
	return self.__modem.address
end

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

