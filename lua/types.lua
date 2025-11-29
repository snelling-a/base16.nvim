---@meta

---@alias DisableGroup "dap" | "lsp" | "rainbow" | "treesitter" | "cmp" |
---@alias UnderlineStyle "undercurl"|"underline"|"underdotted"|"underdashed"|nil

---@class Base16Config
---@field colorscheme? string|Colorscheme
-- Style for diagnostic underlines, set to nil to disable
---@field diagnostic_underline_style? UnderlineStyle
---@field disable_groups? DisableGroup[]
---@field enable_bold? boolean
---@field enable_italic? boolean
-- If true, set vim.g.base16_00..0F (default: false)
---@field export_base16_globals? boolean
---@field highlight_overrides? Highlights
-- If true, set vim.g.terminal_color_* (default: false)
---@field export_terminal_colors? boolean
-- Style for spellcheck underlines, set to nil to disable
---@field spell_underline_style? UnderlineStyle

---@class Colorscheme
---@field base00 string -- Default Background
---@field base01 string -- Lighter Background (Used for status bars, line number and folding marks)
---@field base02 string -- Selection Background
---@field base03 string -- Comments, Invisibles, Line Highlighting
---@field base04 string -- Dark Foreground (Used for status bars)
---@field base05 string -- Default Foreground, Caret, Delimiters, Operators
---@field base06 string -- Light Foreground (Not often used)
---@field base07 string -- Light Background (Not often used)
---@field base08 string -- Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
---@field base09 string -- Integers, Boolean, Constants, XML Attributes, Markup Link Url
---@field base0A string -- Classes, Markup Bold, Search Text Background
---@field base0B string -- Strings, Inherited Class, Markup Code, Diff Inserted
---@field base0C string -- Support, Regular Expressions, Escape Characters, Markup Quotes
---@field base0D string -- Functions, Methods, Attribute IDs, Headings
---@field base0E string -- Keywords, Storage, Selector, Markup Italic, Diff Changed
---@field base0F string -- Deprecated, Opening/Closing Embedded Language Tags, e.g. <?php ?>

---@alias Highlights table<string,string|vim.api.keyset.highlight>
