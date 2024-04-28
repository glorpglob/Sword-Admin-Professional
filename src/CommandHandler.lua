local Parser = require(script.Parent.Parser)
local Data = require(script.Parent.Data)



Commands = { 
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
			local output = ""
			local i = 0
			for v in pairs (Commands) do 
				i += 1
				output ..= i .. ". " .. v .."\n"
			end
			return output
		end,
		["args"] = {
			function(command) end,
			function(command) end,
			function(command) end,
		}
	},  
	["lua"] = {
		function(Player, args) 
			local output = loadstring(args[1])()
			return "Code ran, check developer logs (f9)"
		end,
		["args"] = {
			function(command) return Parser.find_in_bounds(command, "'") end,
			function(command) end,
			function(command) end,
		}
	},  
	["rank1"] = {
		function(Player, args) 
			if not tonumber(args[1]) then 
				return "Must be a user id"
			end
			table.insert(Data.RankScores.Rank1.Admins, tonumber(args[1]))
			return "Success"
		end,
		["args"] = {
			function(command) return string.split(command, " ")[2] end,
			function(command) end,
			function(command) end,
		}
	},  
	["rank2"] = {
		function(Player, args) 
			if not tonumber(args[1]) then 
				return "Must be a user id"
			end
			table.insert(Data.RankScores.Rank2.Admins, tonumber(args[1]))
			return "Success"
		end,
		["args"] = {
			function(command) return string.split(command, " ")[2] end,
			function(command) end,
			function(command) end,
		}
	}
	
}

return Commands
