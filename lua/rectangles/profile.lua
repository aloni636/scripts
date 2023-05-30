local rect = require("rectangles.counter")
local shapes = require("rectangles.shapes")

for _ = 1, math.pow(10, 5) do
	for _, shape in ipairs(shapes) do
		rect.count(shape.q)
	end
end
