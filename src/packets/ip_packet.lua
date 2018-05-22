local serialization = require("serialization")
local Packet = require("network/packets/packet")

IpPacket = {
	PROTOCOL = "IPV4",

	__destinationIp   = nil,
	__destinationPort = nil,
	__sourceIp        = nil,
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

function IpPacket:constructor(destination, port, sourcePort, payload)
	self.__destinationIp   = destination
	self.__destinationPort = port
	self.__sourceIp        = nil
	self.__sourcePort      = sourcePort
	self.__payload         = payload
end

-- Methods -----------------------------------------------------------------------------------------

function IpPacket:unpack()
	return table.unpack({
		IpPacket.PROTOCOL,
		self.__destinationIp,
		self.__destinationPort,
		self.__sourceIp,
		self.__sourcePort,
		serialization.serialize(self.__payload)
	})
end

function IpPacket:serialize()
	return serialization.serialize({
		IpPacket.PROTOCOL,
		destIp     = self.__destinationIp,
		destPort   = self.__destinationPort,
		sourceIp   = self.__sourceIp,
		sourcePort = self.__sourcePort,
		payload    = self.__payload
	})
end

-- Module Export -----------------------------------------------------------------------------------

return IpPacket
