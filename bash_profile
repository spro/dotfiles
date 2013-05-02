alias itsmyurls_web_0="ssh -i ~/Projects/itsmyurls/.ssh/itsmyurls.pem ec2-user@23.21.40.45"
alias itsmyurls_db_0="ssh -i ~/Projects/itsmyurls/.ssh/itsmyurls.pem ec2-user@ec2-184-72-192-158.compute-1.amazonaws.com"
alias itsmyurls_db_1="ssh -i ~/Projects/itsmyurls/.ssh/itsmyurls.pem ec2-user@ec2-50-16-91-199.compute-1.amazonaws.com"

export LC_ALL=en_US.utf-8 
export LANG="$LC_ALL" 

alias troll=/Users/sean/Programming/Java/Workspace/TrollaroidDesktop/src/go

alias ip="ifconfig | grep 'inet '"

export ECHO_NEST_API_KEY="SUOTSZA5V4ANPMW7C"
export CLICOLOR=1
export LSCOLORS=dxfxcxdxbxegedabagacad
export PS1="\[\e[0;36m\]\u@\h:\[\e[m\] \[\e[4;32m\]\w\[\e[m\] \[\e[0;31m\]#\[\e[m\] "
export GREP_OPTIONS='--exclude="*\.svn*" --color'

export JAVA_HOME="/System/Library/Frameworks/JavaVM.framework/Home"
export EC2_HOME="/usr/local/Cellar/ec2-api-tools/1.4.2.2/jars"
export EC2_USGD_ID="/Users/sean/.ssh/id_rsa-usgd_0"
export EC2_TROLLAROID_ID="/Users/sean/.ssh/trollaroid_key_0.pem"
export EC2_HJKLIST_ID="/Users/sean/.ssh/hjklist_key_0.pem"
export EC2_USER="ec2-user"

export EC2_USGD_WEB_0="ec2-107-20-148-116.compute-1.amazonaws.com"
export EC2_USGD_MONGODB_0="ec2-50-17-144-154.compute-1.amazonaws.com"
export EC2_USGD_REPORTS_0="ec2-67-202-60-151.compute-1.amazonaws.com"

export EC2_TROLLAROID_WEB_0="ec2-107-20-234-122.compute-1.amazonaws.com"
export EC2_TROLLAROID_API_0="ec2-174-129-57-74.compute-1.amazonaws.com"
export EC2_TROLLAROID_API_1="ec2-23-20-248-159.compute-1.amazonaws.com"
export EC2_TROLLAROID_DB_0="ec2-184-73-30-102.compute-1.amazonaws.com"
export EC2_TROLLAROID_DB_1="ec2-23-21-20-64.compute-1.amazonaws.com"
export EC2_TROLLAROID_WIKI_0="ec2-174-129-98-151.compute-1.amazonaws.com"

export EC2_HJKLIST_WEB_0="ec2-23-23-231-108.compute-1.amazonaws.com"
export EC2_HJKLIST_DB_0="ec2-107-20-17-67.compute-1.amazonaws.com"

alias usgd_web_0="ssh -i $EC2_USGD_ID $EC2_USER@$EC2_USGD_WEB_0"
alias usgd_mongodb_0="ssh -i $EC2_USGD_ID $EC2_USER@$EC2_USGD_MONGODB_0"
alias usgd_reports_0="ssh -i $EC2_USGD_ID $EC2_USER@$EC2_USGD_REPORTS_0"

alias sc_test_0="ssh -i $EC2_USGD_ID $EC2_USER@ec2-107-20-14-254.compute-1.amazonaws.com"

alias trollaroid_web_0="ssh -i $EC2_TROLLAROID_ID $EC2_USER@$EC2_TROLLAROID_WEB_0"
alias trollaroid_api_0="ssh -i $EC2_TROLLAROID_ID $EC2_USER@$EC2_TROLLAROID_API_0"
alias trollaroid_api_1="ssh -i $EC2_TROLLAROID_ID $EC2_USER@$EC2_TROLLAROID_API_1"
alias trollaroid_db_0="ssh -i $EC2_TROLLAROID_ID $EC2_USER@$EC2_TROLLAROID_DB_0"
alias trollaroid_db_1="ssh -i $EC2_TROLLAROID_ID $EC2_USER@$EC2_TROLLAROID_DB_1"
alias trollaroid_wiki_0="ssh -i $EC2_TROLLAROID_ID $EC2_USER@$EC2_TROLLAROID_WIKI_0"

alias hjklist_web_0="ssh -i $EC2_HJKLIST_ID $EC2_USER@$EC2_HJKLIST_WEB_0"
alias hjklist_db_0="ssh -i $EC2_HJKLIST_ID $EC2_USER@$EC2_HJKLIST_DB_0"

alias usgd_webfaction="ssh usgreendata@usgreendata.webfactional.com"

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
