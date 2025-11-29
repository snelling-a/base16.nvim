# base16.nvim

Neovim plugin for building base16 colorschemes with support for Neovim's builtin LSP and Treesitter.

- [vim-illuminate](https://github.com/RRethy/vim-illuminate) like reference highlighting

## Installation

### With [pckr.nvim](https://github.com/lewis6991/pckr.nvim)

```lua
use {
  "snelling-a/base16.nvim",
  run = ":Base16Update"
  config = function()
    vim.cmd.colorscheme("base16-default-dark")
  end
}
```

### With [Lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
  "snelling-a/base16.nvim",
  build = ":Base16Update",
  priority = 1000,
  lazy = false,
  config = function()
    vim.cmd.colorscheme("base16-default-dark")
  end,
}
```

### With [vim.pack](https://neovim.io/doc/user/pack.html#vim.pack)

Neovim's built-in plugin manager (`vim.pack`) is available for early testing in recent Neovim versions. To install base16.nvim using `vim.pack`, add the following to your `init.lua`:

```lua
vim.pack.add({
  'https://github.com/snelling-a/base16.nvim',
})
vim.cmd.colorscheme("base16-default-dark")
```

```vim
:Base16Update
```

---

## Updating Colorschemes

- **pckr.nvim/Lazy.nvim:** The build step runs automatically after every update.
- **vim.pack:** You must manually run `:Base16Update` after updating the plugin.
- **Native package manager:** You must manually run `:Base16Update` after updating the plugin.
- **All plugin managers:** You can always run `:Base16Update` at any time to refresh the colorschemes.

---

## Usage

After installation and building, use any colorscheme with:

```vim
:colorscheme base16-<name>
```

Replace `<name>` with the desired scheme (e.g., `base16-gruvbox-dark-hard`).

## Configuration

You can configure base16.nvim globally and (optionally) apply a colorscheme by calling:

```lua
require("base16").setup({
  colorscheme = "gruvbox-dark-hard", -- or a palette table
  highlight_overrides = {
    Normal = { fg = "#ffffff", bg = "#000000" },
  },
  disable_groups = { "dap", "lsp", "rainbow", "treesitter" },
  enable_italic = false,
  enable_bold = true,
  export_terminal_colors = false, -- set to true to enable terminal color theming
  export_base16_globals = false, -- set to true to enable global base16_XX variables
  diagnostic_underline_style = "undercurl", -- or "underdotted", "underdashed", "underline"
  spell_underline_style = nil, -- or "undercurl", "underdotted", "underdashed", "underline"
})
```

- **colorscheme**: (optional) Name or palette table to apply immediately.
- **highlight_overrides**: Table of highlight group overrides (applied after the theme).
- **disable_groups**: List of group categories to skip. Supported: `"dap"`, `"lsp"`, `"rainbow"`, `"treesitter"`, `"cmp"`.
- **enable_italic**, **enable_bold**: Booleans to globally enable/disable these styles.
- **export_terminal_colors**: If `true`, sets Neovim's `vim.g.terminal_color_*` variables to match the colorscheme for terminal buffers. Default: `false` (use your terminal emulator's default colors).
- **export_base16_globals**: If `true`, sets Neovim's `vim.g.base16_00` ... `vim.g.base16_0F` variables globally to the current palette. Default: `false` (does not set globals).
- **diagnostic_underline_style**: Underline style for diagnostics. Valid values: `"undercurl"`, `"underdotted"`, `"underdashed"`, `"underline"`. Default: `"undercurl"`.
- **spell_underline_style**: Underline style for spelling. Valid values: `"undercurl"`, `"underdotted"`, `"underdashed"`, `"underline"`. Default: `nil` (no underline).

## Builtin Colorschemes

See the full gallery of base16 colorschemes at:
[https://tinted-theming.github.io/tinted-gallery/](https://tinted-theming.github.io/tinted-gallery/)

### credit

[RRethy](https://github.com/RRethy) for the original highlighting: [RRrethy/nvim-base16](https://github.com/RRethy/nvim-base16)
