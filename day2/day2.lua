dofile("utils.lua")

Input = GetInput("day2/input.txt")

local function report_is_safe(report, dampening, recurse)
	if recurse then
		levels = report
	else
		levels = SplitNumbs(report)
	end

	local prev = nil
	local increasing = false
	local decreasing = false
	local is_safe = true

	for i, level in pairs(levels) do
		level = tonumber(level)
		if i == 1 then
			prev = level
		end
		if i == 2 then
			if level > prev then
				increasing = true
			elseif level < prev then
				decreasing = true
			end
		end
		if i > 1 then
			if increasing and (level < prev) then
				-- print("not strictly increasing: ", prev, level)
				is_safe = false
				break
			end

			if decreasing and level > prev then
				-- print("not strictly decreasing", prev, level)
				is_safe = false
				break
			end

			if math.abs(level - prev) < 1 or math.abs(level - prev) > 3 then
				-- print("gap too big: ", prev, level)
				is_safe = false
				break
			end

			prev = level
		end
	end

	if dampening then
		local reports_minus_1 = {}
		for i = 1, #levels, 1 do
			local sub_report = {}
			for j, level in pairs(levels) do
				if j ~= i then
					table.insert(sub_report, level)
				end
			end
			table.insert(reports_minus_1, sub_report)
		end

		local final_state = false
		for _, sub_report in pairs(reports_minus_1) do
			if report_is_safe(sub_report, false, true) then
				final_state = true
			end
		end
		return final_state
	else
		return is_safe
	end
end

local function count_safe_reports(dampening)
	local safe_reports = 0
	for _, report in pairs(Input) do
		if report_is_safe(report, dampening, false) then
			safe_reports = safe_reports + 1
		end
	end
	return safe_reports
end

print(count_safe_reports(true))
