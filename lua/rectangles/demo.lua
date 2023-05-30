local count = require("rectangles.counter").count
local shapes = require("rectangles.shapes")

local function main()
	for index, shape in ipairs(shapes) do
		local shape_vis = {}
		scanline_index = 1
		_ = string.gsub(shape.q, "(.-)\n", function(c) table.insert(shape_vis, c) end)
		for counter, weighted_edges in count(shape.q) do
			if shape_vis[scanline_index]==nil then break end
			for i = 1, scanline_index do print(shape_vis[i] .. "            ") end
			print("count:" .. counter .. "           ")
			print("============")
			os.execute("sleep " .. tonumber(0.5))
			ANSI_TOP = "\27[" .. scanline_index+2  .. "A"
			io.write(ANSI_TOP)
			scanline_index = scanline_index + 1
		end
	ANSI_BOTTOM = "\27[" .. scanline_index + 1 .. "B"
	io.write(ANSI_BOTTOM)
	end
end

main()
