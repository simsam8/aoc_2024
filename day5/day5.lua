local function get_input(filename)
	local ordering_rules = {}
	local page_numbers = {}
	local is_halfway = false
	for line in io.lines(filename) do
		if line == "" then
			is_halfway = true
		end
		if line ~= "" and not is_halfway then
			table.insert(ordering_rules, line)
		elseif line ~= "" and is_halfway then
			table.insert(page_numbers, line)
		end
	end
	return ordering_rules, page_numbers
end

function TableOfTables(lines, separator)
	local tables = {}
	for _, line in pairs(lines) do
		local t = {}
		for c in string.gmatch(line, separator) do
			table.insert(t, c)
		end
		table.insert(tables, t)
	end
	return tables
end

local rules, page_numbers = get_input("day5/input.txt")

rules = TableOfTables(rules, "([^|]+)")
page_numbers = TableOfTables(page_numbers, "([^,]+)")

local function verify_single_rule(start_idx, rule, page_numbs)
	for j = start_idx, 1, -1 do
		if page_numbs[j] == rule[2] then
			return false
		end
	end
	return true
end

local function verify_order(page_numbs)
	for i, numb in ipairs(page_numbs) do
		for _, rule in pairs(rules) do
			if numb == rule[1] then
				local is_correct = verify_single_rule(i, rule, page_numbs)

				if not is_correct then
					return false, nil
				end
			end
		end
	end
	return true, page_numbs[(#page_numbs // 2) + 1]
end

local function get_middle_sum(verifier)
	local middle_sum = 0
	for _, page_numbs in pairs(page_numbers) do
		local is_ordered, middle_val = verifier(page_numbs)
		if is_ordered then
			middle_sum = middle_sum + middle_val
		end
	end
	return middle_sum
end

print("Part 1:")
print(get_middle_sum(verify_order))

local function sort_til_correct(page_numbs)
	local is_correct_order = false
	local is_corrected = false
	while not is_correct_order do
		for _, rule in pairs(rules) do
			for i = 1, #page_numbs, 1 do
				if page_numbs[i] == rule[1] then
					for j = i, 1, -1 do
						if page_numbs[j] == rule[2] then
							is_corrected = true
							page_numbs[i], page_numbs[j] = page_numbs[j], page_numbs[i]
							break
						end
					end
				end
			end
		end
		is_correct_order, _ = verify_order(page_numbs)
	end

	return is_corrected
end

local function middle_sum_on_corrected()
	local middle_sums = 0
	for _, page_numbs in pairs(page_numbers) do
		local is_corrected = sort_til_correct(page_numbs)
		if is_corrected then
			middle_sums = middle_sums + page_numbs[(#page_numbs // 2) + 1]
		end
	end
	return middle_sums
end

print("Part 2:")
print(middle_sum_on_corrected())
