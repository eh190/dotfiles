 # git-prompt.sh should be symlinked to ~/.config/git
 
 # You may need to clone down this package from https://github.com/romkatv/gitstatus
 source ~/gitstatus/gitstatus.prompt.sh

# Original in Program Files/Git/etc/profile.d for reference.
# This file overwrites the above, and bashrc can overwrite this

# PS1='\[\033]0;$TITLEPREFIX:$PWD\007\]' # set window title
# PS1="$PS1"'\n'                         # new line
# PS1="$PS1"'\[\033[32m\]'               # change to green
# PS1="$PS1"'\u@\h '                     # user@host<space>
# PS1="$PS1"'\[\033[35m\]'               # change to purple
# PS1="$PS1"'$MSYSTEM '                  # show MSYSTEM
# PS1="$PS1"'\[\033[33m\]'               # change to brownish yellow

# PS1="$PS1"'\[\033[38;5;39m\]'          # change to bright electric blue
# PS1="$PS1"'\[\033[38;5;74;1m\]'        # change to blue
# PS1="$PS1"'\[\033[38;5;46;1m\]'        # change to bole green
# PS1="$PS1"'\w'                         # current working directory
# PS1="$PS1"'❯ '                         # prompt: always ❯ 
# PS1="$PS1"'\[\033[97m\]'               # change to white

# Prebuilt Git logic - replaced with gitstatus.prompt package (which gives status)
# 	if test -z "$WINELOADERNOEXEC"
# 	then
# 		GIT_EXEC_PATH="$(git --exec-path 2>/dev/null)"
# 		COMPLETION_PATH="${GIT_EXEC_PATH%/libexec/git-core}"
# 		COMPLETION_PATH="${COMPLETION_PATH%/lib/git-core}"
# 		COMPLETION_PATH="$COMPLETION_PATH/share/git/completion"
# 		if test -f "$COMPLETION_PATH/git-prompt.sh"
# 		then
#       echo "$COMPLETION_PATH"
# 			. "$COMPLETION_PATH/git-completion.bash"
# 			. "$COMPLETION_PATH/git-prompt.sh"
#       PS1='\[\033]0;$TITLEPREFIX:$PWD\007\]' # set window title. why do I need this?
#       PS1="$PS1"'\[\e[32m\]➜  \[\033[38;5;74;1m\]\w'
#       PS1="$PS1"'\[\e[31m\]`__git_ps1` \[\e[31m\]\[\e[m\]'   # bash function
# 		fi
# 	fi
# GIT_PS1_DESCRIBE_STYLE='contains'
# GIT_PS1_SHOWCOLORHINTS='y'
# GIT_PS1_SHOWDIRTYSTATE='y'
# GIT_PS1_SHOWSTASHSTATE='y'
# GIT_PS1_SHOWUNTRACKEDFILES='y'
# GIT_PS1_SHOWUPSTREAM='auto'

# Robby Russell theme in bash (functions)
 function git_exist_first() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		echo "git:("
	else
		echo ""
	fi
}

function git_exist_last() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		echo ")"
	else
		echo ""
	fi
}

# get current branch in git repo
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		echo "${BRANCH}"
	else
		echo ""
	fi
}

function parse_git_status() {
	STAT=`parse_git_dirty`
	if [ ! "${STAT}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo " ✗"
	else
		echo ""
	fi
}

# get current status of git repo
function parse_git_dirty {
	status=`git status 2>&1 | tee`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
	newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	bits=''
	if [ "${renamed}" == "0" ]; then
		bits=">${bits}"
	fi
	if [ "${ahead}" == "0" ]; then
		bits="*${bits}"
	fi
	if [ "${newfile}" == "0" ]; then
		bits="+${bits}"
	fi
	if [ "${untracked}" == "0" ]; then
		bits="?${bits}"
	fi
	if [ "${deleted}" == "0" ]; then
		bits="x${bits}"
	fi
	if [ "${dirty}" == "0" ]; then
		bits="!${bits}"
	fi
	if [ ! "${bits}" == "" ]; then
		echo " ${bits}"
	else
		echo ""
	fi
}

function colour_command {
{
   if [ "$?" == "0" ]; then
     echo -e '\e[0;32m➜  '
   else
     echo -e '\e[0;31m➜  '
   fi
 }
}

# PROMPT
  PS1='\[\033]0;\007\]' # set window title. why do I need this?
	PS1="$PS1"'`colour_command`\[\033[38;5;74;1m\]\w ${GITSTATUS_PROMPT} \[\e[m\]' 

#robby russell theme prompt
# export PS1="\[\e[32m\]➜  \[\e[m\]\[\e[36m\]\w\[\e[m\] \[\e[32m\]\`git_exist_first\`\[\e[31m\]\`parse_git_branch\`\[\e[32m\]\`git_exist_last\`\[\e[33m\]\`parse_git_status\`\[\e[m\] "
