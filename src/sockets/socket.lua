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
	self.__isOpen     = false
	self.__isFinished = true
	network.manager:close(port)
end

-- Overridable Methods -----------------------------------------------------------------------------

function Socket:send()

end

function Socket:receive()
	if self.__isOpen then
		return network.manager:read(self.__port)
	end
end

-- Module Export -----------------------------------------------------------------------------------

return Socket
