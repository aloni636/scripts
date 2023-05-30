local count = require("rectangles.counter").count
local shapes = require("rectangles.shapes")

local function main()
	for index, shape in ipairs(shapes) do
		local scanline_index = 0
		for counter, weighted_edges in count(shape.q) do
			local vis_shape = string.gsub(shape.q, ".-\n", "", scanline_index)
			scanline_index = scanline_index + 1
			print(vis_shape)
			print(counter)
		end
	end
end

main()
