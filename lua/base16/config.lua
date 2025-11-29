local M = {}

---@type Base16Config
M.config = {
	colorscheme = "base16-default-dark",
	diagnostic_underline_style = "undercurl",
	disable_groups = {},
	enable_bold = true,
	enable_italic = true,
	export_base16_globals = false,
	highlight_overrides = {},
	export_terminal_colors = false,
	spell_underline_style = nil,
}

function M.set_config(opts)
	M.config = vim.tbl_deep_extend("force", M.config, opts or {})
end

M.colorschemes = {}
setmetatable(M.colorschemes, {
	__index = function(t, key)
		t[key] = require(string.format("colors.%s", key))
		return t[key]
	end,
})

function M.apply(colors)
	if vim.g.colors_name then
		vim.cmd.hi("clear")
	end

	if type(colors) == "string" then
		if not colors:match("^base16%-") then
			colors = "base16-" .. colors
		end
		vim.cmd.colorscheme(colors)
		-- After setting the colorscheme, apply highlight overrides/config
		require("base16.theme").load()
		return
	end

	-- If a palette table is provided, use the theme loader directly
	require("base16.theme").load(colors)
end

return M
