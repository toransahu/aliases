#alias ls='ls --color=auto'
#alias dir='dir --color=auto'
#alias vdir='vdir --color=auto'
#alias grep='grep --color=auto'
#alias fgrep='fgrep --color=auto'
#alias egrep='egrep --color=auto'

# some more ls aliases
#alias ll='ls -alF'
#alias la='ls -A'
#alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'



##
# application aliases
##

# git
alias gcm='git commit -m'
alias gits='git status'
alias gpull='export GIT_TEMP_BRANCH=$(git branch | grep \* | cut -d " " -f2) && git pull origin $GIT_TEMP_BRANCH && unset GIT_TEMP_BRANCH'
#alias gpush='export GIT_TEMP_BRANCH=$(git branch | grep \* | cut -d " " -f2) && git push origin $GIT_TEMP_BRANCH && unset GIT_TEMP_BRANCH'
gpush(){
    GIT_TEMP_BRANCH=$(git branch | grep \* | cut -d " " -f2)
    git push origin $GIT_TEMP_BRANCH $1
}
grdiff(){
    REMOTE='origin'
    if [ $1 ]; then REMOTE=$1; fi
    GIT_TEMP_BRANCH=$(git branch | grep \* | cut -d " " -f2)
    git diff $REMOTE/$GIT_TEMP_BRANCH $GIT_TEMP_BRANCH 
}
alias glogo='git log --graph --oneline'
alias glog='git log --graph'
alias gi.py='curl https://raw.githubusercontent.com/toransahu/gitignore/master/Python.gitignore -o .gitignore'
alias gi.go='curl https://raw.githubusercontent.com/toransahu/gitignore/master/Go.gitignore -o .gitignore'
alias gi.java='curl https://raw.githubusercontent.com/toransahu/gitignore/master/Java.gitignore -o .gitignore'
alias gitrepo='print -z "$(<~/.personalized/.gitrepo)"'
alias gch='git checkout'
alias ghtokencpy='cat $ME/recovery/github-access-token.txt | cpy'
alias gbd='export GIT_TEMP_BRANCH=$(git branch | grep \* | cut -d " " -f2) && git checkout master && git branch -d $GIT_TEMP_BRANCH && unset GIT_TEMP_BRANCH'
gbdf(){
    BRANCH_NAME=${1:-$(git branch | grep \* | cut -d " " -f2)}
    export GIT_TEMP_BRANCH=$BRANCH_NAME
    git checkout master 
    git branch -D $GIT_TEMP_BRANCH 
    unset GIT_TEMP_BRANCH
}
alias gls='git log --stat --pretty=fuller'
alias gfa='git fetch --all'
alias master='git checkout master'
alias gdiff='git diff'
alias gcom='git commit -m'
alias gprom='git pull --rebase origin master'
alias gchr='git checkout --track'
gfb(){
    git checkout --track origin/$1
}
gri(){
    git rebase -i HEAD~$1
}
gclone(){
if [ "$2" = -http ]; then
    git clone https://github.com/$1.git
else
    git clone git@github.com:$1.git
fi
}
gsize(){
    #curl https://api.github.com/repos/$1/$2 | grep size
    if [ "$3" = -a ]; then
        curl -u toransahu -s https://api.github.com/repos/$1/$2 | \
        python -c 'import sys, json; size = json.load(sys.stdin)["size"]; print(size/1024, "Mb") if(size>=1024)  else print(size, "Kb")'
    else
        curl -s https://api.github.com/repos/$1/$2 | \
        python -c 'import sys, json; size = json.load(sys.stdin)["size"]; print(size/1024, "Mb") if(size>=1024)  else print(size, "Kb")'
    fi
}

grepo(){
    echo "Creating repo $1"
    python ~/.personalized/.gitrepo.py $1
    echo "Done."
}

ghrepo(){
    curl -H "Content-Type: application/json" -POST https://api.github.com/user/repos -d "{\"name\":\""$1"\", \"private\":"$2"}" -u toransahu
}

# utils
alias pdf='evince'
alias cpy='python -c "import sys; data = sys.stdin.read(); print(data.strip(), end=\"\")" | xclip -sel clip'
alias ls='ls -ltrhFa'
alias t='gnome-terminal'
alias terminal='gnome-terminal'

# dir ops
alias ls='ls -la'
alias lsA='ls -A'
alias lsa='ls -a'
alias rdi='rmdir --ignore-fail-on-non-empty '

# personalized dir ops
alias cdd='cd $DROOT/'
alias cdw='cd $WORKSPACE/'
alias cdm='cd $ME/'
alias cdresume='cd $ME/resume'
alias cde='cd $EROOT'

# coding related
alias pgadmin4='. ~/.virtualenvs/pgadmin4/bin/activate &&  sudo python3 ~/.virtualenvs/pgadmin4/lib/python2.7/site-packages/pgadmin4/pgAdmin4.py'

