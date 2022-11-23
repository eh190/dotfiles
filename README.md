## Welcome to my Dotfiles!

- Ensure Homebrew is installed, iterm2 is in use and you have brew installed things you might need (yarn, stow, neovim, git, fnm, etc.)

- Clone down this repo into the HOME directory
- cd ~/dotfiles
- run `stow */` to add all files to relative paths, or `stow dir_name` to add just one folder.
- Folders will be placed relative to the internal folder structure e.g. in dotfiles/nvim/.config/nvim -> nvim will be placed in ~/.config/nvim

Youtube vid explaining stow use https://www.youtube.com/watch?v=90xMTKml9O0&t=371s

## NVIM

- This is my lua config
- Uses Packer as the plug in manager. This should self install on start up if not already installed, and install/update any plugins with file changes. Run `:PackerInstall` to manually install, or `:PackerClean` to remove plugins
- Docs: https://github.com/wbthomason/packer.nvim

### LSP and Null-Ls

- You will need to install the Language servers you want in order to use linting and formatting. `Mason` and `mason-lspconfig` handle this in tandem - `mason-lspconfig` translates the 'normal' LS's into mason's version. To add one, add it to the 'ensure_installed' list in lsp/mason.lua, and call setup function on it (file has examples). For more info see these docs:

  - mason Docs https://github.com/williamboman/mason.nvim
  - mason-lspconfig docs https://github.com/williamboman/mason-lspconfig.nvim
  - Migrating to mason from old nvim-lsp-installer https://github.com/williamboman/nvim-lsp-installer/discussions/876

- Once installed you can format a file using the command `lua vim.lsp.buf.format({ bufnr = bufnr })` (neovim v0.8)/ `lua vim.lsp.buf.formatting_sync()` (neovim < v0.8) using the relative language server for that file.
- You can ovveride the defaults by passing in your own configs (settings dir). See `mason.lua`, `settings` dir (in lsp) and `handlers.lua` for more information.

- Null-Ls uses the native LSP to format and lint files. To add a formatter or linter it is best to go to the repo: https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins and see the builtin options for formatting and diagnostics (linting). You need to ensure that the specific option you require is stored as a binary on your system and in your $PATH. Once this is done you can add it in `null-ls.lua` as a source. Note that in this file there is also format on save function set up.
- NOTE: if you add a null-ls formatter, it might start to conflict with the LSP formatter you have installed, and will ask you to choose an option everytime you save the file. To avoid this, ~~you can add a conditional in `handlers.lua` to resolve formatting for the lsp (and use null-ls instead)~~ DEPRECATED for v0.8. Instead, lsp_formatting func in `null-ls.lua` to determine whihc server to use for formatting (set to null-ls as default currently)

### Example of using Null-Ls - Go

### LSP VERSION

- I have installed `gofumpt` via `go install mvdan.cc/gofumpt@latest` from https://github.com/mvdan/gofumpt in order to use gofumpt formatter with gopls lsp. Once installed, I created a `gopls.lua` settings file and followed the repo docs on adding gofumpt to this config. Now, if I run `lua vim.lsp.buf.format({ bufnr = bufnr })` (nvim > v0.8) / `lua vim.lsp.buf.formatting_sync()` (nvim < 0.8) or `<leader>fs` keymap, it will format the file with gofumpt.

### NULL-LS VERSION

- To add gofumpt to null-ls I needed to install the binary to my $PATH. So I used homebrew: `brew install gofumpt`. Then I added it to my `null-ls.lua` sources. ~~Finally I added a line in `handlers.lua` to turn off gopls formatting and use null-ls instead.~~
- Both methods use gofumpt to format files, but null-ls enables me to format on save without manually running the format lsp command.

### Session Management

- Using the `nvim-sessions-mananger` plugin, it uses :mksession to save current sessions automatically on quit. To load last session use the keymap `<leader>ll`. To load another session use `:SessionManager load_session` and choose which one to load. See the docs for more info https://github.com/Shatur/neovim-session-manager

## ZSH

- Plugins will install automatically once zsh opened.
- It is a minimal config, with aliases, and some helper functions for installing plugins and sourcing files.
- Important commands worth noting are:
  - <tab> to autocomplete an option when typing
  - <shift><tab> to view all possible options in current dir

## VIM

- .vimrc has auto load plugin manager (vim plug) and auto load uninstalled plugins so it should (famous last words) be a case of just opening vim.
- Whilst nvim lives in .config, vim lives in the HOME dir for now.
- It is very simple and for emergencies more than anything

## Z and Zprofile

- Defines some root paths
- Lives in the HOME dir
