## Welcome to my Dotfiles!

- Ensure Homebrew is installed, iterm2 is in use and you have installed things you might need (yarn, stow, neovim, git, fnm, etc.)

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

- You will need to install the Language servers you want in order to use linting and formatting. `Mason` and `mason-lspconfig` handle this in tandem - `mason-lspconfig` translates the 'normal' LS's into mason's version. To add one, add it to the 'ensure_installed' list in `lsp/mason.lua`, and call setup function on it (file has examples). This will auto install these servers on startup if they aren't already installed. For more info see these docs:
- To see installed LSPs and formatters/linters run `:Mason`.

  - mason Docs https://github.com/williamboman/mason.nvim
  - mason-lspconfig docs https://github.com/williamboman/mason-lspconfig.nvim
  - Migrating to mason from old nvim-lsp-installer https://github.com/williamboman/nvim-lsp-installer/discussions/876

- You might also want to install the relevant TREESITTER lsp for syntax highlighting for the new Language installed (`treesitter.lua` ensure_installed object [Treesitter Supported Languages] (https://github.com/nvim-treesitter/nvim-treesitter#supported-languages))
- Once installed you can format a file using the command `lua vim.lsp.buf.format({ bufnr = bufnr })` (neovim v0.8)/ `lua vim.lsp.buf.formatting_sync()` (neovim < v0.8) using the relative language server for that file.
- You can ovveride the defaults by passing in your own configs (settings dir). See `mason.lua`, `settings` dir (in lsp) and `handlers.lua` for more information.

- Null-Ls uses the native LSP to format and lint files. To add a formatter or linter it is best to go to the repo: https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins and see the builtin options for formatting and diagnostics (linting).
- Previously, you had to ensure that the specific option you require is stored as a binary on your system and in your $PATH (see below example of gofumpt). Now, `mason-null-ls` handles this for us - in the `mason.lua` file we set up LSP with `mason-lsp`, but also add the formatters/linters we want with `mason-null-ls`. [mason-nulls-ls Docs](https://github.com/jay-babu/mason-null-ls.nvim).
- Once this is done you can add it in `null-ls.lua` as a source. Note that in this file there is also format on save function set up.
- NOTE: if you add a null-ls formatter, it might start to conflict with the LSP formatter you have installed, and will ask you to choose an option everytime you save the file. To avoid this, ~~you can add a conditional in `handlers.lua` to resolve formatting for the lsp (and use null-ls instead)~~ DEPRECATED for v0.8. Instead, use lsp_formatting func in `null-ls.lua` to determine which server to use for formatting (set to null-ls as default currently)

### Example of using Null-Ls/LSP - Go

Both methods use gofumpt to format files, but null-ls enables me to format on save without manually running the format lsp command.

See this video https://www.youtube.com/watch?v=b7OguLuaYvE&t=481s about null-ls for more info.

## !!!OLD WAY OF USING NULL LS FORMATTERS!!! START

### LSP VERSION

- I have installed `gofumpt` via `go install mvdan.cc/gofumpt@latest` from https://github.com/mvdan/gofumpt in order to use gofumpt formatter with gopls lsp. Once installed, I created a `gopls.lua` settings file and followed the repo docs on adding gofumpt to this config. Now, if I run `lua vim.lsp.buf.format({ bufnr = bufnr })` (nvim > v0.8) / `lua vim.lsp.buf.formatting_sync()` (nvim < 0.8) or `<leader>fs` keymap, it will format the file with gofumpt.

### NULL-LS VERSION

- To add gofumpt to null-ls I need to install gofumpt. `go install mvdan.cc/gofumpt@latest` has done this already, but I could always use homebrew - `brew install gofumpt`. Using Homebrew would mean the binary is added to my $PATH automatically (because it's placed in `/usr/local/bin`). However, it is recommended that you use your languages package manager for each binary e.g. cargo for lua, npm for prettier etc.
- Then I added it to my `null-ls.lua` sources. ~~Finally I added a line in `handlers.lua` to turn off gopls formatting and use null-ls instead.~~
- Finally, I need to make sure `gofumpt` is added as a binary on my system. Assuming gofumpt has installed in `~/go/bin` then `export PATH="$HOME/go/bin:$PATH"` in `.zshrc` will add it to the $PATH. To check, run `echo $PATH` or `echo $path` to see which binaries are included. See this blog for more information: https://medium.com/codex/adding-executable-program-commands-to-the-path-variable-5e45f1bdf6ce

Currently, there are 3 formatters that need to be installed:

- `cargo install stylua`
- `go install mvdan.cc/gofumpt@latest`
- `npm install prettier`

You can see this list in `lua/user/lsp/null-ls.lua` under setup > sources.

## !!!OLD WAY OF USING NULL LS FORMATTERS!!! END

### Treesitter

- Handles syntax highlighting.
- For a new LSP, add the same to the `treesitter.lua` sources for syntax highlighting.
- If after updating plugins, treesitter gives the error "treesitter/highlighter Error executing lua..." run `:TSUpdate` to update the installed sources.

### Session Management

- Using the `nvim-sessions-mananger` plugin, it uses :mksession to save current sessions automatically on quit. To load last session use the keymap `<leader>ll`. To load another session use `:SessionManager load_session` and choose which one to load. See the docs for more info https://github.com/Shatur/neovim-session-manager

### Git

- Although Gitsigns has some functionality for Git, I only really use the git blame line feature. The BEST one shop stop for Git is [Vim Fugitive](https://github.com/tpope/vim-fugitive).
- Some useful quick commands:
  - `:G` or `:Git` brings up the buffer of files
  - `dv` will do a vertical diff split (`:Gvdiffsplit`) of the file
  - `dq` will close this diff split
  - `s` or `a` stages a file
  - `u` unstages a file
  - `X` resets the files changes
  - `=` expands the file the cursor is on, showing the hunks. In visual mode, you can select the hunks and then use `s` to stage that hunk
  - `cc` enters commit mode
  - `:G blame` opens a buffer of each lines changes and commits. Select a commit to see the diff in one file
  - To fix merge conflicts:
    - run `Gvdiffsplit` to open three buffers: left is the 'target', middle is working copy, and the third is the 'feature' version.
    - Whilst focused on the middle, you can use `d2o` (left) or `d3o` (right) to obtain the hunk from the "ours" or "theirs" ancestor, respectively.
    - Save and close the split. You can now commit or continue the rebase.

## ZSH

- Plugins will install automatically once zsh opened.
- It is a minimal config, with aliases, and some helper functions for installing plugins and sourcing files.
- Important commands worth noting are:

  - 'tab' to autocomplete an option when typing
  - 'shift + tab' to view all possible options in current dir

- If (when) you install Rust, it will place a `.zshenv` file with the cargo PATH inside the zsh dir of the dotfiles. This leads to some interesting behaviour where commands like `cargo` work but are also `not found`. To fix this, I've found just removing the `.zshenv` from dotfiles, and placing it in the HOME dir. Running `where cargo` for example, will now give you the correct path.

## VIM

- .vimrc has auto load plugin manager (vim plug) and auto load uninstalled plugins so it should (famous last words) be a case of just opening vim.
- Whilst nvim lives in .config, vim lives in the HOME dir for now.
- It is very simple and for emergencies more than anything

## Z and Zprofile

- Defines some root paths
- Lives in the HOME dir
