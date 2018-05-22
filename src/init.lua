local component         = require("component")
local LanInterface      = require("network/interfaces/lan_interface")
local LoopbackInterface = require("network/interfaces/loopback_interface")
local RoutingTable      = require("network/routing/routing_table")
local netutils          = require("network/netutils")

local network = {
	interfaces = {},
	routes     = RoutingTable(),
	utils      = netutils
}

function network.updateInterfaces()
	interfaces = {}
	local wlanCount, ethCount = 0, 0
	for addr in component.list("modem") do
		local modem = component.proxy(addr)
		local name
		if modem.isWireless() then
			name = "wlan" .. tostring(wlanCount)
			wlanCount = wlanCount + 1
		else
			name = "eth" .. tostring(ethCount)
			ethCount = ethCount + 1
		end
		interfaces[name] = LanInterface(name, modem)
	end

	-- Loopback Interface

	local loopback = LoopbackInterface("lo")
	loopback:setIpAddress(0x7f000001)
	loopback:setMask(0xff000000)
	interfaces["lo"] = loopback

	network.interfaces = interfaces
end

return network
