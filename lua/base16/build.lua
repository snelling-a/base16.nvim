local uv = vim.loop or vim.uv
local fn = vim.fn

local script_path = debug.getinfo(1, "S").source:sub(2)
---@type string
local plugin_root = script_path:match("(.+)/lua/base16/build%.lua$")
local repo_url = "https://github.com/tinted-theming/schemes.git"
local tmpdir = fn.tempname()
local schemes_dir = tmpdir .. "/base16-schemes"
local colors_dir = plugin_root .. "/colors"

local function log(msg)
	vim.notify("[base16-build] " .. msg)
end

local function run(cmd)
	log("Running: " .. cmd)
	local null = (package.config:sub(1, 1) == "\\") and "NUL" or "/dev/null"
	local ok = os.execute(cmd .. " >" .. null .. " 2>&1")
	if not ok then
		error("Command failed: " .. cmd)
	end
end

local function prepare()
	uv.fs_mkdir(colors_dir, 448) -- 0700
end

local function get_schemes()
	if uv.fs_stat(schemes_dir) == nil then
		run("git clone --depth=1 " .. repo_url .. " " .. schemes_dir)
	else
		run("cd " .. schemes_dir .. " && git pull")
	end
end

local function purge_colors()
	log("Purging old colorschemes...")
	for name, _ in vim.fs.dir(colors_dir) do
		if name:match("^base16%-.+%.lua$") then
			os.remove(colors_dir .. "/" .. name)
		end
	end
end

local function extract_palette(yaml_path)
	---@type table<string, string>
	local palette = {}
	local in_palette = false
	for line in io.lines(yaml_path) do
		if line:match("^palette:") then
			in_palette = true
		elseif in_palette then
			---@type string, string
			local key, value = line:match('^%s*(base%x%x):%s*"(#%x+)"')
			if key and value then
				palette[key] = value
			elseif not line:match("^%s") then
				break
			end
		end
	end
	return palette
end

local function generate_lua(yaml_path)
	---@type string
	local fbname = yaml_path:match("([^/\\]+)%.yaml$")
	local palette = extract_palette(yaml_path)
	local out_path = colors_dir .. "/base16-" .. fbname .. ".lua"
	---@type file*
	local f = assert(io.open(out_path, "w"))
	f:write(string.format('vim.g.colors_name = "base16-%s"\n', fbname))
	f:write('require("base16.theme").load({\n')
	for i = 0, 15 do
		local key = string.format("base%02X", i)
		f:write(string.format('\t%s = "%s",\n', key, palette[key] or ""))
	end
	f:write("})\n")
	f:close()
end

local function scan_yaml_files(dir, out)
	---@type string[]
	out = out or {}
	local handle = uv.fs_scandir(dir)
	if not handle then
		return out
	end
	while true do
		---@type string, string
		local name, typ = uv.fs_scandir_next(handle)
		if not name then
			break
		end
		---@type string
		local full = dir .. "/" .. name
		if typ == "file" and name:match("%.yaml$") then
			table.insert(out, full)
		elseif typ == "directory" then
			scan_yaml_files(full, out)
		end
	end
	return out
end

local function generate_all()
	log("Generating Lua themes...")
	---@type string[]
	local yamls = scan_yaml_files(schemes_dir .. "/base16")
	for _, yaml_path in ipairs(yamls) do
		generate_lua(yaml_path)
	end
end

local function cleanup()
	log("Cleaning up...")
	local function rm_rf(path)
		for name, type in vim.fs.dir(path) do
			---@type string
			local full = path .. "/" .. name
			if type == "directory" then
				rm_rf(full)
			else
				os.remove(full)
			end
		end
		uv.fs_rmdir(path)
	end
	rm_rf(tmpdir)
end

local M = {}
function M.run()
	prepare()
	purge_colors()
	get_schemes()
	generate_all()
	cleanup()
	log("Done!")
end

return M
