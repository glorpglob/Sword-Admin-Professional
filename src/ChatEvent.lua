game.Players.PlayerAdded:Connect(function(Player)
	Player.Chatted:Connect(function(Message)
		if Message == ";open" then 
			game.ReplicatedStorage.Events_SAP.User.OpenTerminal:FireClient(Player)
		end
	end)
end)
