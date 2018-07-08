local serialization = require("serialization")

Packet = {
	PROTOCOL  = "RAW",
	__payload = nil
}
Packet.__index = Packet

setmetatable(Packet, {
	__call = function(cls, ...)
		local self = setmetatable({}, cls)
		self:constructor(...)
		return self
	end
})

function Packet:constructor(payload)
	self.__payload = nil
end

-- Overridable Methods -----------------------------------------------------------------------------

function Packet:unpack()
	return table.unpack({
		Packet.PROTOCOL,
		serialization.serialize(self.__payload)
	})
end

function Packet:serialize()
	return serialization.serialize({
		protocol = Packet.PROTOCOL,
		payload  = self.__payload
	})
end

-- Accessors ---------------------------------------------------------------------------------------

function Packet:payload()
	return self.__payload
end

-- Mutators ----------------------------------------------------------------------------------------

function Packet:setPayload(payload)
	self.__payload = payload
end

-- Module Export -----------------------------------------------------------------------------------

return Packet
