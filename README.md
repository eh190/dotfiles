## Welcome to my Dotfiles!

At some point this will include install scripts to make this process easier, as there are problems that are not covered here that I just fix as they occur (languages or cli tools not installed for example that prevent other things being installed).

### Required installs:

My preference is to use iterm2 (mac) or Windows Terminal (with GitBash/WSL profiles) (windows).

### OS Agnositc:

- Package Manager (Homebrew/apt/chocolatey)
- fnm (node)
- neovim
- ripgrep (required for telescope grep)
- fzf

### \*nix OS (including WSL):

- stow (for symlinking dotfiles)
- git

- Clone down this repo into the HOME directory
- cd ~/dotfiles
- run `stow */` to add all files to relative paths, or `stow dir_name` to add just one folder.
- Folders will be placed relative to the internal folder structure e.g. in dotfiles/nvim/.config/nvim -> nvim will be placed in ~/.config/nvim

Youtube vid explaining stow use https://www.youtube.com/watch?v=90xMTKml9O0&t=371s

### Windows:

- GitBash

- Clone down this repo into the HOME directory
- Clone down this git status prompt: https://github.com/romkatv/gitstatus
- Setup Neovim following this: https://blog.nikfp.com/how-to-install-and-set-up-neovim-on-windows
- cd ~/dotfiles
- Symlink .bashrc to ~/.bashrc (`mklink /D C:\Users\<user>\.bashrc C:\Users\<user>\dotfiles\gitbash\.bashrc`)
- Symlink git-prompt to ~/.config/git/git-prompt.sh (`mklink /D C:\Users\<user>\.config\git\git-prompt.sh C:\Users\<user>\dotfiles\gitbash\git-prompt.sh`)
- Symlink nvim dir to ~/AppData/Local/nvim (`mklink /D C:\Users\<user>\AppData\Local\nvim C:\Users\<user>\dotfiles\nvim\.config\nvim`)

## NVIM

- This is my lua config
- Uses Packer as the plug in manager. This should self install on start up if not already installed, and install/update any plugins with file changes. Run `:PackerInstall` to manually install, or `:PackerClean` to remove plugins
- Docs: https://github.com/wbthomason/packer.nvim

### LSP 

- You will need to install the Language servers you want in order to use linting, formatting, and other language specific features. `Mason` and `mason-lspconfig` handle this in tandem - `mason-lspconfig` translates between `nvim-lspconfig` and mason's versions. To add one, add it to the 'ensure_installed' list in `lsp/mason.lua`, and call setup function on it (file has examples). This will auto install these servers on startup if they aren't already installed.
- To see installed LSPs and formatters/linters run `:Mason`.

  - mason Docs https://github.com/williamboman/mason.nvim
  - mason-lspconfig docs https://github.com/williamboman/mason-lspconfig.nvim
  - Migrating to mason from old nvim-lsp-installer https://github.com/williamboman/nvim-lsp-installer/discussions/876

