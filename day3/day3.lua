local file = assert(io.open("day3/input.txt", "r"))
local input = file:read("*a")
file:close()

function ParseAndMultiply(text)
	local total = 0
	local pattern = "mul%(%d+,%d+%)"
	local get_match = string.gmatch(text, pattern)
	while true do
		local mult = get_match()
		if mult == nil then
			break
		end

		local i1, j1 = string.find(mult, "%d+")
		local num1 = tonumber(string.sub(mult, i1, j1))

		local i2, j2 = string.find(mult, "%d+", j1 + 1)
		local num2 = tonumber(string.sub(mult, i2, j2))

		total = total + num1 * num2
	end

	print(total)
end

print("Part 1")
ParseAndMultiply(input)


local function min_index(t)
	local key, min = 1, t[1]
	for k, v in ipairs(t) do
		if t[k] < min then
			key, min = k, v
		end
	end
	return key, min
end

function ParseAndMultiplyConditional(text)
	local total = 0
	local enable_mul = true
	while true do
		local _, j_do = string.find(text, "do%(%)")
		local _, j_dont = string.find(text, "don't%(%)")
		local i_mul, j_mul = string.find(text, "mul%(%d+,%d+%)")

		if i_mul == nil then
			break
		end

		local low_idx, text_idx_new_start = min_index({ j_do or math.huge, j_dont or math.huge, j_mul or math.huge })

		if low_idx == 1 then
			enable_mul = true
		elseif low_idx == 2 then
			enable_mul = false
		elseif low_idx == 3 then
			if enable_mul then
				local mult = string.sub(text, i_mul, j_mul)

				local i1, j1 = string.find(mult, "%d+")
				local num1 = tonumber(string.sub(mult, i1, j1))

				local i2, j2 = string.find(mult, "%d+", j1 + 1)
				local num2 = tonumber(string.sub(mult, i2, j2))

				total = total + num1 * num2
			end
		end
		if text_idx_new_start == nil then
			break
		end

		text = string.sub(text, text_idx_new_start + 1)
	end

	print(total)
end

print("Part 2")
ParseAndMultiplyConditional(input)