alias pe='pipenv'
alias pes='pipenv shell'
alias djangodev='. ~/.virtualenvs/djangodev/bin/activate'
alias pycharm='$EROOT/sw/pycharm/pycharm-community-2018.1/bin/pycharm.sh $1'
alias anaconda='. ~/anaconda3/bin/activate'
alias miniconda='. ~/miniconda3/bin/activate'
alias winconda='. /c/ProgramData/Miniconda3/Scripts/activate'
alias django='. ~/.virtualenvs/djangovenv/bin/activate'
alias flaskvenv='. ~/.virtualenvs/flaskvenv/bin/activate'
#eval $(thefuck --alias)
mvnnew(){
     ~/.personalized/mvn_create_project.sh $1 $2
}

# routine jobs
alias bak='$ME/linux-tweaks/scripts/backup_confs.sh'
alias bkp=bak
alias res='$ME/linux-tweaks/scripts/restore_confs.sh'
alias bashrc-bkp='cp ~/.bashrc $ME/linux-tweaks/bashrc-bkp/mint/'

##
# functions
##

# syntax: aliasit command_alias='command'
aliasit()
{
    echo "alias $1='$2'" >> ~/.bash_aliases

    if [ $SHELL=='/usr/bin/zsh' ]; then
        . ~/.zshrc;
    else
        . ~/.bashrc;
    fi

    echo "[Alias Created:] alias $1='$2'";
}

alias hdp='sudo hdparm -q -S 120 -Y /dev/sda'
alias zbinon='subst z: /g/toran/E/workspace/zbin'
alias zbin='subst z: /g/toran/E/workspace/zbin'
alias zbinoff='subst /D z:'
alias rmbuild='rm -r build dist *.egg-info'
alias cdl='cd $ME/linux-tweaks'

alias installvundle='git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim'
alias installohmyzsh='sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"'
alias fixcinnamon='export DISPLAY=:0; cinnamon --replace &'
alias installsublime='sh -c "~/.personalized/installsublime.sh"'
alias pm='python manage.py'
alias cdss='cd $ME/ss'
alias cdgi='$ME/gitignore'
alias show='less +F'
alias cdo='cd $OFFICE'
alias cleardns='sudo /etc/init.d/networking restart'
alias clearswap='sudo swapoff -a && sudo swapon -a'
alias freeswap='sudo swapoff -a && sudo swapon -a'
alias uninstall-go='sudo rm -rvf /usr/local/go/'
alias cdgo='cd $GOPATH/src/'
alias cdgopkg='cd $GOPATH/pkg/'
alias cdgobin='cd $GOPATH/bin/'
alias gpager-vim='git config --global core.pager "vim -"'
alias gpager-less='git config --global core.pager "less"'
alias vim-mode-on='set -o vi'
alias vim-mode-off='set -o emacs'
alias cdt='cd ~/tmp'
gomsync() {
    for i in "$@"
    do 
        case $i in
            -p|--populate)
                local POPULATE="Y"
                ;;
            -d|--delete)
                local DELETE_VENDOR="Y"
                ;;
            *)
                echo "\nUnknown Command!"
                ;;
        esac
    done
    if [ "$POPULATE" = "Y" ]; then
        gom populate
        echo "\nPopulated.." 
    fi
    rsync -r _vendor/src $GOPATH
    echo "Synced.."
    if [ "$DELETE_VENDOR" = "Y" ]; then 
        rm -rf _vendor
        echo "Deleted.."
    fi
}
alias todo='vim ~/TODO.md'
alias reload='. ~/.zshrc'
alias m='gch master'
alias epoch='date +%s'
alias glistall='git for-each-ref --format=" %(authorname) %09 %(refname)" --sort=authorname'
alias pyfmt='black -l 120'
alias freeram='sudo $ME/linux-tweaks/scripts/freeram.sh'
alias cdgnoi='cd $GOPATH/src/github.com/mistsys/mist-openconfig-gnoi'
alias cdlb='cd $ME/linux-tweaks/backups'
alias tpnum='tmux bind Left select-pane -L \; display-pane -d 5000'
alias tmux='tmux -u'
alias tks='tmux kill-server'
alias cdp='cd $ME/post-linux-install'

gcdiff(){
    GIT_TEMP_BRANCH=$(git branch | grep \* | cut -d " " -f2)
    if [[ -z "$1" ]] 
    then
        COMMENT="_$1"
    fi
    COMMENT="_$1"
    STAMP="$(date +"%Y-%m-%d-%I:%M:%S")"
    mkdir -p .diff
    git diff > .diff/${GIT_TEMP_BRANCH}${COMMENT}_${STAMP}.diff
}
alias cdgog='cd $GOPATH/src/github.com'
alias night='xdotool key Shift+F10 r Down  Down Down Return'
alias day='xdotool key Shift+F10 r Down  Return'
alias freeaptcache='sudo apt-get clean'
alias eshead='cd $WORKSPACE/elasticsearch-head && npm run start & sleep 2s && firefox http://localhost:9100'
alias eshead-stop='pkill grunt > /dev/null'

# TODO: whoisusingport :port -> kill that service
alias gchp='git cherry-pick'
alias mmdc='~/node_modules/.bin/mmdc'
alias myip='echo $MY_IP_ADDR'

