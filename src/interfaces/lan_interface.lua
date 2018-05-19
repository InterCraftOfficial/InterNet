local component = require("component")
local Interface = require("network/interfaces/interface")
local modem     = component.modem

-- LanInterface Class ------------------------------------------------------------------------------

LanInterface = Interface:new{}

function LanInterface:new(name, modem)
	o = {}
	setmetatable(o, self)
	self.__index          = self
	self.__name           = name
	self.__modem          = modem
	self.__ipAddress      = nil
	self.__mask           = 0x0
	self.__defaultGateway = nil
	self.__address        = nil
	return o
end

-- Methods -----------------------------------------------------------------------------------------

function send(packet)

end

function sendTo(address, packet)

end

function receive()

end

-- Accessors ---------------------------------------------------------------------------------------

function address()
	return self.__address
end

function defaultGateway()
	return self.__defaultGateway
end

function ipAddress()
	return self.__ipAddress
end

function modem()
	return self.__modem
end

function mask()
	return self.__mask
end

-- Mutators ----------------------------------------------------------------------------------------

function setAddress(address)
	self.__address = address
end

function setDefaultGateway(defaultGateway)
	self.__defaultGateway = defaultGateway
end

function setIpAddress(ipAddress)
	self.__ipAddress = ipAddress
end

function setModem(modem)
	self.__modem = modem
end

function setMask(mask)
	self.__mask = mask
end

-- Module Export -----------------------------------------------------------------------------------

return Interface

