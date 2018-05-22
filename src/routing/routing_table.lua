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
	table.insert(self.__routes, route)
end

function RoutingTable:list()
	return self.__routes
end

function RoutingTable:resolve(address)
	-- This is really not the best way to handle this.
	-- Really it should be using something like a trie
	-- to search through, but this works for now...
	local bestRoute = nil
	for i, route in pairs(self.__routes) do
		if route:matches(address) then
			if bestRoute == nil or route.prefixLength > bestRoute.prefixLength then
				bestRoute = route
			end
		end
	end
	if bestRoute and bestRoute.gateway then
		return self:resolve(bestRoute.gateway)
	end
	return bestRoute
end

-- Module Export -----------------------------------------------------------------------------------

return RoutingTable
