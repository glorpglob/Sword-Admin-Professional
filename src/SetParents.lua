script.Parent.Name = "SAP"
script.Parent.Parent = game.ServerScriptService
script.Parent.Events_SAP.Parent = game.ReplicatedStorage
script.Parent.SAP_Terminal.Parent = game.StarterGui

game.Players.PlayerAdded:Connect(function(Player) 
	--script.Parent.SAP_Terminal:Clone().Parent = Player.
end)
