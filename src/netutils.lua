function string.at(str, i)
	return string.sub(str,i,i)
end

return {
	randomPort = function()
		return math.floor(math.random() * (65535 - 1000)) + 1
	end
}
