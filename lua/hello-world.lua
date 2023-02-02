print("hello world")

-- watch out - variables are gloabl by default!
-- ============================================ --
local function change_global(var)
	ThisIsGlobal = var
	print("ThisIsGlobal changed to " .. tostring(var))
end

change_global(10)
print(ThisIsGlobal)

change_global(20)
print(ThisIsGlobal)

-- bools
-- ===== --
local bool_var = true
local nil_var = nil
local zero_var = 0
local empty_var = ""

local function is_bool(var)
	if var then
		print(tostring(var) .. " is true")
	else
		print(tostring(var) .. " is false")
	end
end

is_bool(bool_var)
is_bool(nil_var)
is_bool(zero_var)
is_bool(empty_var)

-- clousres --
--

-- statefull iterators --
-- Iterators are factory functions returning closures. Each time they are called,
-- they return the next iteration item, or nil.
-- Their state is stored in their enclosing function's local var.
local function range(max, min, step)
	step = step or 1
	local state = min or 0
	return function()
		state = state + step
		if state <= max then
			return state
		end
	end
end

for i in range(10) do
	print("iterating over range(10); current item is: " .. tostring(i))
end

-- stateless iterators --
-- for-loop construct: for <iter_item> in <iter_function>, <invariant_state>, loop_index
-- stateless iterators use for-loop built in bookkeeping to keep track of state.
-- for-loop construct can recive 3 vars: iter_function w/2 inputs, invariant_state variable & loop_index.

local function range(max, min, step)
	-- stateless iter function. i must be 0 for it to work properly
	local range_iter = function(a, i)
		local result = i * a.step + a.min
		i = i + 1
		if result <= a.max then
			return result
		end
	end
	-- invariant state holding parameters for stateless iter
	min = min or 1
	step = step or 1
	local a = { max = max, min = min, step = step }
	return range_iter, a, 0
end

for i in range(10, 3, 2) do
	print("iterating over range(10, 3, 2); current item is: " .. tostring(i))
end
-- OOP
-- === --
-- operator overloading/metatables:
-- metatables are just tables storing functions with specific names
-- this table can overwrite the default behavior of a table using setmetatable(table, meta)

-- object methods:
-- also, we can embed methods to a table using the : operator when defining adding a function to a table
-- this passes the table as self for the function

-- exercises
-- ========= --
-- difference-of-squares
-- --------------------- --
local function diff_of_squares_v1(n)
	-- a: sum_of_squares
	-- b: squared_range_sum

	local a = 0
	local b = 0
	for i = 1, n do
		a = a + i ^ 2
		b = b + i
	end
	b = b ^ 2
	return b - a
end

local function diff_of_squares_v2(n)
	-- a: sum_of_squares
	-- b: squared_range_sum
	local a = n * (n + 1) * (2 * n + 1) / 6
	local b = ((n + 1) * (n / 2)) ^ 2
	return b - a
end

-- should return 22
print("diff of squares where n=3 (should return 22):")
print(tostring(diff_of_squares_v1(3)))
print(tostring(diff_of_squares_v2(3)))
-- should return 70
print("diff of squares where n=4 (should return 70):")
print(tostring(diff_of_squares_v1(4)))
print(tostring(diff_of_squares_v2(4)))

-- binary-search
-- -------------- --
print("=== binary-search ===")
require("math")
require("io")

local function arr_tostring(array, min_i, max_i)
	max_i = (max_i == nil or max_i > #array) and #array or max_i
	min_i = (min_i == nil or min_i < 1) and 1 or min_i
	local dst = " "

	for i = min_i, max_i do
		dst = dst .. tostring(array[i]) .. " "
	end

	return "{" .. dst .. "}"
end

local function binary_search(array, item, min_i, max_i)
	max_i = max_i or #array
	min_i = min_i or 1

	local index = math.floor((max_i + min_i) / 2)
	print(arr_tostring(array, min_i, max_i))
	-- print("index: " .. tostring(index) .. "\n" .. "min_i: " .. tostring(min_i) .. "\n" .. "max_i: " .. tostring(max_i))

	if array[index] == item then
		return min_i
	elseif array[index] > item then
		return binary_search(array, item, min_i, index - 1)
	else
		return binary_search(array, item, index + 1, max_i)
	end
end

local array = { 1, 2, 5, 7, 16, 22, 23, 27, 33, 34, 43, 48 }
binary_search(array, 23)

-- isogram
-- ------- --
print("=== isogram ===")
require("string")

local function split_string(str, pattern)
	pattern = pattern or "."
	local i = 1
	local dst = {}
	for v in string.gmatch(str, pattern) do
		dst[i] = v
		i = i + 1
	end
	return dst
end

local function is_isogram(str)
	str = split_string(string.lower(str), "[^-]")
	local hash = {}
	for _, v in ipairs(str) do
		if hash[v] == nil then
			hash[v] = true
		else
			return false
		end
	end
	return true
end

-- should be true
print(is_isogram("lumberjacks"))
print(is_isogram("background"))
print(is_isogram("downstream"))
print(is_isogram("six-year-old"))
-- should be false
print(is_isogram("isograms"))

-- diamond kata --
-- ------------- --
print("=== diamond kata ===")
local function kata(char)
	-- estimated rows in kata
	local row_count = string.byte(char) - 64
	local rows = {}
	local dots = string.rep(".", row_count)

	for i = 1, row_count do
		local str = string.sub(dots, 1, i - 1) .. string.char(i + 64) .. string.sub(dots, i + 1)
		str = string.reverse(string.sub(str, 2)) .. str
		rows[i] = str
		rows[2 * row_count - i] = str
	end
	return rows
end

for _, v in ipairs(kata("D")) do
	print(v)
end

-- Pov --
-- ------------- --
print("=== Pov ===")
-- graph data structure
-- iterate over social rings by distance from a node
-- write as ascii art to output
