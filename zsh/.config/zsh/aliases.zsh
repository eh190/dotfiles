#removes the need to type $ before variables
setopt cdablevars
#cd cdtvcore
cdtvcore=$HOME/Developer/mercuryDNIDiscovery/cd-tv-core
#cd stbclient
stbclient=$HOME/Developer/mercuryDNIDiscovery/cd-tv-client-discoveryplus-stb
#cd training
training=$HOME/Developer/training
#cd hwaclient
hwaclient=$HOME/Developer/mercuryDNIDiscovery/cd-tv-client-discoveryplus
#cd tennis tv
ttv=$HOME/Developer/cdtv

#links core repo to client repo
function linkcore() {
    cd cdtvcore
    yarn clean:deep && yarn && yarn build && lerna exec yarn link
    cd stbclient
    yarn clean:deep && yarn && ./update.sh && yarn dev
}    

#ALIASES
#launch chrome session with CORS enabled
alias runChromeCors='open -n -a /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --args --user-data-dir="/tmp/chrome_dev_test" --disable-web-security'

#TTV

#switch between java versions
alias java8='export JAVA_HOME=$JAVA_8_HOME'
alias java11='export JAVA_HOME=$JAVA_11_HOME'

#GIT
alias gs='git status'
alias gpo='git push origin'
alias gc='git checkout'

#runs the lightning ttv command. Pass platform as argument e.g.
#runttv lg
function runttv() {
    cd ttv 
    jiji lng.build --platform $1 --watch --open --dev
}

function resetttv() {
  git clean -xdf && make install && make common.build
}

#connects to firestick and launches android
#param is IP address of firestick and device (android or amazon) e.g. runFire 111.111.1.11 android
function runFire() {
  adb devices
  adb connect $1:5555
  cd ttv
  java11
  make native.$2
}

#gives some memory info on current connected device
#param is IP address or id of firestick e.g. runFire 111.111.1.11
function fireDump() {
  adb shell dumpsys meminfo com.tennistv.cdtv.local
}

#gives some memory info on current connected device
function memdump() {
  #gets the currentfocused process 
  output=$(adb shell dumpsys window windows | grep -E 'mCurrentFocus')

  #filters for env e.g. com.tennistv.dctv.local
  while IFS=' ' read -A args; do
    ident=${args[3]%/*}
  done <<<"$output"
  
  echo "*** Memory info for $ident ***"

  adb shell dumpsys meminfo $ident
}

#As above but specifically show pss
memdumppss() {
  output=$(adb shell dumpsys window windows | grep -E 'mCurrentFocus')

  while IFS=' ' read -A args; do
    ident=${args[3]%/*}
  done <<<"$output"
  
  pssline=$(adb shell dumpsys meminfo $ident | grep -E 'TOTAL SWAP PSS')

  while IFS=' ' read -A args; do
    pss=${args[2]}
  done <<<"$pssline"

  echo "Total PSS used by $ident: $pss"
}


# Gives colour to go tests
go_test() {
  go test $* | sed ''/PASS/s//$(printf "\033[32mPASS\033[0m")/'' | sed ''/SKIP/s//$(printf "\033[34mSKIP\033[0m")/'' | sed ''/FAIL/s//$(printf "\033[31mFAIL\033[0m")/'' | sed ''/FAIL/s//$(printf "\033[31mFAIL\033[0m")/'' | GREP_COLOR="01;33" egrep --color=always '\s*[a-zA-Z0-9\-_.]+[:][0-9]+[:]|^'
}

