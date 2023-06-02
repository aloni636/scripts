local count = require("rectangles.counter").count
local shapes = require("rectangles.shapes")
local lu = require("luaunit")

--------------- TESTS ---------------

function test_count()
	for index, shape in ipairs(shapes) do
		local result = 0
 		-- dbg()
		for counter,_ in count(shape.q) do result = counter end
		lu.assertEquals(
			result,
			shape.a,
			"stopped at shape: " .. tostring(index) .. "/" .. tostring(#shapes)
		)
	end
end

--------------- TESTS ---------------

os.exit(lu.LuaUnit.run())
