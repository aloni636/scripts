local rect = require("counter")
local shapes = require("shapes")
local lu = require("luaunit")

--------------- TESTS ---------------

function test_count()
	for index, shape in ipairs(shapes) do
		lu.assertEquals(
			rect.count(shape.q),
			shape.a,
			"stopped at shape: " .. tostring(index) .. "/" .. tostring(#shapes)
		)
	end
end

--------------- TESTS ---------------

os.exit(lu.LuaUnit.run())
