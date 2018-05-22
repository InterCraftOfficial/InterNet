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
	end
}
