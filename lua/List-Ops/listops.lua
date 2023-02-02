-- Implement basic list operations.
-- In functional languages list operations like length, map, and reduce are very common. Implement a series of basic list operations, without using existing functions.
-- The precise number and names of the operations to be implemented will be track dependent to avoid conflicts with existing names, but the general operations you will implement include:
-- * append (given two lists, add all items in the second list to the end of the first list);
-- * concatenate (given a series of lists, combine all items in all lists into one flattened list);
-- * filter (given a predicate and a list, return the list of all items for which predicate(item) is True);
-- * length (given a list, return the total number of items within it);
-- * map (given a function and a list, return the list of the results of applying function(item) on all items);
-- * foldl (given a function, a list, and initial accumulator, fold (reduce) each item into the accumulator from the left using function(accumulator, item));
-- * foldr (given a function, a list, and an initial accumulator, fold (reduce) each item into the accumulator from the right using function(item, accumulator));
-- * reverse (given a list, return a list with all the original items, but in reversed order);

local M = {}

-- Implementing metatable-based class (http://lua-users.org/wiki/ObjectOrientationTutorial)
local List = {}
List.__index = List

-- Enriches the normal table with custom methods and metamethods
function List.new(table, restart_indices)
	-- making sure table indices are 1 based incementing:
	if restart_indices == true and #table ~= 0 then
		local i = 1
		for _, value in ipairs(table) do
			table[i] = value
			i = i + 1
		end
	end

	local self = setmetatable(table, List)

	return self
end

function List.__tostring(self)
	local dst = ""
	for _, value in ipairs(self) do
		dst = dst .. tostring(value) .. ", "
	end
	dst = string.sub(dst, 1, -2)
	return dst
end

function List.__eq(self, list)
	if #self ~= #list then
		return false
	end

	for i, v in ipairs(self) do
		if list[i] ~= v then
			return false
		end
	end
	return true
end

function List.append(self, list)
	for _, v in ipairs(list) do
		table.insert(self, v)
	end
	return self
end

function List.concatenate(self, ...)
	local vargs = { ... }
	for _, list in ipairs(vargs) do
		self:append(list)
	end
	return self
end

function List.filter(self, func)
	for i, v in ipairs(self) do
		if not func(v) then
			table.remove(self, i)
		end
	end
	return self
end

function List.length(self)
	return #self
end
function List.map(self, func)
	for i, v in ipairs(self) do
		self[i] = func(v)
	end
	return self
end

function List.foldl(self, func)
	local dst = self[1]
	for i, _ in ipairs(self) do
		if self[i + 1] ~= nil then
			dst = func(dst, self[i + 1])
		end
	end
	return dst
end

function List.reverse(self)
	local temp = {}
	for i, v in ipairs(self) do
		temp[i] = v
	end

	for i, v in ipairs(temp) do
		self[#self - i + 1] = v
	end
	return self
end

function List.foldr(self, func)
	self:reverse()
	return self:foldl(func)
end

M.List = List
return M
