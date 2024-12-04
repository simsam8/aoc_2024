function GetInput(filename)
	local lines = {}
	for line in io.lines(filename) do
		table.insert(lines, line)
	end
	return lines
end

function TableOfTables(lines)
	local tables = {}
	for _, line in pairs(lines) do
		local t = {}
		for c in string.gmatch(line, ".") do
			table.insert(t, c)
		end
		table.insert(tables, t)
	end
	return tables
end

function SplitNumbs(line)
	local numbs = {}
	for i in string.gmatch(line, "%S+") do
		table.insert(numbs, i)
	end
	return numbs
end
