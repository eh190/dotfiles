#removes the need to type $ before variables
setopt cdablevars

# If work_aliases exist, source them here, else no worries
[[ -f $ZDOTDIR/work_aliases.zsh ]] && . $ZDOTDIR/work_aliases.zsh 

#launch chrome session with CORS enabled
alias corsChrome='open -n -a /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --args --user-data-dir="/tmp/chrome_dev_test" --disable-web-security'

#switch between java versions
alias java8='export JAVA_HOME=$JAVA_8_HOME'
alias java11='export JAVA_HOME=$JAVA_11_HOME'

# Git
alias gs='git status'
alias gpo='git push origin'
alias gc='git checkout'

# fzf
alias ff='find * -type f | fzf | xargs nvim' # prints the file name to stdout

# Gives colour to go tests
go_test() {
  go test $* | sed ''/PASS/s//$(printf "\033[32mPASS\033[0m")/'' | sed ''/SKIP/s//$(printf "\033[34mSKIP\033[0m")/'' | sed ''/FAIL/s//$(printf "\033[31mFAIL\033[0m")/'' | sed ''/FAIL/s//$(printf "\033[31mFAIL\033[0m")/'' | GREP_COLOR="01;33" egrep --color=always '\s*[a-zA-Z0-9\-_.]+[:][0-9]+[:]|^'
}

