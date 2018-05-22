local serialization = require("serialization")
local Packet = require("network/packets/packet")

IpPacket = {
	PROTOCOL = "IP",

	__destinationUuid = nil,
	__destinationPort = nil,
	__sourceUuid      = nil,
	__sourcePort      = nil,
	__payload         = nil
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
	self.__destinationUuid = destination
	self.__destinationPort = port
	self.__sourceUuid      = nil
	self.__sourcePort      = sourcePort
	self.__payload         = payload
end

-- Methods -----------------------------------------------------------------------------------------

function IpPacket:unpack()
	return table.unpack({
		IpPacket.PROTOCOL,
		self.__destinationUuid,
		self.__destinationPort,
		self.__sourceUuid,
		self.__sourcePort,
		serialization.serialize(self.__payload)
	})
end

function IpPacket:serialize()
	return serialization.serialize({
		IpPacket.PROTOCOL,
		destUuid   = self.__destinationUuid,
		destPort   = self.__destinationPort,
		sourceUuid = self.__sourceUuid,
		sourcePort = self.__sourcePort,
		payload    = self.__payload
	})
end

-- Module Export -----------------------------------------------------------------------------------

return IpPacket
