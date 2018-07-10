local network   = require("network")
local Socket = require("network/sockets/socket")

TcpSocket = {

}
TcpSocket.__index = TcpSocket

setmetatable(TcpSocket, {
	__index = Socket,
	__call = function(cls, ...)
		local self = setmetatable({}, cls)
		self:constructor(...)
		return self
	end
})

function TcpSocket:constructor()
	--
end

-- Overridable Methods -----------------------------------------------------------------------------

function TcpSocket:accept()

end

function TcpSocket:connect()

end

function TcpSocket:listen()

end

function TcpSocket:send(tcpPacket)
	local route = network.routes:resolve(tcpPacket:destinationUuid())
	if not self:isOpen() then
		self:open(route.interface)
	end
	tcpPacket:setSourceUuid(route.interface:address())
	tcpPacket:setSourcePort(self:port())
	Socket.send(self, route.interface, route.destination, tcpPacket:destinationPort(), tcpPacket)
end

function TcpSocket:receive()
	local ipPacket = Socket.receive(self)
	local status, result = pcall(IpPacket.fromIpPacket, ipPacket)
	if status then
		return result
	end
	return nil
end

-- Module Export -----------------------------------------------------------------------------------

return TcpSocket
