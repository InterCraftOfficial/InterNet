
Interface = {
	__name  = nil,
	__state = nil
}

function Interface:new(name)
	o = {}
	setmetatable(o, self)
	self.__index = self
	self.__name  = name
	return o
end

-- Methods -----------------------------------------------------------------------------------------

	--

-- Overridable Methods -----------------------------------------------------------------------------

function send()
	--
end

function receive()
	--
end

-- Accessors ---------------------------------------------------------------------------------------

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
