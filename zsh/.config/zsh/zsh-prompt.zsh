#!/bin/sh

# WOEFE GIT PROMPT
#source woefe/git-prompt. Gives us a fully fleshed out git prompt
source $ZDOTDIR/plugins/git-prompt.zsh/git-prompt.zsh 
# woefe/git-prompt customisation. See https://github.com/woefe/git-prompt.zsh for docs
# ZSH_THEME_GIT_PROMPT_PREFIX="%F{green}%f"
# ZSH_THEME_GIT_PROMPT_SUFFIX=" "
# ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg_bold[green]%}"
# ZSH_THEME_GIT_PROMPT_SEPARATOR=""
# ZSH_THEME_GIT_PROMPT_STAGED=" %B%{$fg[yellow]%}✚"
# ZSH_THEME_GIT_PROMPT_UNSTAGED=" %B%{$fg[yellow]%}!"
# ZSH_THEME_GIT_PROMPT_UNTRACKED=" %B%{$fg[blue]%}?"
# ZSH_GIT_PROMPT_SHOW_STASH=1
# ZSH_THEME_GIT_PROMPT_STASHED=" %{$fg[blue]%}⚑"
# ZSH_THEME_GIT_PROMPT_BEHIND=" %{$fg_bold[red]%}↓"
# ZSH_THEME_GIT_PROMPT_AHEAD=" %{$fg_bold[green]%}↑"
# ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg_bold[green]%}✔"
# # Prompt using woefe/git-prompt.zsh
# PROMPT='%(?:%{$fg[green]%}➜ :%{$fg[red]%}➜ )%B%F{blue}%~%f $(gitprompt)%b'


# ROBBY RUSSELL USING WOEFE PROMPT
ZSH_GIT_PROMPT_SHOW_UPSTREAM="no"
ZSH_GIT_PROMPT_SHOW_TRACKING_COUNTS=0
ZSH_GIT_PROMPT_SHOW_LOCAL_COUNTS=0
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg_bold[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX=" "
ZSH_THEME_GIT_PROMPT_UNSTAGED="%{$fg_bold[blue]%}) %{$fg[yellow]%}%1{✗%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
ZSH_THEME_GIT_PROMPT_SEPARATOR=""
ZSH_THEME_GIT_PROMPT_DETACHED=""
ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg_bold[red]%}"
ZSH_THEME_GIT_PROMPT_UPSTREAM_SYMBOL=""
ZSH_THEME_GIT_PROMPT_UPSTREAM_NO_TRACKING=""
ZSH_THEME_GIT_PROMPT_UPSTREAM_PREFIX=""
ZSH_THEME_GIT_PROMPT_UPSTREAM_SUFFIX=""
ZSH_THEME_GIT_PROMPT_BEHIND=""
ZSH_THEME_GIT_PROMPT_AHEAD=""
ZSH_THEME_GIT_PROMPT_UNMERGED=""
ZSH_THEME_GIT_PROMPT_STAGED=""
ZSH_THEME_GIT_PROMPT_UNTRACKED=""
ZSH_THEME_GIT_PROMPT_STASHED=""
ZSH_THEME_GIT_PROMPT_CLEAN=""

PROMPT='%(?:%{$fg[green]%}➜ :%{$fg[red]%}➜ )%B%F{cyan}%~%f $(gitprompt)%b'


# Right prompt
# RPROMPT='%{$fg[white]%}%*'

# TODO look into this for more colors
# https://stevelosh.com/blog/2010/02/my-extravagant-zsh-prompt/
# also ascii escape codes


# VCS INFO PROMPT
# ## autoload vcs and colors
# autoload -Uz vcs_info
# autoload -U colors && colors

# # enable only git 
# zstyle ':vcs_info:*' enable git 

# # setup a hook that runs before every ptompt. 
# precmd_vcs_info() { vcs_info }
# precmd_functions+=( precmd_vcs_info )
# setopt prompt_subst

# # add a function to check for untracked files in the directory.
# # from https://github.com/zsh-users/zsh/blob/master/Misc/vcs_info-examples
# zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
# # 
# +vi-git-untracked(){
#     if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
#         git status --porcelain | grep '??' &> /dev/null ; then
#         # This will show the marker if there are any untracked files in repo.
#         # If instead you want to show the marker only if there are untracked
#         # files in $PWD, use:
#         #[[ -n $(git ls-files --others --exclude-standard) ]] ; then
#         hook_com[staged]+='!' # signify new files with a bang
#     fi
# }

# #vcs_info for git prompt
# zstyle ':vcs_info:*' check-for-changes true
# zstyle ':vcs_info:*' unstagedstr '!'
# zstyle ':vcs_info:*' stagedstr '+'
# zstyle ':vcs_info:git:*' actionformats '(%b|%a%u%c)'
# # zstyle ':vcs_info:git:*' formats " %r/%S %b %m%u%c "
# zstyle ':vcs_info:git:*' formats " %{$fg[blue]%}(%{$fg[yellow]%}%{$fg[magenta]%} %b%{$fg[blue]%})%F{yellow}%m%f %F{red}%u%f %F{green}%c%f"


# format our main prompt for hostname current folder, and permissions.
# These are alternative prompts and combinations
# PROMPT="%B%{$fg[blue]%}[%{$fg[white]%}%n%{$fg[red]%}@%{$fg[white]%}%m%{$fg[blue]%}] %(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )%{$fg[cyan]%}%c%{$reset_color%}"
#PROMPT="%B%{$fg[blue]%}[%{$fg[white]%}ed%{$fg[red]%}-%{$fg[white]%}hughes%{$fg[blue]%}] %(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )%{$fg[cyan]%}%c%{$reset_color%}"
# PROMPT="%{$fg[green]%}%n@%m %~ %{$reset_color%}%#> "

# Prompt using vcs_info
# PROMPT='%B%{$fg[blue]%}[%{$fg[white]%}%n%{$fg[blue]%}] %F{blue}%~%f '
# PROMPT+="\$vcs_info_msg_0_ "

