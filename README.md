# Cabin.nvim

**Warning: This is a temporary plugin, and should only really be used by Cabin compiler developers.**

A (temporary) plugin for setting up Neovim for Cabin development. This plugin handles the following:

- Filetype detection & [devicon](https://github.com/nvim-tree/nvim-web-devicons) setup for Cabin files
- Installation & implementation for [the TreeSitter parser for Cabin](https://github.com/cabin-language/tree-sitter-cabin), enabling syntax highlighting
- Installation & setup for [the Cabin Language Server](https://github.com/cabin-language/cabin-language-server)

## Installation

With `lazy.nvim`:

```lua
{
	"cabin-language/cabin.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter", -- optional
		"nvim-tree/nvim-web-devicons", --optional
	},
	opts = {}
}
```

If you choose not to install Tree-sitter, the parser and syntax highlighter will not be set up.
If you choose not to install devicons, the icons will not be set up.

## Plugin Status

This plugin will be archived and eventually deleted when the following criteria are met:

- [ ] [The TreeSitter parser for Cabin](https://github.com/cabin-language/tree-sitter-cabin) is available in [the official Neovim TreeSitter plugin](https://github.com/nvim-treesitter/nvim-treesitter)
- [ ] [the Cabin Language Server](https://github.com/cabin-language/cabin-language-server) is available in [mason.nvim](https://github.com/williamboman/mason.nvim)
- [ ] Cabin's icons and colors are merged into [devicons](https://github.com/nvim-tree/nvim-web-devicons)
