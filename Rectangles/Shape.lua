local Shape = {}
Shape.__index = Shape

local function bounding_box(str)
	local sx = 0
	local sy = 0
	for s in string.gmatch(str, "(.-)\n") do
		sy = sy + 1
		local l = string.len(s)
		sx = sx > l and sx or l
	end
	return sx, sy
end

local function fill_blank(str, sx)
	local result = ""
	for s in string.gmatch(str, "(.-)\n") do
		result = result .. string.rep(" ", sx - string.len(s)) .. "\n"
	end
	return result
end

function Shape.new(str, sx, sy)
	local self = {}
	setmetatable(self, Shape)
	if not sx or not sy then
		sx, sy = bounding_box(str)
		str = fill_blank(str, sx)
	end

	self.str = str
	self.sx = sx
	self.sy = sy

	return self
end

function Shape.random(sx, sy)
	local rx = math.random(2, sx)
	local ry = math.random(2, sy)

	local ox = math.random(0, sx - rx)
	local oy = math.random(0, sy - ry)

	local empty = string.rep(" ", sx) .. "\n"
	local hedge = string.rep(" ", ox)
		.. "+"
		.. string.rep("-", rx - 2)
		.. "+"
		.. string.rep(" ", sx - (ox + rx))
		.. "\n"
	local vedge = string.rep(" ", ox)
		.. "|"
		.. string.rep(" ", rx - 2)
		.. "|"
		.. string.rep(" ", sx - (ox + rx))
		.. "\n"
	local self = Shape.new(
		string.rep(empty, oy) .. hedge .. string.rep(vedge, ry - 2) .. hedge .. string.rep(empty, sy - (oy + ry)),
		sx,
		sy
	)
	return self
end

function Shape:size() end

function Shape:line_iter(pos) end

function Shape:char_iter(pos) end

function Shape:__tostring() end

return Shape
