dofile("utils.lua")

local input = GetInput("day6/input.txt")

input = TableOfTables(input)

local function find_guard(map)
	local pos_i, pos_j = -1, -1
	local direction = nil
	for i, row in ipairs(map) do
		for j, col in ipairs(row) do
			if col == "v" or col == "^" or col == ">" or col == "<" then
				pos_i, pos_j = i, j
				direction = col
				break
			end
		end
	end
	return pos_i, pos_j, direction
end

local function is_pos_in_visited(position, visited)
	for _, pos in pairs(visited) do
		if (pos.i == position.i) and (pos.j == position.j) then
			return true
		end
	end
	return false
end

local function is_visited_barrier(position, barrier_hits)
	for _, pos in pairs(barrier_hits) do
		if (pos.i == position.i) and (pos.j == position.j) and (pos.direction == position.direction) then
			return true
		end
	end
	return false
end

local function calculate_path(map)
	local visited = {}
	local barrier_hits = {}
	local next_turn = { ["^"] = ">", [">"] = "v", ["v"] = "<", ["<"] = "^" }
	local pos_i, pos_j, direction = find_guard(map)
	while pos_i > 0 and pos_i < #map + 1 and pos_j > 0 and pos_j < #map[1] + 1 do
		local current_pos = { i = pos_i, j = pos_j }
		if direction == "^" then
			if pos_i - 1 < 1 then
				table.insert(visited, current_pos)
				break
			elseif map[pos_i - 1][pos_j] == "#" then
				if is_visited_barrier({ i = pos_i - 1, j = pos_j, direction = direction }, barrier_hits) then
					return -1
				end
				table.insert(barrier_hits, { i = pos_i - 1, j = pos_j, direction = direction })
				direction = next_turn[direction]
			else
				pos_i = pos_i - 1
				if not is_pos_in_visited(current_pos, visited) then
					table.insert(visited, current_pos)
				end
			end
		elseif direction == ">" then
			if pos_j + 1 > #map[1] then
				table.insert(visited, current_pos)
				break
			elseif map[pos_i][pos_j + 1] == "#" then
				if is_visited_barrier({ i = pos_i, j = pos_j + 1, direction = direction }, barrier_hits) then
					return -1
				end
				table.insert(barrier_hits, { i = pos_i, j = pos_j + 1, direction = direction })
				direction = next_turn[direction]
			else
				pos_j = pos_j + 1
				if not is_pos_in_visited(current_pos, visited) then
					table.insert(visited, current_pos)
				end
			end
		elseif direction == "v" then
			if pos_i + 1 > #map then
				table.insert(visited, current_pos)
				break
			elseif map[pos_i + 1][pos_j] == "#" then
				if is_visited_barrier({ i = pos_i + 1, j = pos_j, direction = direction }, barrier_hits) then
					return -1
				end
				table.insert(barrier_hits, { i = pos_i + 1, j = pos_j, direction = direction })
				direction = next_turn[direction]
			else
				pos_i = pos_i + 1
				if not is_pos_in_visited(current_pos, visited) then
					table.insert(visited, current_pos)
				end
			end
		elseif direction == "<" then
			if pos_j - 1 < 1 then
				table.insert(visited, current_pos)
				break
			elseif map[pos_i][pos_j - 1] == "#" then
				if is_visited_barrier({ i = pos_i, j = pos_j - 1, direction = direction }, barrier_hits) then
					return -1
				end
				table.insert(barrier_hits, { i = pos_i, j = pos_j - 1, direction = direction })
				direction = next_turn[direction]
			else
				pos_j = pos_j - 1
				if not is_pos_in_visited(current_pos, visited) then
					table.insert(visited, current_pos)
				end
			end
		end
	end
	return visited
end

local path_of_visited = calculate_path(input)

print("Part 1:")
print(#path_of_visited)

local function calculate_loops(map, visited)
	local total_loops = 0
	for _, point in ipairs(visited) do
		if map[point.i][point.j] == "." then
			map[point.i][point.j] = "#"
			local path = calculate_path(map)
			if path == -1 then
				total_loops = total_loops + 1
			else
			end
			map[point.i][point.j] = "."
		end
	end

	return total_loops
end

print("Part 2:")
print(calculate_loops(input, path_of_visited))
