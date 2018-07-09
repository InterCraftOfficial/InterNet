local network   = require("network")
local RawSocket = require("network/sockets/raw_socket")

Socket = {}
Socket.__index = Socket

setmetatable(Socket, {
	__index = RawSocket,
	__call = function(cls, ...)
		local self = setmetatable({}, cls)
		self:constructor(...)
		return self
	end
})

function Socket:constructor()
	--
end

-- Overridable Methods -----------------------------------------------------------------------------

function Socket:send(ipPacket)
	local route = network.routes:resolve(ipPacket:destinationUuid())
	if not self:isOpen() then
		self:open(route.interface)
	end
	ipPacket:setSourceUuid(route.interface:modem().address)
	ipPacket:setSourcePort(self:port())
	RawSocket.send(self, route.interface, route.destination, ipPacket:destinationPort(), ipPacket)
end

function Socket:receive()
	local rawPacket = RawSocket.receive(self)
	local status, result = pcall(IpPacket.fromRawPacket, rawPacket)
	if status then
		return result
	end
	return nil
end

-- Module Export -----------------------------------------------------------------------------------

return Socket
