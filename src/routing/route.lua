local netutils = require("network/netutils")

Route = {
	destination = nil,
	gateway     = nil,
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

function Route:constructor(destination, gateway, metric, interface)
	self.destination  = destination
	self.gateway      = gateway
	self.metric       = metric
	self.interface    = interface
end

-- Module Export -----------------------------------------------------------------------------------

return Route
