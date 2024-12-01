function GetInput(filename)
	local lines = {}
	for line in io.lines(filename) do
		table.insert(lines, line)
	end
	return lines
end
