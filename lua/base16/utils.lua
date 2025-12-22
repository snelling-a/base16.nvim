---@param color string
---@return nil
local function parse_color(color)
	color = color:lower()

	if not color:find("#") and color ~= "none" then
		color = vim.api.nvim_get_color_by_name(color)
	end

	if color == -1 then
		return print("invalid color")
	end

	return color
end

local M = {}

---wrapper for |nvim_set_hl()|
---@param group string
---@param colors string|vim.api.keyset.highlight
function M.highlight(group, colors)
	if type(colors) == "string" then
		vim.api.nvim_set_hl(0, group, { link = colors })
	else
		local fg = colors.fg and parse_color(colors.fg) or "none"
		local bg = colors.bg and parse_color(colors.bg) or "none"
		local sp = colors.sp and parse_color(colors.sp) or ""

		colors = vim.tbl_extend("force", colors, { fg = fg, bg = bg, sp = sp })
		vim.api.nvim_set_hl(0, group, colors)
	end
end

return M
