-- A utility to manage sockets on the system

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
	local addr   = packet[1]
	local port   = packet[3]
	local socket = netmanager.__netbuffer[addr][port]
	-- pcall(socket.writeToBuffer, socket, packet)
	socket:writeToBuffer(packet)
end

function netmanager:open(interface, port, socket)
	assert(not self:isOpen(interface, port))
	local addr = interface:address()
	if self.__netbuffer[addr] == nil then
		self.__netbuffer[addr] = {}
	end
	if interface:open(port) then
		self.__netbuffer[addr][port] = socket
		return true
	end
	return false
end

function netmanager:close(interface, port)
	interface:close(port)
	self.__netbuffer[interface:address()][port] = nil
end

function netmanager:isOpen(interface, port)
	local addr = interface:address()
	return self.__netbuffer[addr] and self.__netbuffer[addr][port]
end

-- May move back into socket class... We'll see
function netmanager:waitForPacket(interface, port, timeout)
	local addr   = interface:address()
	local start  = computer.uptime()
	local packet = nil
	repeat
		packet = {event.pull((timeout or 1) - (computer.uptime() - start), "modem_message")}
	until packet == nil
		  or (timeout and computer.uptime() - start >= timeout)
		  or (packet[2] == addr and packet[4] == port)
end

return netmanager
