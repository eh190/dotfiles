## Welcome to my Dotfiles!

- Ensure Homebrew is install, iterm2 is in use and you have brew installed things you might need (yarn, stow, neovim etc.)

- Clone down this repo into the HOME directory
- cd ~/dotfiles
- run `stow */` to add all files to relative paths, or `stow dir_name` to add just one folder.
- Folders will be placed relative to the internal folder structure e.g. in dotfiles/nvim/.config/nvim -> nvim will be placed in ~/.config/nvim

Youtube vid explaining stow use https://www.youtube.com/watch?v=90xMTKml9O0&t=371s

## NVIM

- Install Vim Plug for Nvim

`curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim`

- CocInstall LSP support for all files in `coc-settings.json`
  https://github.com/neoclide/coc.nvim
  https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions

## ZSH

- Plugins will install automatically once zsh opened.

## VIM

- .vimrc has auto load plugin manager (vim plug) and auto load uninstalled plugins so it should (famous last words) be a case of just opening vim.
- Whilst nvim lives in .config, vim lives in the HOME dir for now.
