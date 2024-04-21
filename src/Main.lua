local Parser = require(script.Parent.Parser)



game.ReplicatedStorage:WaitForChild("Events_SAP").SendCommand.OnServerInvoke = function(Player, command) 
	local CommandName = Parser.get_command(command) 
	local output = "invalid"
	
	local Success, Error = pcall(function() 
		local cur = require(script.Parent.CommandHandler)[CommandName]
		output = cur[1](Player, 
			{ 
				cur["args"][1](command),
				cur["args"][2](command),
				cur["args"][3](command)
			}
		)
	end)
	
	if not Success then 
		output = "An error occured: " .. Error
	end
	
	return output
end
