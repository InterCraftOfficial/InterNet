local serialization = require("serialization")
local Packet = require("network/packets/packet")

IpPacket = {
	PROTOCOL = "IP",
	__destinationUuid = nil,
	__destinationPort = nil,
	__sourceUuid      = nil,
	__sourcePort      = nil
}
IpPacket.__index = IpPacket

setmetatable(IpPacket, {
	__index = Packet,
	__call  = function(cls, ...)
		local self = setmetatable({}, cls)
		self:constructor(...)
		return self
	end
})

function IpPacket:constructor(destination, port, payload)
	self:setDestinationUuid(destination)
	self:setDestinationPort(port)
	self:setPayload(payload)
end

-- Methods -----------------------------------------------------------------------------------------

function IpPacket:unpack()
	return table.unpack({
		IpPacket.PROTOCOL,
		self:destinationUuid(),
		self:destinationPort(),
		self:sourceUuid(),
		self:sourcePort(),
		serialization.serialize(self:payload())
	})
end

function IpPacket:serialize()
	return serialization.serialize({
		IpPacket.PROTOCOL,
		destUuid   = self:destinationUuid(),
		destPort   = self:destinationPort(),
		sourceUuid = self:sourceUuid(),
		sourcePort = self:sourcePort(),
		payload    = self:payload()
	})
end

-- Accessors ---------------------------------------------------------------------------------------

function IpPacket:destinationUuid()
	return self.__destinationUuid
end

function IpPacket:destinationPort()
	return self.__destinationPort
end

function IpPacket:sourceUuid()
	return self.__sourceUuid
end

function IpPacket:sourcePort()
	return self.__sourcePort
end

-- Mutators ----------------------------------------------------------------------------------------

function IpPacket:setDestinationUuid(destinationUuid)
	self.__destinationUuid = destinationUuid
end

function IpPacket:setDestinationPort(destinationPort)
	self.__destinationPort = destinationPort
end

function IpPacket:setSourceUuid(sourceUuid)
	self.__sourceUuid = sourceUuid
end

function IpPacket:setSourcePort(sourcePort)
	self.__sourcePort = sourcePort
end

-- Module Export -----------------------------------------------------------------------------------

return IpPacket
