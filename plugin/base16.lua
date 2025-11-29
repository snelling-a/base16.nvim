local ok, colors = pcall(vim.api.nvim_get_runtime_file, "colors/base16*.lua", false)

if not ok or #colors == 0 then
	require("base16.build").run()
end

vim.api.nvim_create_user_command(
	"Base16Update",
	require("base16.build").run,
	{ desc = "Regenerate base16 colorschemes" }
)
