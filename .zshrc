# Set up the prompt
autoload -Uz promptinit
promptinit
prompt adam1

setopt histignorealldups sharehistory

# Temporary custom aliases
alias cdrobot="cd ~/Program\ Architecture/simon/robotProject/src"
alias sshntnu="ssh evenlis@login.stud.ntnu.no"

# Permanent custom aliases
alias pm-hibernate='sudo pm-hibernate'
alias ls='ls -F --color=auto'
alias ll='ls -l --color=auto'
alias la='ls -a --color=auto'
alias l='ls -F --color=auto'
alias egrep='egrep --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias .......="cd ../../../../../.."
alias mkdir="mkdir -pv"
alias diff="colordiff"
alias wget="wget -c"
alias chrome="google-chrome"
alias zls="unzip -vl"
alias tls="tar -tvf"
alias tgzls="tar -ztvf"
alias tbz2ls="tar -jtvf"

# Use emacs keybindings even if the EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

#cdu(){
#    local arg_string=""
#       for ((i=1; i<=${#1}; i++)); do
#	arg_string="$arg_string../"
#    done
#    cd $arg_string
#}

mkdircd(){
    mkdir -p "$@" && eval cd "\"\$$#\"";
}

m() {
    echo $1 | bc -l
}

vga-off() {
    xrandr --output VGA-0 --off
}

vga-mirror(){
    xrandr --output HDMI-0 --auto --output VGA-0 --auto --same-as HDMI-0
}

vga-extend-right(){
    xrandr --output HDMI-0 --pos 0x0 --output VGA-0 --pos 1366x0
}

vga-extend-left(){
    xrandr --output HDMI-0 --pos 0x0 --output VGA-0 --pos -1920x0
}

vga-extend-above(){
    xrandr --output HDMI-0 --pos 0x0 --output VGA-0 --pos 0x-1080
}

vga-extend-below(){
    xrandr --output HDMI-0 --pos 0x0 --output VGA-0 --pos 0x768
}
