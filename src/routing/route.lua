local netutils = require("network/netutils")

Route = {
	destination = nil,
	gateway     = nil,
	mask        = nil,
	metric      = nil,
	interface   = nil
}
Route.__index = Route

setmetatable(Route, {
	__call = function(cls, ...)
		local self = setmetatable({}, cls)
		self:constructor(...)
		return self
	end
})

function Route:constructor(destination, gateway, mask, metric, interface)
	self.destination  = destination
	self.gateway      = gateway
	self.mask         = mask
	self.metric       = metric
	self.interface    = interface
	self.prefixLength = netutils.prefixLength(mask)
end

-- Methods -----------------------------------------------------------------------------------------

function Route:matches(address)
	return (address & self.mask) == self.destination
end

-- Module Export -----------------------------------------------------------------------------------

return Route
