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

-- Overridable Methods -----------------------------------------------------------------------------

function Socket:send()

end

-- Module Export -----------------------------------------------------------------------------------

return Socket
