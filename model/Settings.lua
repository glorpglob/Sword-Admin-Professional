return { 
	Terminal = true, -- use true for default, or insert your own custom MainModule ID to insert your own UI  
	
	Ranks = { 
		["Rank0"] = {  -- rank 0 | full permissions
			Admins = { 
				182139900, -- player id
				1,
				1,
			},
		},	
		["Rank1"] = {  -- rank 1 | limited permissions
			Admins = { 
				1,
				1,
				1,
			},
			Commands = {"rank2", "lua", "print"}
		},	
		["Rank2"] = { -- rank 2 | limited permissions
			Admins = { 
				1,
				1,
				1,
			},
			Commands = {"print"}
		},	
	},
	
	FreeCommands = {"clear", "help"}, -- commands anyone can use 
	
	DefaultAdmin = false, -- are users admin by default?
	
	BannedGroups = { -- groups who cannot join
		1, -- group id 
		1, 
		1,
	},
	
	MinimumAccountAge = 0, -- minimum account age to join 
	
	Enabled = true, -- Sword Admin Commands toggle
}
