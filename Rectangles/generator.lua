-- local rect = require("counter")
-- local shapes = require("shapes")

math.randomseed(42)

local function gen_rect(sx, sy)
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
	return string.rep(empty, oy) .. hedge .. string.rep(vedge, ry - 2) .. hedge .. string.rep(empty, sy - (oy + ry))
end

local function overlay_rect(a, b)
	local a_lines = string.gmatch(a, "(.-)\n")
	local b_lines = string.gmatch(b, "(.-)\n")
	while true do
		local aline = a_lines()
		local bline = b_lines()

		if not aline or not bline then
			break
		end
	end
end

local function random_rect(seed)
	-- code
end
