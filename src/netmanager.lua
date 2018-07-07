local computer = require("computer")
local event    = require("event")

local netmanager = {
	__netbuffer = {}
}

function netmanager:enable()
	event.listen("modem_message", self.onReceive)
end

function netmanager:disable()
	event.ignore("modem_message", self.onReceive)
end

function netmanager.onReceive(eventName, ...)
	local packet = {...}
	local port   = packet[3]
	if netmanager:isOpen(port) then
		netmanager:write(port, packet)
	end
end

function netmanager:open(interface, port)
	assert(not self:isOpen(port))
	interface:open(port)
	self.__netbuffer[port] = {
		interface = interface,
		queue     = {}
	}
end

function netmanager:close(port)
	self.__netbuffer[port].interface:close(port)
	self.__netbuffer[port] = nil
end

function netmanager:write(port, packet)
	table.insert(self.__netbuffer[port].queue, packet)
end

function netmanager:read(port, blocking, timeout)
	if #self.__netbuffer[port].queue > 0 then
		return table.remove(self.__netbuffer[port].queue, 1)
	elseif blocking then
		local start = computer.uptime()
		repeat
			local packet = nil
			if timeout then
				packet = {event.pull(timeout - (computer.uptime() - start), "modem_message")}
			else
				packet = {event.pull("modem_message")}
			end
		until packet == nil or (timeout and computer.uptime() - start >= timeout) or packet[4] == port
		return table.remove(self.__netbuffer[port].queue, 1)
	end
	return nil
end

function netmanager:isOpen(port)
	return self.__netbuffer[port] ~= nil
end

return netmanager
