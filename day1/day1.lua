dofile("utils.lua")

Input = GetInput("day1/input.txt")

function GetLists()
	local list1 = {}
	local list2 = {}
	for _, numbs in pairs(Input) do
		local n = SplitNumbs(numbs)
		local numb1 = n[1]
		local numb2 = n[2]
		table.insert(list1, numb1)
		table.insert(list2, numb2)
	end
	return list1, list2
end

function TotalDistance()
	local l1, l2 = GetLists()
	table.sort(l1)
	table.sort(l2)
	local total_distance = 0
	for i = 1, #l1, 1 do
		local distance = math.abs(l1[i] - l2[i])
		total_distance = total_distance + distance
	end
	return total_distance
end

print(TotalDistance())

function GetFrequency(number, list)
  local count = 0
  for _, n in pairs(list) do
    if number == n then
      count = count + 1
    end
  end
  return count
end

function SimilarityScore()
  local l1, l2 = GetLists()
  local similarity_table = {}
  local similarity_score = 0
  for _, n in pairs(l1) do
    if similarity_table[n] ~= nil then
      similarity_score = similarity_score + (n*similarity_table[n])
    else
      similarity_table[n] = GetFrequency(n, l2)
      similarity_score = similarity_score + (n*similarity_table[n])
    end
  end
  return similarity_score
end


print(SimilarityScore())
