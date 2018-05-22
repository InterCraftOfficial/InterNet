IpSocket = {
	__port       = nil,
	__blocking   = true,
	__timeout    = nil,
	__isOpen     = false,
	__isFinished = false
}
IpSocket.__index = IpSocket

setmetatable(IpSocket, {
	__call = function(cls, ...)
		local self = setmetatable({}, cls)
		self:constructor(...)
		return self
	end
})

function IpSocket:constructor()

end

-- Overridable Methods -----------------------------------------------------------------------------

function IpSocket:send()

end

-- Module Export -----------------------------------------------------------------------------------

return IpSocket
