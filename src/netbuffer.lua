local netbuffer = {
	__buffer = {}
}

function netbuffer:open(port)
	assert(not self:isOpen(port))
	self.__buffer[port] = {}
end

function netbuffer:close(port)
	self.__buffer[port] = nil
end

function netbuffer:push(port, packet)
	table.insert(self.__buffer[port], packet)
end

function netbuffer:pull(port)
	return table.remove(self.__buffer[port], 1)
end

function netbuffer:isOpen(port)
	return self.__buffer[port] ~= nil
end

return netbuffer
