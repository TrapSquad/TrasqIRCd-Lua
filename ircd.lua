-- lua ircd
-- a thing

local set = require("core.set")
local parse = require("core.parse")
local socket = require("socket")

_L = set.newset()

host = host or "*"
port1 = port1 or 17667
port2 = port2 or 17668
if arg then
    host = arg[1] or host
    port1 = arg[2] or port1
    port2 = arg[3] or port2
end

s = {}
s.sock = {}
s.sock.a = assert(socket.bind(host, port1))
s.sock.b = assert(socket.bind(host, port2))
s.peernames = {}
s.sock.a:settimeout(0.01)
s.sock.b:settimeout(0.01)

_L:insert(s.sock.a)
_L:insert(s.sock.b)

while 1 do
	local readable, _, error = socket.select(_L, nil)
	for _, input in ipairs(readable) do
		if input == s.sock.a or input == s.sock.b then
			local n = input:accept()
			if new then
				new:settimeout(0.01)
				_L:insert(new)
			end
		else
			local line, error = input:receive()
			if error then
				input:close()
				_L:remove(input)
			else
				io.write(line.."\n")
				local pfx, cmd, parv = parse.parse(line)
				
			end
		end
	end
end
