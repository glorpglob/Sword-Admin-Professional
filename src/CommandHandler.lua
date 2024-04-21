local Parser = require(script.Parent.Parser)


return  { 
	["print"] = {
		function(Player, args) 
			print(args[1])
			return args[1]
		end,
		["args"] = {
			function(command) return Parser.find_in_bounds(command, "'") end,
			function(command) end,
			function(command) end,
		}
	}, 
	["clear"] = {
		function(Player, args) 
			game.ReplicatedStorage.Events_SAP.User.ClearTerminal:FireClient(Player)
		end,
		["args"] = {
			function(command) end,
			function(command) end,
			function(command) end,
		}
	}, 
	["help"] = {
		function(Player, args) 
			game.ReplicatedStorage.Events_SAP.User.DirectOutput:FireClient(Player, [[
			1. print 'input'
			2. clear
			3. help
			]])
		end,
		["args"] = {
			function(command) end,
			function(command) end,
			function(command) end,
		}
	}, 
	
}