# k8s (kubernetes)
k8s-ssh() {
    namespace=$1
    pod=$(kubectl get pods --all-namespaces | grep "^$namespace .*" | awk 'NR==1 {print $2}')
    kubectl -n $namespace exec -it $pod -- /bin/bash
}

k8s-log() {
    namespace=$1
    app=$2
    app=${app:-$namespace}
    # kubectl logs --max-log-requests 8 -n $namespace -l app=$app -f
    # kubectl logs -n $namespace -l app=$app -f --max-log-requests=40
    kubectl -n $namespace logs -f deployment/$app --all-containers=true
}

join_by() {
  local d=${1-} f=${2-}
  if shift 2; then
    printf %s "$f" "${@/#/$d}"
  fi
}

get_var() {
    temp=$(join_by _ $@)
    eval "echo \$$temp"
}

var() {
    ~/.personalized/parse_envvars.py --cmd=var $@ 
    exec zsh
}

unvar() {
    ~/.personalized/parse_envvars.py --cmd=unvar $@
    exec zsh
}

alias k8s-list-context='kubectl config view -o jsonpath="{.contexts[*].name}" | tr " " "\n"'

alias dedupe-hist='python $ME/linux-tweaks/scripts/dedupe_sh_history.py'
alias bak-hist='dedupe-hist && cp ~/.bash_history $ME/secret/self'
alias res-hist='cp $ME/secret/self/.bash_history ~/.bash_history'
alias calc='gnome-calculator'
alias lsvenvs='ls $HOME/.local/share/virtualenvs'
alias fcompiled='find . | grep -E "(__pycache__|\.pyc|\.pyo|\.swo|\.swp$)"'

extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)        tar xjf $1        ;;
            *.tar.gz)         tar xzf $1        ;;
            *.bz2)            bunzip2 $1        ;;
            *.rar)            unrar x $1        ;;
            *.gz)             gunzip $1         ;;
            *.tar)            tar xf $1         ;;
            *.tar.xz)         tar xf $1         ;;
            *.tbz2)           tar xjf $1        ;;
            *.tgz)            tar xzf $1        ;;
            *.zip)            unzip $1          ;;
            *.Z)              uncompress $1     ;;
            *.7z)             7zr e $1          ;;
            *)                echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

t-childof () {
    APPS_TO_CLOSE=$1
    for app in $APPS_TO_CLOSE; do
        pids=$(pidof $app | awk '{$NF=""; print $0}')  # kill subtasks
        echo $pids
    done
}

now() {
    zone=$1
    if [ -z "$1" ]; then
        echo $(date +%s) | xargs -I {} sh -c "echo {} && date -d @{} &&  TZ=GMT date -d @{}"
    else
        echo $(date +%s) | xargs -I {} sh -c "echo {} &&  TZ=$zone date -d @{} && date -d @{} &&  TZ=GMT date -d @{}"
    fi
}
epoch_at() {
    epoch=$1
    echo $epoch
    echo $(date -d @$epoch +"%G-%m-%dT%H:%M:%S.%3N%z %Z")
    echo $(TZ=GMT date -d @$epoch +"%G-%m-%dT%H:%M:%S.%3N%z %Z")
}
iso_to_epoch_simple() {
    zone=$2
    if [ -z "$2" ]; then
        epoch=$(date -d "$1" +"%s")
    else
        epoch=$(TZ=$zone date -d "$1" +"%s")
    fi
    echo $epoch
}
iso_to_epoch() {
    zone=$2
    if [ -z "$2" ]; then
        epoch=$(date -d "$1" +"%s.%3N")
    else
        epoch=$(TZ=$zone date -d "$1" +"%s.%3N")
    fi
    echo $epoch
}
iso_at() {
    epoch_at $(iso_to_epoch $@)
}
time_at() {
    if [[ $@ == *":"*  ]]; then
        iso_at $@
    else
        epoch_at $@
    fi
}
alias curl-fmt='curl -w @/home/toransahu/.personalized/curl.format'

urlencode() {
    # urlencode <string>

    old_lc_collate=$LC_COLLATE
    LC_COLLATE=C

    local length="${#1}"
    for (( i = 0; i < length; i++ )); do
        local c="${1:$i:1}"
        case $c in
            [a-zA-Z0-9.~_-]) printf '%s' "$c" ;;
            *) printf '%%%02X' "'$c" ;;
        esac
    done

    LC_COLLATE=$old_lc_collate
}

urldecode() {
    # urldecode <string>

    local url_encoded="${1//+/ }"
    printf '%b' "${url_encoded//%/\\x}"
}

dashed_mac() {
    res=$(python3 -c "import sys; data = sys.stdin.read(); mac=data.strip(); print('-'.join([f'{mac[i]}{mac[i+1]}' for i in range(0, len(mac), 2)]))")
    echo $res
}

alias es-sql-cli='sudo /usr/share/elasticsearch/bin/elasticsearch-sql-cli'
alias gcz='git cz'
alias cdn='cd $ME/notes'
alias gd='git diff'
alias ga='git add'
alias mypubip='dig +short myip.opendns.com @resolver1.opendns.com'
