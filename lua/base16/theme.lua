-- vim:foldmethod=marker:foldlevel=0:foldlevelstart=0
-- Some useful links for making your own colorscheme:
-- https://github.com/chriskempson/base16
-- https://colourco.de/
-- https://color.adobe.com/create/color-wheel
-- http://vrl.cs.brown.edu/color

local M = {}

--- Creates a base16 colorscheme using the colors specified.
--
-- Builtin colorschemes can be found in the M.colorschemes table.
--
-- The default Vim highlight groups (including User[1-9]), highlight groups
-- pertaining to Neovim's builtin LSP, and highlight groups pertaining to
-- Treesitter will be defined.
--
-- It's worth noting that many colorschemes will specify language specific
-- highlight groups like rubyConstant or pythonInclude. However, I don't do
-- that here since these should instead be linked to an existing highlight
-- group.
--
-- 'base00', 'base01', 'base02', 'base03', 'base04', 'base05', 'base06', 'base07',
-- 'base08', 'base09', 'base0A', 'base0B', 'base0C', 'base0D', 'base0E', 'base0F'.
-- Each key should map to a valid 6 digit hex color.
---Apply a base16 palette
---@param colors Colorscheme
function M.load(colors)
	if not colors then
		return
	end
	local config = require("base16.config").config

	---@type Highlights
	local Highlights = {}

	---@param opt UnderlineStyle
	---@return UnderlineStyle
	local function get_underline_style(opt)
		if opt == nil then
			return nil
		end

		local valid_underline_styles = {
			undercurl = true,
			underdotted = true,
			underdashed = true,
			underline = true,
		}

		if valid_underline_styles[opt] then
			return opt
		end
		return "undercurl"
	end

	-- Vim editor colors {{{
	Highlights.Bold = { bold = true }
	Highlights.ColorColumn = { link = "CursorLine" }
	Highlights.Conceal = { link = "NonText" }
	Highlights.CurSearch = { link = "Search" }
	Highlights.Cursor = { fg = colors.base00, bg = colors.base05 }
	Highlights.CursorColumn = { link = "CursorLine" }
	Highlights.CursorLine = { bg = colors.base01 }
	Highlights.CursorLineNr = { fg = colors.base06, bg = colors.base01 }
	Highlights.Debug = { fg = colors.base08 }
	Highlights.Directory = { fg = colors.base0D }
	Highlights.Error = { fg = colors.base00, bg = colors.base08 }
	Highlights.ErrorMsg = { fg = colors.base08 }
	Highlights.Exception = { fg = colors.base08 }
	Highlights.FoldColumn = { fg = colors.base0C }
	Highlights.Folded = { fg = colors.base03, bg = colors.base01 }
	Highlights.FoldedText = { link = "Comment" }
	Highlights.IncSearch = { fg = colors.base01, bg = colors.base09 }
	Highlights.Italic = { italic = true }
	Highlights.LineNr = { fg = colors.base04 }
	Highlights.Macro = { fg = colors.base08 }
	Highlights.MatchParen = { bg = colors.base03 }
	Highlights.ModeMsg = { fg = colors.base0B, bg = nil }
	Highlights.MoreMsg = { link = "ModeMsg" }
	Highlights.NonText = { fg = colors.base03 }
	Highlights.Normal = { fg = colors.base05, bg = colors.base00 }
	Highlights.PMenu = { fg = colors.base05 }
	Highlights.PMenuSel = { fg = colors.base01, bg = colors.base05 }
	Highlights.Question = { fg = colors.base0D }
	Highlights.QuickFixLine = { link = "CursorLine" }
	Highlights.RulerFormat = { fg = colors.base0D }
	Highlights.Search = { fg = colors.base01, bg = colors.base0A }
	Highlights.SignColumn = { fg = colors.base04 }
	Highlights.SpecialKey = { fg = colors.base03 }
	Highlights.StatusLine = { fg = colors.base05, bg = colors.base02 }
	Highlights.StatusLineNC = { fg = colors.base04 }
	Highlights.Substitute = { fg = colors.base01, bg = colors.base0A }
	Highlights.TabLine = { link = "StatusLineNC" }
	Highlights.TabLineFill = { link = "StatusLineNC" }
	Highlights.TabLineSel = { fg = colors.base0B, bg = colors.base02 }
	Highlights.TermCursor = { fg = colors.base00, bg = colors.base05 }
	Highlights.TermCursorNC = { fg = colors.base00, bg = colors.base05 }
	Highlights.Title = { bold = true, fg = colors.base0D }
	Highlights.TooLong = { fg = colors.base08 }
	Highlights.Underlined = { fg = colors.base08 }
	Highlights.VertSplit = { fg = colors.base05 }
	Highlights.Visual = { bg = colors.base02 }
	Highlights.VisualNOS = { fg = colors.base08 }
	Highlights.WarningMsg = { fg = colors.base08 }
	Highlights.WildMenu = { fg = colors.base08, bg = colors.base0A }
	Highlights.WinBar = { fg = colors.base05, bg = colors.base01 }
	Highlights.WinBarNC = { fg = colors.base04, bg = colors.base01 }
	-- Command-line expressions highlighting
	-- all other highlight groups have default links :h |expr-highlight|
	Highlights.NvimInternalError = { fg = colors.base00, bg = colors.base08 }
	-- }}}

	-- Standard syntax highlighting {{{
	Highlights.Boolean = { fg = colors.base09 }
	Highlights.Character = { fg = colors.base08 }
	Highlights.Comment = { fg = colors.base03, italic = true }
	Highlights.Conditional = { fg = colors.base0E }
	Highlights.Constant = { fg = colors.base09 }
	Highlights.Define = { fg = colors.base0E }
	Highlights.Delimiter = { fg = colors.base05 }
	Highlights.Function = { fg = colors.base0D }
	Highlights.Identifier = { fg = colors.base08 }
	Highlights.Include = { fg = colors.base0D }
	Highlights.Keyword = { fg = colors.base0E }
	Highlights.Label = { fg = colors.base0A }
	Highlights.Number = { fg = colors.base09 }
	Highlights.Operator = { fg = colors.base05 }
	Highlights.PreProc = { fg = colors.base0A }
	Highlights.Repeat = { fg = colors.base0A }
	Highlights.Special = { fg = colors.base0C }
	Highlights.SpecialChar = { fg = colors.base0F }
	Highlights.Statement = { fg = colors.base08 }
	Highlights.StorageClass = { fg = colors.base0A }
	Highlights.String = { fg = colors.base0B }
	Highlights.Structure = { fg = colors.base0E }
	Highlights.Tag = { fg = colors.base0A }
	Highlights.Todo = { fg = colors.base0A }
	Highlights.Type = { fg = colors.base0A }
	Highlights.Typedef = { fg = colors.base0A }
	-- }}}

	-- Diff highlighting {{{
	Highlights.Added = { fg = colors.base0B }
	Highlights.Changed = { fg = colors.base0E }
	Highlights.DiffAdd = { link = "Added" }
	Highlights.DiffAdded = { link = "DiffAdd" }
	Highlights.DiffChange = { fg = colors.base0E }
	Highlights.DiffDelete = { link = "Removed" }
	Highlights.DiffFile = { fg = colors.base08 }
	Highlights.DiffLine = { fg = colors.base0E }
	Highlights.DiffNewFile = { fg = colors.base0B }
	Highlights.DiffRemoved = { link = "DiffDelete" }
	Highlights.DiffText = { fg = colors.base0D }
	Highlights.Removed = { fg = colors.base08 }
	-- }}}

	-- Git commit highlighting {{{
	Highlights.gitcommitOverflow = { link = "ErrorMsg" }
	Highlights.gitcommitSummary = { fg = colors.base0B }
	Highlights.gitcommitComment = { link = "Comment" }
	Highlights.gitcommitUntracked = { link = "NonText" }
	Highlights.gitcommitDiscarded = { fg = colors.base08 }
	Highlights.gitcommitSelected = { fg = colors.base02 }
	Highlights.gitcommitHeader = { link = "Title" }
	Highlights.gitcommitSelectedType = { fg = colors.base0D }
	Highlights.gitcommitUnmergedType = { fg = colors.base0D }
	Highlights.gitcommitDiscardedType = { fg = colors.base0D }
	Highlights.gitcommitBranch = { fg = colors.base0E, bold = true }
	Highlights.gitcommitUntrackedFile = { link = "NonText" }
	Highlights.gitcommitUnmergedFile = { fg = colors.base08, bold = true }
	Highlights.gitcommitDiscardedFile = { fg = colors.base08, bold = true }
	Highlights.gitcommitSelectedFile = { fg = colors.base0B, bold = true }
	-- }}}

	-- Spelling highlighting {{{

	local spell_style = get_underline_style(config.spell_underline_style)
	if spell_style then
		Highlights.SpellBad = { [spell_style] = true, sp = colors.base08 }
		Highlights.SpellLocal = { [spell_style] = true, sp = colors.base0C }
		Highlights.SpellCap = { [spell_style] = true, sp = colors.base0D }
		Highlights.SpellRare = { [spell_style] = true, sp = colors.base0E }
	else
		Highlights.SpellBad = { sp = colors.base08 }
		Highlights.SpellLocal = { sp = colors.base0C }
		Highlights.SpellCap = { sp = colors.base0D }
		Highlights.SpellRare = { sp = colors.base0E }
	end
	-- }}}

	-- Diagnostics {{{
	Highlights.DiagnosticDeprecated = { fg = colors.base0F, strikethrough = true }
	Highlights.DiagnosticError = { fg = colors.base08 }
	Highlights.DiagnosticHint = { fg = colors.base0C }
	Highlights.DiagnosticInfo = { fg = colors.base05 }
	Highlights.DiagnosticOk = { fg = colors.base0B }
	local diag_style = get_underline_style(config.diagnostic_underline_style)
	if diag_style then
		Highlights.DiagnosticUnderlineError = { [diag_style] = true, sp = colors.base08 }
		Highlights.DiagnosticUnderlineHint = { [diag_style] = true, sp = colors.base0C }
		Highlights.DiagnosticUnderlineInfo = { [diag_style] = true, sp = colors.base05 }
		Highlights.DiagnosticUnderlineOk = { [diag_style] = true, sp = colors.base0B }
		Highlights.DiagnosticUnderlineWarn = { [diag_style] = true, sp = colors.base0E }
	else
		Highlights.DiagnosticUnderlineError = { sp = colors.base08 }
		Highlights.DiagnosticUnderlineHint = { sp = colors.base0C }
		Highlights.DiagnosticUnderlineInfo = { sp = colors.base05 }
		Highlights.DiagnosticUnderlineOk = { sp = colors.base0B }
		Highlights.DiagnosticUnderlineWarn = { sp = colors.base0E }
	end
	Highlights.DiagnosticUnderlineWarning = { link = "DiagnosticUnderlineWarn" }
	Highlights.DiagnosticWarn = { fg = colors.base0E }
	-- }}}

	-- DAP {{{
	if not vim.tbl_contains(config.disable_groups, "dap") then
		Highlights.Breakpoint = { link = "DiagnosticError" }
		Highlights.BreakpointCondition = { link = "DiagnosticUnderlineWarn" }
		Highlights.BreakpointRejected = { link = "DiagnosticUnderlineError" }
		Highlights.LogPoint = { link = "DiagnosticHint" }
		Highlights.Stopped = { link = "DiagnosticError" }
	end
	-- }}}

	-- ILLUMINATED {{{

	Highlights.IlluminatedWordText = { link = "LspReferenceText" }
	Highlights.IlluminatedWordRead = { link = "LspReferenceRead" }
	Highlights.IlluminatedWordWrite = { link = "LspReferenceWrite" }

	-- }}}

	-- LSP {{{
	if not vim.tbl_contains(config.disable_groups, "lsp") then
		Highlights.LspCodeLens = { link = "Comment" }
		Highlights.LspCodeLensSeparator = { link = "Comment" }
		Highlights.LspDiagnosticsDefaultError = { link = "DiagnosticError" }
		Highlights.LspDiagnosticsDefaultHint = { link = "DiagnosticHint" }
		Highlights.LspDiagnosticsDefaultInformation = { link = "DiagnosticInfo" }
		Highlights.LspDiagnosticsDefaultWarning = { link = "DiagnosticWarn" }
		Highlights.LspDiagnosticsUnderlineError = { link = "DiagnosticUnderlineError" }
		Highlights.LspDiagnosticsUnderlineHint = { link = "DiagnosticUnderlineHint" }
		Highlights.LspDiagnosticsUnderlineInformation = { link = "DiagnosticUnderlineInformation" }
		Highlights.LspDiagnosticsUnderlineWarning = { link = "DiagnosticUnderlineWarning" }
		Highlights.LspInfoBorder = { link = "Normal" }
		Highlights.LspInlayHint = { link = "Comment" }
		Highlights.LspReferenceRead = { bg = colors.base02 }
		Highlights.LspReferenceText = { bg = colors.base02 }
		Highlights.LspReferenceWrite = { bg = colors.base02 }
		Highlights.LspSignatureActiveParameter = { link = "Comment" }

		for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight") or {}) do
			vim.api.nvim_set_hl(0, group, {})
		end
	end
	-- }}}

	--- RAINBOW-DELIMETERS {{{
	if not vim.tbl_contains(config.disable_groups, "rainbow") then
		Highlights.RainbowDelimiterRed = { fg = colors.base08 }
		Highlights.RainbowDelimiterYellow = { fg = colors.base0A }
		Highlights.RainbowDelimiterBlue = { fg = colors.base0D }
		Highlights.RainbowDelimiterOrange = { fg = colors.base09 }
		Highlights.RainbowDelimiterGreen = { fg = colors.base0B }
		Highlights.RainbowDelimiterViolet = { fg = colors.base0E }
		Highlights.RainbowDelimiterCyan = { fg = colors.base0C }
	end
	--- }}}

	-- Treesitter {{{
	if not vim.tbl_contains(config.disable_groups, "treesitter") then
		Highlights["@attribute"] = { fg = colors.base0D, italic = true }
		Highlights["@boolean"] = { link = "Boolean" }
		Highlights["@character"] = { link = "Character" }
		Highlights["@character.special"] = { link = "SpecialChar" }
		Highlights["@comment"] = { link = "Comment" }
		Highlights["@comment.error"] = { link = "ErrorMsg" }
		Highlights["@comment.note"] = { link = "Tag" }
		Highlights["@comment.todo"] = { link = "Todo" }
		Highlights["@comment.warning"] = { link = "DiagnosticWarn" }
		Highlights["@constant"] = { link = "Constant" }
		Highlights["@constant.builtin"] = { link = "Constant" }
		Highlights["@constant.java"] = { fg = colors.base0C }
		Highlights["@constant.macro"] = { link = "Constant" }
		Highlights["@constructor"] = { fg = colors.base0D }
		Highlights["@constructor.lua"] = { fg = colors.base0D }
		Highlights["@constructor.tsx"] = { link = "@constructor.typescript" }
		Highlights["@constructor.typescript"] = { fg = colors.base0D }
		Highlights["@diff.delta"] = { link = "DiffChanged" }
		Highlights["@diff.minus"] = { link = "DiffDelete" }
		Highlights["@diff.plus"] = { link = "DiffAdd" }
		Highlights["@error"] = { link = "Error" }
		Highlights["@function"] = { link = "Function" }
		Highlights["@function.builtin"] = { fg = colors.base0D, italic = true }
		Highlights["@function.builtin.bash"] = { fg = colors.base08, italic = true }
		Highlights["@function.call"] = { link = "Function" }
		Highlights["@function.macro"] = { link = "Macro" }
		Highlights["@function.method"] = { fg = colors.base0D }
		Highlights["@function.method.call"] = { fg = colors.base0D }
		Highlights["@function.method.call.php"] = { link = "Function" }
		Highlights["@function.method.php"] = { link = "Function" }
		Highlights.gitcommitSummary = { fg = colors.base0B, italic = true }
		Highlights["@keyword"] = { link = "Keyword" }
		Highlights["@keyword.conditional"] = { link = "Conditional" }
		Highlights["@keyword.debug"] = { link = "Debug" }
		Highlights["@keyword.directive"] = { link = "PreProc" }
		Highlights["@keyword.directive.define"] = { link = "Define" }
		Highlights["@keyword.exception"] = { link = "Exception" }
		Highlights["@keyword.export"] = { link = "Keyword" }
		Highlights["@keyword.function"] = { link = "Keyword" }
		Highlights["@keyword.import"] = { link = "Include" }
		Highlights["@keyword.operator"] = { link = "Keyword" }
		Highlights["@keyword.repeat"] = { link = "Repeat" }
		Highlights["@keyword.return"] = { link = "Keyword" }
		Highlights["@keyword.storage"] = { link = "StorageClass" }
		Highlights["@label"] = { link = "Label" }
		Highlights["@label.json"] = { link = "Label" }
		Highlights["@markup"] = { fg = colors.base05 }
		Highlights["@markup.environment"] = { link = "Macro" }
		Highlights["@markup.environment.name"] = { link = "Type" }
		Highlights["@markup.heading"] = { link = "Title" }
		Highlights["@markup.heading.1.markdown"] = { link = "Title" }
		Highlights["@markup.heading.2.markdown"] = { fg = colors.base09 }
		Highlights["@markup.heading.3.markdown"] = { fg = colors.base0A }
		Highlights["@markup.heading.4.markdown"] = { fg = colors.base0B }
		Highlights["@markup.heading.5.markdown"] = { fg = colors.base0C }
		Highlights["@markup.heading.6.markdown"] = { fg = colors.base0F }
		Highlights["@markup.italic"] = { fg = colors.base09, italic = true }
		Highlights["@markup.link"] = { fg = colors.base08 }
		Highlights["@markup.link.url"] = { fg = colors.base09, underline = true }
		Highlights["@markup.list"] = { link = "Special" }
		Highlights["@markup.list.checked"] = { link = "DiagnosticOk" }
		Highlights["@markup.list.unchecked"] = { link = "DiagnosticInfo" }
		Highlights["@markup.raw"] = { link = "Number" }
		Highlights["@markup.strikethrough"] = { link = "DiagnosticDeprecated" }
		Highlights["@markup.underline"] = { underline = true }
		Highlights["@module"] = { fg = colors.base05, italic = true }
		Highlights["@number"] = { link = "Number" }
		Highlights["@number.css"] = { link = "Number" }
		Highlights["@number.float"] = { link = "Number" }
		Highlights["@operator"] = { link = "Operator" }
		Highlights["@property"] = { fg = colors.base05 }
		Highlights["@property.class.css"] = { link = "StorageClass" }
		Highlights["@property.cpp"] = { fg = colors.base05 }
		Highlights["@property.css"] = { fg = colors.base05 }
		Highlights["@property.id.css"] = { link = "Identifier" }
		Highlights["@property.toml"] = { fg = colors.base05 }
		Highlights["@property.typescript"] = { fg = colors.base05 }
		Highlights["@punctuation.bracket"] = { fg = colors.base0F }
		Highlights["@punctuation.delimiter"] = { fg = colors.base0F }
		Highlights["@punctuation.special"] = { link = "Special" }
		Highlights["@string"] = { link = "String" }
		Highlights["@string.escape"] = { fg = colors.base0C }
		Highlights["@string.plain.css"] = { link = "String" }
		Highlights["@string.regexp"] = { fg = colors.base0C }
		Highlights["@string.special"] = { link = "Special" }
		Highlights["@string.special.symbol"] = { fg = colors.base0C }
		Highlights["@string.special.symbol.ruby"] = { link = "Special" }
		Highlights["@string.special.url"] = { link = "SpecialChar" }
		Highlights["@tag"] = { link = "Tag" }
		Highlights["@tag.attribute"] = { fg = colors.base0D, italic = true }
		Highlights["@tag.attribute.tsx"] = { fg = colors.base0D, italic = true }
		Highlights["@tag.delimiter"] = { link = "Delimiter" }
		Highlights["@type"] = { link = "Type" }
		Highlights["@type.builtin"] = { fg = colors.base0A, italic = true }
		Highlights["@type.builtin.c"] = { fg = colors.base08, italic = true }
		Highlights["@type.builtin.cpp"] = { fg = colors.base08, italic = true }
		Highlights["@type.css"] = { link = "Type" }
		Highlights["@type.definition"] = { link = "Type" }
		Highlights["@type.qualifier"] = { link = "Keyword" }
		Highlights["@type.tag.css"] = { link = "Tag" }
		Highlights["@variable"] = { fg = colors.base08 }
		Highlights["@variable.builtin"] = { fg = colors.base08, italic = true }
		Highlights["@variable.member"] = { fg = colors.base05 }
		Highlights["@variable.member.yaml"] = { link = "Constant" }
		Highlights["@variable.parameter"] = { fg = colors.base06 }
		Highlights.zshKSHFunction = { link = "Function" }

		-- Legacy Highlights {{{
		Highlights["@conditional"] = { link = "@keyword.conditional" }
		Highlights["@define"] = { link = "@keyword.directive.define" }
		Highlights["@field"] = { link = "@variable.member" }
		Highlights["@float"] = { link = "number.float" }
		Highlights["@include"] = { link = "@keyword.import" }
		Highlights["@method"] = { link = "@function.method" }
		Highlights["@method.call"] = { link = "@function.method.call" }
		Highlights["@method.call.php"] = { link = "@function.method.call.php" }
		Highlights["@method.php"] = { link = "@function.method.php" }
		Highlights["@namespace"] = { fg = colors.base08, italic = true }
		Highlights["@parameter"] = { link = "@variable.parameter" }
		Highlights["@preproc"] = { link = "@keyword.directive" }
		Highlights["@repeat"] = { link = "@keyword.repeat" }
		Highlights["@storageclass"] = { link = "@keyword.storage" }
		Highlights["@string.regex"] = { link = "@string.regexp" }
		Highlights["@symbol"] = { link = "@string.special.symbol" }
		Highlights["@symbol.ruby"] = { link = "@string.special.symbol.ruby" }
		Highlights["@text"] = { link = "@markup" }
		Highlights["@text.danger"] = { link = "comment.error" }
		Highlights["@text.diff.add"] = { link = "@diff.plus" }
		Highlights["@text.diff.delete"] = { link = "@diff.minus" }
		Highlights["@text.emphasis"] = { link = "@markup.italic" }
		Highlights["@text.environment"] = { link = "@markup.environment" }
		Highlights["@text.environment.name"] = { link = "@markup.environment.name" }
		Highlights["@text.literal"] = { link = "@markup.raw" }
		Highlights["@text.math"] = { link = "@markup.math" }
		Highlights["@text.note"] = { link = "comment.note" }
		Highlights["@text.reference"] = { link = "@markup.link" }
		Highlights["@text.strike"] = { link = "@markup.strikethrough" }
		Highlights["@text.strong"] = { link = "@markup.strong" }
		Highlights["@text.title"] = { link = "@markup.heading" }
		Highlights["@text.title.1.markdown"] = { link = "@markup.heading.1.markdown" }
		Highlights["@text.title.2.markdown"] = { link = "@markup.heading.2.markdown" }
		Highlights["@text.title.3.markdown"] = { link = "@markup.heading.3.markdown" }
		Highlights["@text.title.4.markdown"] = { link = "@markup.heading.4.markdown" }
		Highlights["@text.title.5.markdown"] = { link = "@markup.heading.5.markdown" }
		Highlights["@text.title.6.markdown"] = { link = "@markup.heading.6.markdown" }
		Highlights["@text.todo"] = { link = "comment.warning" }
		Highlights["@text.todo.checked"] = { link = "@markup.list.checked" }
		Highlights["@text.todo.unchecked"] = { link = "@markup.list.unchecked" }
		Highlights["@text.underline"] = { link = "@markup.underline" }
		Highlights["@text.uri"] = { link = "@markup.link.url" }
		Highlights["@text.warning"] = { link = "comment.warning" }
		Highlights["@variable.member.yaml"] = { link = "@field.yaml" }
		Highlights["exception"] = { link = "@keyword.exception" }
		Highlights["text.uri"] = { link = "@markup.link.uri" }
	end
	-- }}}

	-- {{{
	Highlights.TreesitterContext = { link = "Visual" }
	Highlights.TreesitterContextBottom = { sp = colors.base05, underline = true }
	-- }}}

	-- }}}
	-- User {{{
	Highlights.User1 = { fg = colors.base08, bg = colors.base02 }
	Highlights.User2 = { fg = colors.base0E, bg = colors.base02 }
	Highlights.User3 = { fg = colors.base05, bg = colors.base02 }
	Highlights.User4 = { fg = colors.base0C, bg = colors.base02 }
	Highlights.User5 = { fg = colors.base05, bg = colors.base02 }
	Highlights.User6 = { fg = colors.base05, bg = colors.base01 }
	Highlights.User7 = { fg = colors.base05, bg = colors.base02 }
	Highlights.User8 = { fg = colors.base00, bg = colors.base02 }
	Highlights.User9 = { fg = colors.base00, bg = colors.base02 }
	-- }}}

	-- INDENT-BLANKLINE {{{
	Highlights.IndentBlanklineChar = { fg = colors.base02 }
	Highlights.IndentBlanklineContextChar = { fg = colors.base04 }
	-- }}}

	-- CMP {{{
	if not vim.tbl_contains(config.disable_groups, "cmp") then
		Highlights.CmpDocumentationBorder = { fg = colors.base05, bg = colors.base00 }
		Highlights.CmpDocumentation = { fg = colors.base05, bg = colors.base00 }
		Highlights.CmpItemAbbr = { fg = colors.base05, bg = colors.base01 }
		Highlights.CmpItemAbbrDeprecated = { fg = colors.base03 }
		Highlights.CmpItemAbbrMatch = { fg = colors.base0D }
		Highlights.CmpItemAbbrMatchFuzzy = { fg = colors.base0D }
		Highlights.CmpItemKindDefault = { fg = colors.base05 }
		Highlights.CmpItemMenu = { fg = colors.base04 }
		Highlights.CmpItemKindKeyword = { fg = colors.base0E }
		Highlights.CmpItemKindVariable = { fg = colors.base08 }
		Highlights.CmpItemKindConstant = { fg = colors.base09 }
		Highlights.CmpItemKindReference = { fg = colors.base08 }
		Highlights.CmpItemKindValue = { fg = colors.base09 }
		Highlights.CmpItemKindFunction = { fg = colors.base0D }
		Highlights.CmpItemKindMethod = { fg = colors.base0D }
		Highlights.CmpItemKindConstructor = { fg = colors.base0D }
		Highlights.CmpItemKindClass = { fg = colors.base0A }
		Highlights.CmpItemKindInterface = { fg = colors.base0A }
		Highlights.CmpItemKindStruct = { fg = colors.base0A }
		Highlights.CmpItemKindEvent = { fg = colors.base0A }
		Highlights.CmpItemKindEnum = { fg = colors.base0A }
		Highlights.CmpItemKindUnit = { fg = colors.base0A }
		Highlights.CmpItemKindModule = { fg = colors.base05 }
		Highlights.CmpItemKindProperty = { fg = colors.base08 }
		Highlights.CmpItemKindField = { fg = colors.base08 }
		Highlights.CmpItemKindTypeParameter = { fg = colors.base0A }
		Highlights.CmpItemKindEnumMember = { fg = colors.base0A }
	end
	-- }}}

	Highlights.MiniCompletionActiveParameter = "CursorLine"

	-- MINI-ICONS {{{
	Highlights.MiniIconsAzure = { fg = colors.base0D }
	Highlights.MiniIconsBlue = { fg = colors.base0D }
	Highlights.MiniIconsCyan = { fg = colors.base0C }
	Highlights.MiniIconsGreen = { fg = colors.base0B }
	Highlights.MiniIconsGrey = { fg = colors.base06 }
	Highlights.MiniIconsOrange = { fg = colors.base09 }
	Highlights.MiniIconsPurple = { fg = colors.base0E }
	Highlights.MiniIconsRed = { fg = colors.base08 }
	Highlights.MiniIconsYellow = { fg = colors.base0A }
	-- }}}

	-- COPILOT {{{
	Highlights.CopilotSuggestion = { link = "Comment" }
	-- }}}

	for _, args in pairs(Highlights) do
		if type(args) == "table" then
			if not config.enable_italic then
				args.italic = nil
			end
			if not config.enable_bold then
				args.bold = nil
			end
		end
	end

	for group, override in pairs(config.highlight_overrides or {}) do
		Highlights[group] = override
	end

	---@type string, string|vim.api.keyset.highlight
	for group, args in pairs(Highlights) do
		require("base16.utils").highlight(group, args)
	end

	if config.export_terminal_colors ~= false then
		vim.g.terminal_color_0 = colors.base00
		vim.g.terminal_color_1 = colors.base08
		vim.g.terminal_color_2 = colors.base0B
		vim.g.terminal_color_3 = colors.base0A
		vim.g.terminal_color_4 = colors.base0D
		vim.g.terminal_color_5 = colors.base0E
		vim.g.terminal_color_6 = colors.base0C
		vim.g.terminal_color_7 = colors.base05
		vim.g.terminal_color_8 = colors.base03
		vim.g.terminal_color_9 = colors.base08
		vim.g.terminal_color_10 = colors.base0B
		vim.g.terminal_color_11 = colors.base0A
		vim.g.terminal_color_12 = colors.base0D
		vim.g.terminal_color_13 = colors.base0E
		vim.g.terminal_color_14 = colors.base0C
		vim.g.terminal_color_15 = colors.base07
	end

	if config.export_base16_globals ~= false then
		vim.g.base16_00 = colors.base00
		vim.g.base16_01 = colors.base01
		vim.g.base16_02 = colors.base02
		vim.g.base16_03 = colors.base03
		vim.g.base16_04 = colors.base04
		vim.g.base16_05 = colors.base05
		vim.g.base16_06 = colors.base06
		vim.g.base16_07 = colors.base07
		vim.g.base16_08 = colors.base08
		vim.g.base16_09 = colors.base09
		vim.g.base16_0A = colors.base0A
		vim.g.base16_0B = colors.base0B
		vim.g.base16_0C = colors.base0C
		vim.g.base16_0D = colors.base0D
		vim.g.base16_0E = colors.base0E
		vim.g.base16_0F = colors.base0F
	end
end

return M
