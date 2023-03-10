-- Algorithm inspired by the book Computational Geometry: Algorithms and Applications
-- Popped to mind at 3AM (don't ask why)
-- The algorith uses a sweep line technique

-- Instructions
-- Count the rectangles in an ASCII diagram like the one below.
--
--    +--+
--   ++  |
-- +-++--+
-- |  |  |
-- +--+--+
--
-- The above diagram contains 6 rectangles

-- +--+++--+
-- |   ||
-- |  +++  ++
-- +--+++--++

-- Algorithm steps:
-- Define weighted edges as a list of 3 whole numbers s, e, w constrained to {s<e and w>0} indicating where the edge start, end and the number of consecutive connected edges to it with same s & e.
-- Given a set of weighted edges connected to scanline as CE:
-- Produce edges from scanline as SE
-- Iterate over each edge in SE
-- If its s & e match an item from CE, add w to rect count and increment w by 1,
-- If not, add it to CE
-- Now test each iten in CE if it is connected to next scanline in s & e. If it doesnt drop it from CE.-

---Returns an iterator function that, each time it is called, finds the next captures from `pattern` over the string s and returns the start & end indices of capture, along with the capture text itself.
---
---As an example, the following loop will iterate over all the words from string str, printing one per line:
---```lua
---    str = "hello world from Lua"
---    for s,e,w in string.gmatch(str, "%a+") do
---        print(w) -- prints each word
---  			print(string.sub(w,s,e)) -- also prints each word
---    end

---@param s       string
---@param pattern string
---@return fun():number, number, string
local function igmatch(s, pattern)
	-- start, end of match
	local st, en = 0, 0
	return function()
		st, en = string.find(s, pattern, en + 1)
		if st == nil then
			return nil
		else
			return st, en, string.sub(s, st, en)
		end
	end
end

local function scanline_iter(shape)
	-- make sure last char is \n
	-- this allows scanlines to be defined as all char up until \n
	if string.sub(shape, -1) ~= "\n" then
		shape = shape .. "\n"
	end
	return string.gmatch(shape, "(.-)\n")
end

-- scanline stats return 2 objects:
-- A. set indicating where the scanline connects to previous line
-- B. all edges of scanline, with weight of 1
local function scanline_stats(scanline)
	local conn = {}
	local edges = {}

	-- match every connector i.e +,|
	-- store it in a Set, where items are stored as indices
	for index, _, _ in igmatch(scanline, "[%+%|]") do
		conn[index] = true
	end

	-- iterate over edge strips
	for strip_start, _, match in igmatch(scanline, "%+[%+%-]+") do
		local previous_vertices = {}
		-- iterate over each vertex
		-- i starts from 1, i.e edge-strip local coords, instead of scanline coords
		for vert, _ in igmatch(match, "%+") do
			-- start creating edges after first vertex
			if vert > 1 then
				-- iterate over previous vertices
				for _, prev_vert in pairs(previous_vertices) do
					-- offset edges from strip local coords to scanline coords
					local offset = strip_start - 1
					table.insert(edges, { s = prev_vert + offset, e = vert + offset, w = 1 })
				end
			end
			table.insert(previous_vertices, vert)
		end
	end

	return conn, edges
end

local function count(shape)
	local weighted_edges = {}
	local counter = 0
	for scanline in scanline_iter(shape) do
		-- <Set> connectivity and <Table> of wedges w/w=1 of all possible edges
		local connectivity_set, scanline_edges = scanline_stats(scanline)

		-- drop all wedges not fully connected to current scanline
		for index, wgt_edge in pairs(weighted_edges) do
			if not connectivity_set[wgt_edge.s] or not connectivity_set[wgt_edge.e] then
				weighted_edges[index] = nil
			end
		end

		-- check each scanline_edge if it creates a rectangle with one of weighted_edges
		-- if yes - add the weight of that edge to counter and increment weight by 1
		-- if not - the edge is a new edge from current scanline and must be add to weighted edges for next round
		-- if there are no weighted_edges, set all scanline_edges as the new weighted_edges for next round
		if next(weighted_edges) ~= nil then
			local new_weighted_edges = {}
			for _, sl_edge in pairs(scanline_edges) do
				for _, wgt_edge in pairs(weighted_edges) do
					if sl_edge.s == wgt_edge.s and sl_edge.e == wgt_edge.e then
						counter = counter + wgt_edge.w
						wgt_edge.w = wgt_edge.w + 1
						break
					end
				end
				table.insert(new_weighted_edges, sl_edge)
			end
			for _, new_edge in pairs(new_weighted_edges) do
				table.insert(weighted_edges, new_edge)
			end
		else
			weighted_edges = scanline_edges
		end
	end

	return counter
end

return { count = count }
