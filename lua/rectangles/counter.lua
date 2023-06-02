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

local dbg = require("debugger")

---returns an iterator function that, each time it is called, finds the next captures from `pattern` over the string s and returns the start & end indices of capture, along with the capture text itself.
---
---As an example, the following loop will iterate over all the words from string str, printing one per line:
---```lua
---    str = "hello world from Lua"
---    for s,e,w in string.gmatch(str, "%a+") do
---        print(w) -- prints each word
---        print(string.sub(w,s,e)) -- also prints each word
---    end
---@param s       string
---@param pattern string
---@return fun(): number, number, string
local function igmatch(s, pattern)
  -- start, end of match
  local index = 1
  return function()
    -- match is returned by string.find support for capture groups
    local start_pos, end_pos, match = string.find(s, "("..pattern..")", index)
    if start_pos == nil then return nil end
    index = end_pos + 1
    return start_pos, end_pos, match
  end
end

---split string by lines, returning them as array
---@param shape string
---@return fun(): string
local function scanline_iter(shape)
  -- make sure last char is \n
  -- this allows scanlines to be defined as all char up until \n
  if string.sub(shape, -1) ~= "\n" then
    shape = shape .. "\n"
  end
  -- local t = {}
  -- _ = string.gsub(shape, "(.-)\n", function(c) table.insert(t, c) end)
  -- return t
  return string.gmatch(shape, "(.-)\n")
end

-- from: " +--+--+--+--+   |   | +--+ "
--       " |     +--+  |   +---+ +--+ "
--
--   to: " +-----+--+--+   +---+ +--+ "
--       " 0     1  1  0   1   1 1  1"
---@param p string
---@param s string
---@return table edges
local function hash_stats(p,s)
  -- TODO: parsing based on previous scanline (whitespace aware)
  -- TODO: new edges weight is determined by the presence of closing vertex
  s = string.gsub(s, "|[%s|]*|",
    function(x)
      x = string.gsub(x, "%s", "-")
      x = string.gsub(x, "|", "+")
      return x
    end)
  local edges = {}
  -- for each edge strip
  for start_pos, _, match in igmatch(s, "%+[^%s]+") do
    -- strip contains vertex indices
    local strip = {}
    for pos, _, _ in igmatch(match, "+") do 
      table.insert(strip, start_pos+pos-1)
    end
    -- find all size 2 combinations
    for start_pos = 1, #strip do
      for end_pos = start_pos, #strip do
        local edge = strip[start_pos] .. "," .. strip[end_pos]
        -- dbg()
        edges[edge] = 0
      end
    end
  end
  return edges
end

---Returns an iterator function that, each time it is called,
---returns the next state of the sweep line counting algorithm.
---@param shape string
---@return fun():  integer, table
local function count(shape)
  local old_edges = {}
  local counter = 0
  local scanlines = scanline_iter(shape)

  return function()
    local scanline = scanlines()
    -- if iterator consumed all scanlines
    if scanline == nil then
      return nil
    else
      local new_edges, connectors = hash_stats(scanline)

      -- check each scanline_edge if it creates a rectangle with one of weighted_edges
      -- if yes - add the weight of that edge to counter and increment weight by 1
      -- if not - the edge is a new edge from current scanline and must be add to weighted edges for next round
      -- if there are no weighted_edges, set all scanline_edges as the new weighted_edges for next round
      -- dbg()
      for index, value in pairs(old_edges) do
        if new_edges[index] and connectors[index] == nil then
          -- dbg()
          counter = counter + old_edges[index]
          new_edges[index] = old_edges[index] + 1
        end
      end

      old_edges = new_edges
      return counter, old_edges
    end
  end
end

return { count = count, line_split = scanline_iter }