- You might also want to install the relevant TREESITTER lsp for syntax highlighting for the new Language installed (`treesitter.lua` ensure_installed object [Treesitter Supported Languages] (https://github.com/nvim-treesitter/nvim-treesitter#supported-languages))
- Once installed you can format a file using the command `lua vim.lsp.buf.format({ bufnr = bufnr })` (neovim v0.8)/ `lua vim.lsp.buf.formatting_sync()` (neovim < v0.8) using the relative language server for that file.
- You can ovveride the defaults by passing in your own configs (settings dir). See `mason.lua`, `settings` dir (in lsp) and `handlers.lua` for more information.
- To use another formatter, such as Prettier, you can install the binary (using relative package manager is best) and then use the keymap(s) to format using a binary (keymaps file)
- Lots of LSPs now format e.g. rust uses rustfmt, c using clang-format, go uses gopls or, as I've set up, gofumpt so you don't need to install those (just use the LSP)

### Null-Ls (currently not maintained)

- Null-Ls uses the native LSP to format and lint files. To add a formatter or linter it is best to go to the repo: https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins and see the builtin options for formatting and diagnostics (linting).
- Previously, you had to ensure that the specific option you require is stored as a binary on your system and in your $PATH. Now, `mason-null-ls` handles this for us - in the `mason.lua` file we set up LSP with `mason-lsp`, but also add the formatters/linters we want with `mason-null-ls`. [mason-nulls-ls Docs](https://github.com/jay-babu/mason-null-ls.nvim).
- Once this is done you can add it in `null-ls.lua` as a source. This is currently possible to do in `mason-null-ls` during setup - you can pass a handler function and add null-ls formatters there instead of doing in null-ls. Note that in this file there is also format on save function set up.
- NOTE: if you add a null-ls formatter, it might start to conflict with the LSP formatter you have installed, and will ask you to choose an option everytime you save the file. To avoid this, ~~you can add a conditional in `handlers.lua` to resolve formatting for the lsp (and use null-ls instead)~~ DEPRECATED for v0.8. Instead, use lsp_formatting func in `null-ls.lua` to determine which server to use for formatting (set to null-ls as default currently)

### Treesitter

- Handles syntax highlighting.
- For a new LSP, add the same to the `treesitter.lua` sources for syntax highlighting, or use TSInstall <source-name> to manually add.
- TSInstallInfo brings up all available sources, and their install status
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
  - Whilst in either expanded mode or in vdiffsplit, pressing `[c` and `]c` moves between hunks
  - `cc` enters commit mode
  - `:G blame` opens a buffer of each lines changes and commits. Select a commit to see the diff in one file
  - To fix merge conflicts:
    - I always operate out of the status window which you can get to from just :G. This will show the status including the conflicts.
    - Press dd on the file you want to deconflict.
    - Use ]c and [c to jump between conflict markers. I can rip through files that have lots of conflicts with this.
    - By default, dd should give you a vertical 3-way split. But if you want to force vertical, use dv or use dh for horizontal (ds also works if you prefer the "split" mnemonic).
    - Use the middle pane to view and navigate. Everything should scroll together automatically because of :set scrollbind being enabled by Fugitive.
    - The left pane is numbered 2 and the right pane is numbered 3 (you're in number 1). So use d2o or d3o to "obtain" from either 2 or 3. Remember with the mnemonic "Diff 2 Obtain" and "Diff 3 Obtain".
    - If you want to just use one entire side, move your cursor to that side with <Ctrl-w> h, for example. Then do :Gwrite!.

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

### Some VIM Commands

Vim commands

i = insert left of cursor
a = insert right of cursor
I = insert first non whitespace char left
A = insert end of line regardless of whitespace chars

o = insert new line below and insert
O = insert new line above and insert

yy = yank (copy) line
dd = delte line
x = delete char
p = paste below (if whole line), or paste in line if not
P = paste above

yap = yank set of contiguous code

w,b = word jump navigation
u = undo

:Ex = back to file tree
:Vex = vertical split explore
:Sex = horizontal split explore

Ctrl + w = windows mode. This + l = go to the window on the right (assuming two vertical windows e.g.)

Ctrl + w + o = close all windows except current window (buffer)

\_ = go to first non space character of line
0 = go to beginning of line
$ = end of line
D or d$ = deletes from cursor to end of line
C = deletes to end of line and inserts
cc = deletes and goes into insert
S = delete whole line, go into insert mode
s = delete character and into insert mode
f + letter = jump to first instance of that capital letter. ‘;’ goes to next instance of letter, ',' goes to prev
F = f but in reverse. 

{ = jump to paragraph above (non contiguous code)
} = jump to paragraph below (non contiguous code)
Ctrl + d = jump half a page
Ctrl + u = jump up half a page
% = jump between bracket pairs

ci{ = delete contents of brackets and insert mode

:bn = buffer next
:bp = buffer previous
:b <name of file> = select specific buffer
:ls = list open buffers
:tabnew % = create new tab based on current buffer
gt = switch tabs

Ctrl x + ctrl o = autocomplete in insert mode

/searchterm = search in current file. n to go to next, N to go back one instance.
:noh removes search highlight
:%s/term/newTerm = search and replace on entire file
Visual mode highlight a region, then “:” to begin a visual range search and replace. From here we can type:

    - “s/term/newTerm” (will replace first instance on each line),
    - or “s/term/newTerm/g” to replace all instance in the range,
    - or “s/term/newTerm/gc to decide for each instance whether to replace.

d = create new directory (if in file tree)
% = create new file (if in file tree)

## Z and Zprofile

- Defines some root paths
- Lives in the HOME dir
