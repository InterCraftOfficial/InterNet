local netbuffer = require("network/netbuffer")
local netutils  = require("network/netutils")

Socket = {
	__port       = nil,
	__blocking   = true,
	__timeout    = nil,
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

function Socket:bind(port)
	self:open(port)
end

function Socket:open(port)
	assert(not self.__isFinished)
	if port == nil then
		port = netutils.randomPort()
		while netbuffer:isOpen(port) do
			port = netutils.randomPort()
		end
	end
	netbuffer:open(port)
	self.__port   = port
	self.__isOpen = true
end

function Socket:close()
	assert(self.__isOpen)
	self.__isOpen     = false
	self.__isFinished = true
	netbuffer:close(port)
end

-- Overridable Methods -----------------------------------------------------------------------------

function Socket:send()

end

-- Module Export -----------------------------------------------------------------------------------

return Socket
