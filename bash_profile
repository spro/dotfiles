alias ip="ifconfig | grep 'inet '"

export CLICOLOR=1
export LSCOLORS=dxfxcxdxbxegedabagacad
export PS1="\[\e[0;36m\]\u@\h:\[\e[m\] \[\e[4;32m\]\w\[\e[m\] \[\e[0;31m\]#\[\e[m\] "
export GREP_OPTIONS='--exclude="*\.svn*" --color'

export JAVA_HOME="/System/Library/Frameworks/JavaVM.framework/Home"

# Your previous .profile  (if any) is saved as .profile.dpsaved
# Setting the path for DarwinPorts.
export PATH=$HOME/Programming/Java/android-sdk-mac_86/tools:$HOME/Programming/Java/android-sdk-mac_86/platform-tools::$HOME/.bin:/opt/local/bin:/opt/local/sbin:$HOME/local/node/bin:$PATH
export PYTHONPATH=$HOME/Projects:$HOME/Projects/sasa:$HOME/.python:$PYTHONPATH

export STELLIS=~/Programming/Python/Stellis
alias now='date +%Y%m%d%H%M%S'

# Bash Directory Bookmarks
alias m1='alias g1="cd `pwd`"'
alias m2='alias g2="cd `pwd`"'
alias m3='alias g3="cd `pwd`"'
alias m4='alias g4="cd `pwd`"'
alias m5='alias g5="cd `pwd`"'
alias m6='alias g6="cd `pwd`"'
alias m7='alias g7="cd `pwd`"'
alias m8='alias g8="cd `pwd`"'
alias m9='alias g9="cd `pwd`"'
alias g0='cd $HOME'
alias mdump='alias|grep -e "alias g[0-9]"|grep -v "alias m" > ~/.bookmarks'
alias lma='alias | grep -e "alias g[0-9]"|grep -v "alias m"|sed "s/alias //"'
touch ~/.bookmarks
source ~/.bookmarks
