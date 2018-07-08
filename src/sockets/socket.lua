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

function Socket:send(packet)
	local route = network.routes:resolve(packet:destinationUuid())
	if not self:isOpen() then
		self:open(route.interface)
	end
	packet:setSourceUuid(route.interface:modem().address)
	packet:setSourcePort(self.__port)
	RawSocket.send(self, route.interface, route.destination, packet:destinationPort(), packet)
end

-- Module Export -----------------------------------------------------------------------------------

return Socket
