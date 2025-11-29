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

## Builtin Colorschemes

See the full gallery of base16 colorschemes at:
[https://tinted-theming.github.io/tinted-gallery/](https://tinted-theming.github.io/tinted-gallery/)

### credit

[RRethy](https://github.com/RRethy) for the original highlighting: [RRrethy/nvim-base16](https://github.com/RRethy/nvim-base16)
