# My Neovim Configuration

A modular Neovim setup based on [kickstart-modular.nvim](https://github.com/dam9000/kickstart-modular.nvim) and heavily customized. The major inspirations are [LazyVim](https://github.com/lazyvim/lazyvim) and [AstroNvim](https://github.com/astronvim/astronvim).

## Requirements

- Neovim 0.12+ (latest stable or nightly)
- Git, make, unzip, C compiler (gcc)
- A Nerd Font (I use [Lilex](https://github.com/mishamyrt/Lilex))
- Runtimes & utilities:
  - [Ripgrep](https://github.com/BurntSushi/ripgrep) and [fd-find](https://github.com/sharkdp/fd)
  - Node.js
  - tree-sitter-cli npm library
  - go
  - python & pipx
  - rust
  - dotnet

I like to use [mise](https://mise.jdx.dev/dev-tools/) to manage my dependencies. If you use mise as well, add these to your global config:

```toml
[tools]
fd = "latest"
ripgrep = "latest"
node = "latest"
"npm:tree-sitter-cli" = "latest"
go = "latest"
python = "latest"
pipx = "latest"
rust = "nightly"
dotnet = "latest"
```

Remember to run `:checkhealth` and see if there is something you're missing.

## Language support

The language-related stuff mostly lives in `lua/plugins/lang`. Basic configs for language-related plugins are in the files that start with `_` and `{language name}.lua` files are modules extending those configs for each specific language. The language tools (linters, formatters, etc) are managed via Mason and will be autoinstalled on first launch.
LSP configs are loaded with `nvim-lspconfig` and can be extended in the `after/lsp` directory.

## Structure

```text
nvim/
├── init.lua                           # Entry point, loads all modules
├── lua/
│   ├── lazy-setup.lua                 # Lazy.nvim bootstrap and plugin spec
│   ├── options.lua                    # Neovim settings
│   ├── autocmds.lua                   # Autocommands
│   ├── utils.lua                      # Utility functions
│   ├── keymaps/                       # Keymaps organized by category
│   │   ├── common.lua                 # General keymaps
│   │   ├── lsp.lua                    # LSP navigation and actions
│   │   ├── toggles.lua                # Toggle options
│   │   ├── pickers.lua                # Snacks pickers
│   │   └── buffers-windows-tabs.lua   # Managing buffers, windows and tabs
│   └── plugins/                       # Plugins organized by category
│       ├── ui/                        # Anyting that affects visuals/presentation
│       ├── editing/                   # Text editing
│       ├── git/                       # Git integrations
│       ├── lang/                      # Language support (LSP, DAP, etc)
│       ├── ai/                        # AI stuff
│       └── session.lua                # Session management
└── after/lsp/                         # LSP server customizations (applied on top of nvim-lspconfig)
```
