local computer = require("computer")
local Route    = require("network/routing/route")

RoutingTable = {
	__routes  = {}
}
RoutingTable.__index = RoutingTable

setmetatable(RoutingTable, {
	__call = function(cls, ...)
		local self = setmetatable({}, cls)
		self:constructor(...)
		return self
	end
})

function RoutingTable:constructor()
	--
end

-- Methods -----------------------------------------------------------------------------------------

function RoutingTable:add(route)
	self.__routes[route.destination or "default"] = route
end

function RoutingTable:list()
	return self.__routes
end

function RoutingTable:resolve(address)
	local route = self.__routes[address] or self.__routes["default"]
	if route.gateway then
		return self:resolve(route.gateway)
	end
	return route
end

-- Module Export -----------------------------------------------------------------------------------

return RoutingTable
