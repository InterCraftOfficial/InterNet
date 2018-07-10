local serialization = require("serialization")
local IpPacket = require("network/packets/ip_packet")

TcpPacket = {
	PROTOCOL = "TCP",
	FLAG_ACK = 1,
	FLAG_SYN = 2,
	FLAG_FIN = 3,
	__flag = nil,
}
TcpPacket.__index = TcpPacket

setmetatable(TcpPacket, {
	__index = IpPacket,
	__call  = function(cls, ...)
		local self = setmetatable({}, cls)
		self:constructor(...)
		return self
	end
})

function TcpPacket.fromIpPacket(ipPacket)
	return packet
end

function TcpPacket:constructor(payload)
	self:setDestinationUuid(destination)
	self:setDestinationPort(port)
	self:setPayload(payload)
end

-- Methods -----------------------------------------------------------------------------------------

function TcpPacket:unpack()
	return table.unpack({
		TcpPacket.PROTOCOL,
		self:destinationUuid(),
		self:destinationPort(),
		self:sourceUuid(),
		self:sourcePort(),
		serialization.serialize(self:payload())
	})
end

function TcpPacket:serialize()
	return serialization.serialize({
		TcpPacket.PROTOCOL,
		destUuid   = self:destinationUuid(),
		destPort   = self:destinationPort(),
		sourceUuid = self:sourceUuid(),
		sourcePort = self:sourcePort(),
		payload    = self:payload()
	})
end

-- Accessors ---------------------------------------------------------------------------------------



-- Mutators ----------------------------------------------------------------------------------------



-- Module Export -----------------------------------------------------------------------------------

return TcpPacket
