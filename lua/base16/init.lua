local config = require("base16.config")
local M = {}

---@param opts? Base16Config|Colorscheme
function M.setup(opts)
	if type(opts) == "table" and opts.base00 then
		require("base16.theme").load(opts --[[ @as Colorscheme ]])
		return
	end
	opts = opts or {}
	local colorscheme = opts.colorscheme
	opts.colorscheme = nil
	config.set_config(opts)
	if colorscheme then
		config.apply(colorscheme)
	end
end

return M
