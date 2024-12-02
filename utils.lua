function GetInput(filename)
	local lines = {}
	for line in io.lines(filename) do
		table.insert(lines, line)
	end
	return lines
end

function SplitNumbs(line)
	local numbs = {}
	for i in string.gmatch(line, "%S+") do
		table.insert(numbs, i)
	end
	return numbs
end
