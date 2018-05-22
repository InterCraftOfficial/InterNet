function string.at(str, i)
	return string.sub(str,i,i)
end

return {
	ipToString = function(ipAddress)
		if ipAddress then
			return string.format("%d.%d.%d.%d",
				ipAddress  >> 24,
				(ipAddress >> 16) & 0xff,
				(ipAddress >> 8)  & 0xff,
				ipAddress         & 0xff
			)
		else
			return "nil"
		end
	end,

	prefixLength = function(mask)
		return 32 - math.log((~mask & 0xffffffff) + 1, 2)
	end,

	ipFromString = function(ipAddress)
		ipAddress = ipAddress .. '.'
		local address = 0
		local part  = 0
		local parts = 0
		for i = 1, #ipAddress do
			local char = string.at(ipAddress, i)
			if char == '.' then
				parts = parts + 1
				assert(part >= 0 and part < 256 and parts < 5, "Invalid IP Address Given")
				address = (address << 8) + part
				part = 0
			else
				part = part * 10 + tonumber(char)
			end
		end
		return address
	end
}
