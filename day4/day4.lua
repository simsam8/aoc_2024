dofile("utils.lua")

local input = GetInput("day4/input.txt")

input = TableOfTables(input)

local function find_xmas(lines, i, j, direction, visited, last_letter)
  -- Valid previous 'nodes'
	local prev = {}
	prev["M"] = "X"
	prev["A"] = "M"
	prev["S"] = "A"

	-- Bounds check
	if i < 1 or j < 1 or i > #lines or j > #lines[1] then
		return 0
	end

	visited = visited or {}
	if visited[i .. "," .. j] then
		return 0
	end

	-- Visit current cell
	visited[i .. "," .. j] = true

	local current = lines[i][j]
	if prev[current] ~= last_letter then
		return 0
	elseif prev[current] == "A" then
		return 1
	end

	if direction then
		local di, dj = table.unpack(direction)
		return find_xmas(lines, i + di, j + dj, direction, visited, current)
	end

	local directions = {
		{ -1, -1 },
		{ -1, 0 },
		{ -1, 1 },
		{ 0, -1 },
		{ 0, 1 },
		{ 1, -1 },
		{ 1, 0 },
		{ 1, 1 },
	}

	local count = 0
	-- Check all directions if no current direction
	for _, dir in ipairs(directions) do
		count = count + find_xmas(lines, i + dir[1], j + dir[2], dir, visited, current)
	end

	return count
end

function CountXmas(lines)
	local count = 0
	for i = 1, #lines, 1 do
		for j = 1, #lines[1], 1 do
			if lines[i][j] == "X" then
				count = count + find_xmas(lines, i, j, nil, nil)
			end
		end
	end
	return count
end

print("Part 1:")
print(CountXmas(input))

local function find_x_mas(lines, i, j)
	if i < 2 or j < 2 or i > #lines - 1 or j > #lines[1] - 1 then
		return 0
	end

	if
		lines[i - 1][j - 1] == "M"
		and lines[i - 1][j + 1] == "S"
		and lines[i + 1][j - 1] == "M"
		and lines[i + 1][j + 1] == "S"
	then
		return 1
	elseif
		lines[i - 1][j - 1] == "M"
		and lines[i - 1][j + 1] == "M"
		and lines[i + 1][j - 1] == "S"
		and lines[i + 1][j + 1] == "S"
	then
		return 1
	elseif
		lines[i - 1][j - 1] == "S"
		and lines[i - 1][j + 1] == "S"
		and lines[i + 1][j - 1] == "M"
		and lines[i + 1][j + 1] == "M"
	then
		return 1
	elseif
		lines[i - 1][j - 1] == "S"
		and lines[i - 1][j + 1] == "M"
		and lines[i + 1][j - 1] == "S"
		and lines[i + 1][j + 1] == "M"
	then
		return 1
  else
    return 0
	end
end

function CountX_mas(lines)
	local count = 0
	for i = 1, #lines, 1 do
		for j = 1, #lines[1], 1 do
			if lines[i][j] == "A" then
				count = count + find_x_mas(lines, i, j)
			end
		end
	end
	return count
end

print("Part 2:")
print(CountX_mas(input))
