lu = require("luaunit")
local List = require("List-Ops.listops").List

local function predicate(item)
	return item % 2 == 0
end

local function map(item)
	return item * item
end

local function accumulator(init, item)
	if init % 2 == 0 then
		return init + item
	else
		return init * item
	end
end

--------------- TESTS ---------------

function test_append()
	local a1 = List.new({ 1, 2, 3 })
	local a2 = List.new({ 4, 5, 6 })
	a1:append(a2)
	lu.assertEquals(a1, List.new({ 1, 2, 3, 4, 5, 6 }))
end

function test_concatenate()
	local a1 = List.new({ 1, 2, 3 })
	local a2 = List.new({ 4, 5, 6 })
	local a3 = List.new({ 7, 8, 9 })
	a1:concatenate(a2, a3)
	lu.assertEquals(a1, List.new({ 1, 2, 3, 4, 5, 6, 7, 8, 9 }))
end

function test_filter()
	local a1 = List.new({ 1, 2, 3, 4, 5 })
	a1:filter(predicate)
	lu.assertEquals(a1, List.new({ 2, 4 }))
end

function test_length()
	local a1 = List.new({ 1, 2, 3 })
	lu.assertEquals(a1:length(), 3)
end

function test_map()
	local a1 = List.new({ 1, 2, 3 })
	a1:map(map)
	lu.assertEquals(a1, List.new({ 1, 4, 9 }))
end

function test_foldl()
	local a1 = List.new({ 1, 2, 3 })
	lu.assertEquals(a1:foldl(accumulator), 5)
end

function test_foldr()
	local a1 = List.new({ 1, 2, 3 })
	lu.assertEquals(a1:foldr(accumulator), 7)
end

function test_reverse()
	local a1 = List.new({ 1, 2, 3 })
	a1:reverse()
	lu.assertEquals(a1, List.new({ 3, 2, 1 }))
end

--------------- TESTS ---------------

os.exit(lu.LuaUnit.run())
