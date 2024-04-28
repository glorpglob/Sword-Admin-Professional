local Parser = require(script.Parent.Parser)
local DataStoreService = game:GetService("DataStoreService")
local Settings = require(game.Workspace["Sword_Admin-Professional"].Settings)
local Data = require(script.Parent.Data)

if Settings.Enabled == false then 
	script.Parent:Destroy()
end
if Settings.Terminal ~= true then 
	if game.StarterGui:FindFirstChild("SAP_Terminal") then 
		game.StarterGui.SAP_Terminal:Destroy()
	end
	if script.Parent:FindFirstChild("SAP_Terminal") then 
		script.Parent.SAP_Terminal:Destroy()
	end
	
	require(Settings.Terminal).Parent = game.StarterGui 
end

Data.RankScores = Settings.Ranks
local Success = pcall(function() 
	for i, v in pairs(DataStoreService:GetDataStore("RanksSAP"):GetAsync(1)) do 
		for _, j in pairs(v.Admins) do 
			if not table.find(Data.RankScores[i].Admins, j) then 
				table.insert(Data.RankScores[i].Admins, j)
			end
		end
	end
end) 

local Admin = { 
	CheckRank = function(Player) 
		if table.find(Data.RankScores["Rank0"]["Admins"], Player.UserId) then 
			return 0
		end
		if table.find(Data.RankScores["Rank1"]["Admins"], Player.UserId) then 
			return 1
		end
		if table.find(Data.RankScores["Rank2"]["Admins"], Player.UserId) then 
			return 2
		end
		
		if Settings.DefaultAdmin == true then 
			return 2
		else 
			return -1
		end
	end,
	IsAdmin = function(Rank) 
		return (Rank <= 2) and (Rank >= 0)
	end,
}

game.ReplicatedStorage:WaitForChild("Events_SAP").SendCommand.OnServerInvoke = function(Player, command) 
	local CommandName = Parser.get_command(command) 
	local PlayerRank = Admin.CheckRank(Player)
	local RankLocation = Settings.Ranks["Rank" .. tostring(PlayerRank)]
	if not table.find(Settings.FreeCommands, CommandName) then 
		if (PlayerRank ~= 0) and (not table.find(RankLocation.Commands, CommandName)) then 
			return "You don't have permissions to run this command, or it does not exist."
		end
	end
	
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


local InitialisePlayer = function(Player) 
	if Player.AccountAge < Settings.MinimumAccountAge then 
		Player:Kick("Your account is not old enough. Your account must be at least " .. Settings.MinimumAccountAge .. " days old.")
	end
	for _, v in ipairs(Settings.BannedGroups) do 
		if Player:IsInGroup(v) then 
			Player:Kick("You are not allowed in this game because you are in a banned group.")
		end
	end
end

for _, v in pairs(game.Players:GetPlayers()) do 
	InitialisePlayer(v)
end

game.Players.PlayerAdded:Connect(function(Player)
	InitialisePlayer(Player)
end) 

local saving = false
game.Players.PlayerRemoving:Connect(function(Player)
	saving = true 
	DataStoreService:GetDataStore("RanksSAP"):SetAsync(1, Data.RankScores)
	saving = false 
end)

game:BindToClose(function() 
	if saving == false then 
		DataStoreService:GetDataStore("RanksSAP"):SetAsync(1, Data.RankScores)
	end
end)
