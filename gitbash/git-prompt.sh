   # git-prompt.sh should be symlinked to ~/.config/git
   
   # You may need to clone down this package from https://github.com/romkatv/gitstatus
   source ~/gitstatus/gitstatus.prompt.sh

	# Original in Program Files/Git/etc/profile.d for reference.
	# This file overwrites the above, and bashrc can overwrite this
	
  # PS1='\[\033]0;$TITLEPREFIX:$PWD\007\]' # set window title
	# PS1="$PS1"'\n'                 # new line
	# PS1="$PS1"'\[\033[32m\]'       # change to green
	# PS1="$PS1"'\u@\h '             # user@host<space>
	# PS1="$PS1"'\[\033[35m\]'       # change to purple
	# PS1="$PS1"'$MSYSTEM '          # show MSYSTEM
	# PS1="$PS1"'\[\033[33m\]'       # change to brownish yellow
	# PS1="$PS1"'\w'                 # current working directory

	# Prebuilt Git logic - replaced with gitstatus.prompt package (which gives status)
	#
	# if test -z "$WINELOADERNOEXEC"
	# then
	# 	GIT_EXEC_PATH="$(git --exec-path 2>/dev/null)"
	# 	COMPLETION_PATH="${GIT_EXEC_PATH%/libexec/git-core}"
	# 	COMPLETION_PATH="${COMPLETION_PATH%/lib/git-core}"
	# 	COMPLETION_PATH="$COMPLETION_PATH/share/git/completion"
	# 	if test -f "$COMPLETION_PATH/git-prompt.sh"
	# 	then
	# 		. "$COMPLETION_PATH/git-completion.bash"
	# 		. "$COMPLETION_PATH/git-prompt.sh"
	# 		PS1="$PS1"'\[\033[36m\]'  # change color to cyan
	# 		PS1="$PS1"'`__git_ps1`'   # bash function
	# 	fi
	# fi

# EXPERIMENTS IN GIT STATUS LINE
# export GIT_PS1_SHOWDIRTYSTATE=1
# export GIT_PS1_SHOWSTASHSTATE=1
# export GIT_PS1_SHOWUNTRACKEDFILES=1
# export GIT_PS1_DESCRIBE_STYLE='contains'
# export GIT_PS1_SHOWUPSTREAM='auto'  
#   function __fastgit_ps1 () {
#     branch=""

#     local headfile head branch
#     local dir="$PWD"

#     while [ -n "$dir" ]; do
#         if [ -e "$dir/.git/HEAD" ]; then
#             headfile="$dir/.git/HEAD"
#             break
#         fi
#         dir="${dir%/*}"
#     done

#     if [ -e "$headfile" ]; then
#         read -r head < "$headfile" || return
#         case "$head" in
#             ref:*) branch="${head##*/}" ;;
#             "") branch="" ;;
#             *) branch="${head:0:7}" ;;  #Detached head. You can change the format for this too.
#         esac
#     fi

#     if [ ! -z "$branch" ]; then
#         branch="($branch)"
#     fi

#     # Edit to suit your needs. Note the branch will be wrapped in parenthesis if it's set. Completely empty otherwise.
#     export PS1="$PS1"'\[\e[33m\]\w\[\e[0m\] \[\033[36m\]$branch\[\033[0m\]'
#     }
# export PROMPT_COMMAND=__fastgit_ps1

# function parse_git_dirty {
#   [[ $(git status --porcelain 2> /dev/null) ]] && echo "*"
# }
# function parse_git_branch {
#   git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/ (\1$(parse_git_dirty))/"
# }
	
# PROMPT
  PS1='\[\033]0;$TITLEPREFIX:$PWD\007\]' # set window title
	PS1="$PS1"'\n'                 # new line
	PS1="$PS1"'\t '                # time
  PS1="$PS1"'\[\033[38;5;74;1m\]'       # change to blue
	# PS1="$PS1"'[edhughes] '        # could be username @host 
  # PS1="$PS1"'\[\033[38;5;39m\]'       # change to bright electric blue
	PS1="$PS1"'\w'                 # current working directory
	# PS1="$PS1"'\n'                 # new line
	PS1="$PS1"' ${GITSTATUS_PROMPT} '    # use the git status prompt package -- this is the fastest way
  # PS1="$PS1"'$(parse_git_branch)'
	PS1="$PS1"'\[\033[38;5;46;1m\]'       # change to bole green
	PS1="$PS1"'❯ '                 # prompt: always ❯ 
	PS1="$PS1"'\[\033[97m\]'       # change to white
