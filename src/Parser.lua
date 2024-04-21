return { 
	find_in_bounds = function(str, match)
		if string.find(str, match) == nil then return str end
		local _str = str:sub(string.find(str, match) + match:len(), str:len())
		local _str = _str:sub(1, string.find(_str, match) - match:len())
		return _str
	end,

	get_command = function(str)
		return string.split(str, " ")[1]:sub(1, str:len()) or str:sub(1, str:len())
	end,

	array_as_string = function(arr)
		local str = ""
		for _, v in pairs (arr) do
			str ..= "\n" .. tostring(v) 	
		end
		return str
	end,
}
