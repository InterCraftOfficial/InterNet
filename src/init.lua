local component         = require("component")
local event             = require("event")
local LanInterface      = require("network/interfaces/lan_interface")
local LoopbackInterface = require("network/interfaces/loopback_interface")
local RoutingTable      = require("network/routing/routing_table")
local netmanager        = require("network/netmanager")
local netutils          = require("network/netutils")

local network = {
	interfaces = {},
	manager    = netmanager,
	routes     = RoutingTable(),
	utils      = netutils
}

function network.init()
	network.updateInterfaces()
	network.manager:enable()
end

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
	interfaces["lo"] = loopback

	network.interfaces = interfaces
end

function network.defaultInterface()
	return interfaces["eth0"] or interfaces["wlan0"] or interfaces["lo"]
end

return network
