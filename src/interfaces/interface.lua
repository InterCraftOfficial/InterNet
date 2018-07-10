
Interface = {
	__name  = nil,
	__state = nil
}
Interface.__index = Interface

setmetatable(Interface, {
	__call = function(cls, ...)
		local self = setmetatable({}, cls)
		self:constructor(...)
		return self
	end
})

function Interface:constructor(name)
	self.__name = name
	print(self)
end

-- Methods -----------------------------------------------------------------------------------------



-- Overridable Methods -----------------------------------------------------------------------------

function send()
	--
end

function receive()
	--
end

-- Accessors ---------------------------------------------------------------------------------------

function address()
	return nil
end

function Interface:name()
	return self.__name
end

function Interface:state()
	return self.__state
end

-- Mutators ----------------------------------------------------------------------------------------

function Interface:setName(name)
	self.__name = name
end

function Interface:setState(state)
	self.__state = state
end

-- Module Export -----------------------------------------------------------------------------------

return Interface
