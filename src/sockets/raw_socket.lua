local network   = require("network")
local netutils  = require("network/netutils")

RawSocket = {
	__port       = nil,
	__blocking   = true,
	__timeout    = nil,
	__interface  = nil,
	__isOpen     = false,
	__isFinished = false
}
RawSocket.__index = RawSocket

setmetatable(RawSocket, {
	__call = function(cls, ...)
		local self = setmetatable({}, cls)
		self:constructor(...)
		return self
	end
})

function RawSocket:constructor()

end

-- Methods -----------------------------------------------------------------------------------------

function RawSocket:bind(interface, port)
	self:open(interface, port)
end

function RawSocket:open(interface, port)
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

function RawSocket:close()
	assert(self.__isOpen)
	network.manager:close(self.__port)
	self.__isOpen     = false
	self.__isFinished = true
	self.__port       = nil
end

-- Overridable Methods -----------------------------------------------------------------------------

function RawSocket:send(interface, destination, port, packet)
	interface:sendRaw(destination, port, packet)
end

function RawSocket:receive()
	if self.__isOpen then
		return network.manager:read(self.__port, self.__blocking, self.__timeout)
	end
end

-- Accessors ---------------------------------------------------------------------------------------

function RawSocket:isBlocking()
	return self.__blocking
end

function RawSocket:timeout()
	return self.__timeout
end

function RawSocket:isFinished()
	return self.__isFinished
end

function RawSocket:isOpen()
	return self.__isOpen
end

function RawSocket:port()
	return self.__port
end

-- Mutators ----------------------------------------------------------------------------------------

function RawSocket:setBlocking(blocking)
	self.__blocking = blocking
end

function RawSocket:setTimeout(timeout)
	self.__timeout = timeout
end

-- Module Export -----------------------------------------------------------------------------------

return RawSocket
