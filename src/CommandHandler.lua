local Parser = require(script.Parent.Parser)
local Data = require(script.Parent.Data)

local function get_conditions(Player, subject)
	return {
		(Player.Name == subject) or (subject == "me") or (subject == nil),
		subject == "all",
		subject == "others"
	}
end


local function exec(Player, subject, code)	
	local conditions = get_conditions(Player, subject)

	if conditions[1] then 
		code(Player)
	elseif conditions[2] then
		for _, plr in pairs(game.Players:GetPlayers()) do
			code(plr)
		end
	elseif conditions[3] then
		for _, plr in pairs(game.Players:GetPlayers()) do
			if plr ~= Player then
				code(plr)
			end
		end
	else
		for _, plr in pairs(game.Players:GetPlayers()) do
			if subject == plr.Name:sub(1,#subject):lower() then
				code(plr)
				break
			end
		end
	end
end


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
		},
		["arginfo"] = "'output'"
	}, 
	["clear"] = {
		function(Player, args) 
			game.ReplicatedStorage.Events_SAP.User.ClearTerminal:FireClient(Player)
		end,
		["args"] = {
			function(command) end,
			function(command) end,
			function(command) end,
		},
		["arginfo"] = "no_args"
	}, 
	["help"] = {
		function(Player, args)
			local output = ""
			local i = 0
			for v, j in pairs (Commands) do 
				i += 1
				output ..= i .. ". " .. v .." " .. j["arginfo"] .."\n"
			end
			return output
		end,
		["args"] = {
			function(command) end,
			function(command) end,
			function(command) end,
		},
		["arginfo"] = "no_args"
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
		},
		["arginfo"] = "'code'"
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
		},
		["arginfo"] = "userid"
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
		},
		["arginfo"] = "userid"
	},
	["tp_to_place"] = {
		function(Player, args) 
			exec(Player, args[1], function(player)
				game:GetService("TeleportService"):Teleport(tonumber(args[2]), player)
			end)
			
			return "Success"
		end,
		["args"] = {
			function(command) return string.split(command, " ")[2] end,
			function(command) return string.split(command, " ")[3] end,
			function(command) end,
		},
		["arginfo"] = "player id"
	},
	
}

return Commands
