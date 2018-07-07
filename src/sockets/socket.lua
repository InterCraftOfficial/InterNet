local network   = require("network")
local netutils  = require("network/netutils")

Socket = {
	__port       = nil,
	__blocking   = true,
	__timeout    = nil,
	__interface  = nil,
	__isOpen     = false,
	__isFinished = false
}
Socket.__index = Socket

setmetatable(Socket, {
	__call = function(cls, ...)
		local self = setmetatable({}, cls)
		self:constructor(...)
		return self
	end
})

function Socket:constructor()

end

-- Methods -----------------------------------------------------------------------------------------

function Socket:bind(interface, port)
	self:open(interface, port)
end

function Socket:open(interface, port)
	assert(not self.__isFinished)
	if interface == nil then
		interface = network.defaultInterface()
	end
	if port == nil then
		port = netutils.randomPort()
		while network.manager:isOpen(port) do
			port = netutils.randomPort()
		end
	end
	network.manager:open(interface, port)
	self.__interface = interface
	self.__port      = port
	self.__isOpen    = true
end

function Socket:close()
	assert(self.__isOpen)
	network.manager:close(self.__port)
	self.__isOpen     = false
	self.__isFinished = true
	self.__port       = nil
end

-- Overridable Methods -----------------------------------------------------------------------------

-- IpPacket packet
function Socket:sendRaw(packet)
	local route = network.routes:resolve(packet:destinationUuid())
	if not self.__isOpen then
		self:open(route.interface)
	end
	packet:setSourceUuid(route.interface:modem().address)
	packet:setSourcePort(self.__port)
	route.interface:sendRaw(route.destination, packet:destinationPort(), packet)
end

function Socket:receive()
	if self.__isOpen then
		return network.manager:read(self.__port, self.__blocking, self.__timeout)
	end
end

-- Mutators ----------------------------------------------------------------------------------------

function Socket:setBlocking(blocking)
	self.__blocking = blocking
end

function Socket:setTimeout(timeout)
	self.__timeout = timeout
end

-- Module Export -----------------------------------------------------------------------------------

return Socket
